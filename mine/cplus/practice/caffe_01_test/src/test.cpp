#include "test.h"

#include <iostream> 

#include <glog/logging.h>
#include <gflags/gflags.h>
#include <caffe/util/db.hpp>
#include <caffe/util/format.hpp>
#include <caffe/proto/caffe.pb.h>

DEFINE_string(db_path, "../data/pointCloud.ldb", "Leveldb path.");
DEFINE_string(label_path, "/media/yangkai04/SSD/data/PointCloud_train_data_0711/groundtruth/result.txt", "Label file path.");
DEFINE_string(pcd_path_prefix, "/media/yangkai04/SSD/data/PointCloud_train_data_0711/original_cloud/", "pcd file path prefix.");

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
    int inner_main(int argc, char *argv[]) {
#endif
    google::ParseCommandLineFlags(&argc, &argv, true);
    if (FLAGS_db_path.empty()) {
        std::cout << "db_path empty error." << std::endl;
        return 1;
    }
    if (FLAGS_label_path.empty()) {
        std::cout << "label_path empty error." << std::endl;
        return 1;
    }
    std::unique_ptr<caffe::db::DB> db(caffe::db::GetDB("leveldb"));
    db->Open(FLAGS_db_path, caffe::db::NEW);
    caffe::Datum datum;
    datum.set_channels(11);
    datum.set_width(40);
    datum.set_height(40);

    std::string line;
    std::ifstream read_file(FLAGS_label_path, std::ios::in);
    while(getline(read_file, line)) {
        std::cout << line << std::endl;
    }
    read_file.close();
    return 0;
}
