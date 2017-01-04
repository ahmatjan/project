#include <gflags/gflags.h>
#include <glog/logging.h>
#include <caffe/proto/caffe.pb.h>
#include <caffe/util/db.hpp>
#include <caffe/util/format.hpp>

#include "file_util.h"
#include "object_set.h"

using std::string;
using std::vector;
using std::map;

DEFINE_string(db_path, "../data/", "Leveldb path.");
DEFINE_string(label_path_prefix , "/media/yangkai04/SSD/data/PointCloud_train_data_0711/groundtruth", "Label data path prefix.");
DEFINE_string(label_file, "result.txt", "Label data file.");
DEFINE_int32(object_type, -1, "Object type to save.");

const int NUM_LINES_PER_READ = 100;

int main(int argc, char *argv[]) {
    google::ParseCommandLineFlags(&argc, &argv, true);
    google::InitGoogleLogging(argv[0]);
    google::SetLogDestination(google::GLOG_INFO,"./log.log"); 

    if (FLAGS_db_path.empty()) {
        LOG(ERROR) << "FLAGS_db_path empty.";
        return 1;
    }
    string label_path = FLAGS_label_path_prefix + "/" + FLAGS_label_file;
    vector<string> lines;
    if (!FileUtil::read_lines(label_path, &lines)) {
        LOG(ERROR) << "Failed to open label_path: " << label_path;
        return 1;
    }
    LOG(INFO) << "read label_path: " << label_path << " num_lines: " << lines.size();

    std::unique_ptr<caffe::db::DB> db(caffe::db::GetDB("leveldb"));
    db->Open(FLAGS_db_path, caffe::db::NEW);
    caffe::Datum datum;
    datum.set_channels(11);
    datum.set_width(40);
    datum.set_height(40);
    vector<float> features;
    int num_objects = 0;
    map<string, int> type_counter;
    for (size_t idx = 0; idx < lines.size(); idx += NUM_LINES_PER_READ) {
        size_t start = idx;
        size_t end = start + NUM_LINES_PER_READ > lines.size() ? lines.size() : start + NUM_LINES_PER_READ;
        LOG(INFO) << "Processing lines: [" << start << ", " << end << ").";
        vector<string> sub_lines(lines.begin() + start, lines.begin() + end);
        ObjectSet object_set;
        if (!object_set.load_from_memory(FLAGS_label_path_prefix, sub_lines)) {
            LOG(INFO) << "Failed to processing lines: [" << start << ", " << end << ").";
            return 1;
        }

        vector<Object> objects;
        std::unique_ptr<caffe::db::Transaction> transaction(db->NewTransaction());
        object_set.get_all_objects(&objects);
        for (size_t obj_idx = 0; obj_idx < objects.size(); ++obj_idx) {
            auto& obj = objects[obj_idx];
            if (FLAGS_object_type > 0 && FLAGS_object_type != obj.type) {
                continue;
            }

            type_counter[obj.type_name]++;
            features.clear();
            object_set.compute_features(obj, &features);

            datum.set_label(obj.type);
            datum.clear_float_data();
            for (size_t fidx = 0; fidx < features.size(); ++fidx) {
                datum.add_float_data(features[fidx]);
                if (std::isinf(features[fidx])) {
                    LOG(ERROR) << "features: "  << fidx << " is inf. obj: " << obj.to_string();
                    return 1;
                }
            }
            CHECK_GT(datum.float_data_size(), 0);

            string value;
            CHECK(datum.SerializeToString(&value));
            string key = std::to_string(num_objects);
            transaction->Put(key, value);
            if (num_objects % 50 == 0) {
                transaction->Commit();
                LOG(INFO) << "Put num_records: " << num_objects;
            }
            ++num_objects;
        }
        transaction->Commit();
    }

    db->Close();
    LOG(INFO) << "Process num_objects: " << num_objects;
    for (auto& pair : type_counter) {
        LOG(INFO) << pair.first << ": " << pair.second;
    }

    return 0;
}
