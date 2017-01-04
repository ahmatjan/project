#include "object_set.h"


//using base::FileUtil;
//using base::StringUtil;
//using pcl_util::Point;
//using pcl_util::PointXYZIT;
//using pcl_util::PointCloud;
//using pcl_util::PointCloudPtr;
//using pcl_util::crop_point_cloud;
using std::string;
using std::vector;

bool ObjectSet::load_from_memory(const string& pcd_prefix, const vector<string>& lines) {
    _all_objects.clear();
    _all_objects.resize(lines.size());
    #pragma omp parallel for
    for (size_t line_idx = 1; line_idx < lines.size(); ++line_idx) {
        vector<string> fields;
        StringUtil::explode(lines[line_idx], '\t', &fields);
        if (fields.size() != 4u) {
            LOG(WARNING) << "Invalid line: " << lines[line_idx];
            continue;
        }
        string pcd_path = pcd_prefix + "/" + fields[2];
        pcl::PointCloud<PointXYZIT> raw_pc;
        if (pcl::io::loadPCDFile(pcd_path, raw_pc) < 0) {
            LOG(WARNING) << "Failed to load pcd_path: " << pcd_path;
            continue;
        }

        PointCloudPtr pc(new PointCloud);
        pc->points.resize(raw_pc.size());
        for (size_t point_idx = 0; point_idx < raw_pc.size(); ++point_idx) {
            auto& point = (*pc)[point_idx];
            point.x = raw_pc[point_idx].x;
            point.y = raw_pc[point_idx].y;
            point.z = raw_pc[point_idx].z;
        }
        vector<Object> objects;
        parse_objects(pc, fields[3], &objects);
        _all_objects[line_idx] = objects;
        // num_objects += objects.size();
        LOG(INFO) << "Process line: " << line_idx << " num_objects: " << objects.size();
    }
    int num_objects = 0;
    for (auto& objects : _all_objects) {
        num_objects += objects.size();
    }
    LOG(INFO) << "ObjectSet load num_frames: " << _all_objects.size()
              << " num_objects: " << num_objects;
    return true;
}

bool ObjectSet::load_from_file(const string& pcd_prefix, const string& label_file) {
    string label_path = pcd_prefix + label_file;
    vector<string> lines;
    if (!FileUtil::read_lines(label_path, &lines)) {
        LOG(ERROR) << "Failed to open label_path: " << label_path;
        return false;
    }
    LOG(INFO) << "read label_path: " << label_path << " num_lines: " << lines.size();
    return load_from_memory(pcd_prefix, lines);
}

void ObjectSet::get_all_objects(vector<Object>* objects) {
    for (size_t idx = 0; idx < _all_objects.size(); ++idx) {
        objects->insert(objects->end(),
                _all_objects[idx].begin(),
                _all_objects[idx].end());
    }
}

void ObjectSet::parse_objects(
        const PointCloudPtr& pc,
        const string& json_str,
        vector<Object>* objects) {

    Json::Reader reader;
    Json::Value root;
    if (!reader.parse(json_str, root)) {
        LOG(WARNING) << "Failed to parse json: " << json_str;
        return;
    }
    int num_objects = root["numberBox"].asInt();
    // CHECK_EQ(num_objects, root["result"].size());
    if (num_objects != root["result"].size()) {
        num_objects = root["result"].size();
        LOG(ERROR) << "num_objects != root['numberBox'].asInt.";
    }
    Json::Value result = root["result"];
    for (int idx = 0; idx < num_objects; ++idx) {
        Object obj;
        obj.type_name = result[idx]["type"].asString();
        obj.type = parse_object_type(obj.type_name);
        if (obj.type == INVALID) {
            continue;
        }
        obj.yaw = strtod(result[idx]["rotation"]["phi"].asString().c_str(), NULL);
        obj.x = strtod(result[idx]["position"]["x"].asString().c_str(), NULL);
        obj.y = strtod(result[idx]["position"]["y"].asString().c_str(), NULL);
        obj.z = strtod(result[idx]["position"]["z"].asString().c_str(), NULL);
        obj.length = strtod(result[idx]["size"][0].asString().c_str(), NULL);
        obj.width = strtod(result[idx]["size"][1].asString().c_str(), NULL);
        obj.height = strtod(result[idx]["size"][2].asString().c_str(), NULL);
        // Crop point cloud.
        Eigen::Vector4f min_p(-obj.length / 2, -obj.width / 2, -obj.height / 2, 1.0);
        Eigen::Vector4f max_p(obj.length / 2, obj.width / 2, obj.height / 2, 1.0);
        Eigen::Vector3f translation;
        translation[0] = obj.x;
        translation[1] = obj.y;
        translation[2] = obj.z;
        Eigen::Vector3f rotation(0, 0, obj.yaw);
        obj.cloud.reset(new PointCloud);
        crop_point_cloud(pc, max_p, min_p, translation, rotation, obj.cloud);
        if (obj.cloud->size() < 4u) {
            LOG(ERROR) << "obj.cloud.size() < 4u, so ignore it. obj: " << obj.to_string();
            continue;
        }
        objects->push_back(obj);
        VLOG(2) << "object: " << obj.to_string();
    }
}

ObjectType ObjectSet::parse_object_type(const string& type_name) {
    if (type_name == "unknow") {
        return UNKNOWN;
    } else if (type_name == "smallMot" || type_name == "midMot") {
        return SMALL_MOT;
    } else if (type_name == "pedestrian") {
        return PEDESTRIAN;
    } else if (type_name == "bigMot") {
        return BIG_MOT;
    } else if (type_name == "nonMot") {
        return NON_MOT;
    } else {
        // CHECK(false) << "Invalid object_type: " << type_name;
        LOG(ERROR) << "Invalid object_type: " << type_name;
        return INVALID;
    }
}

void ObjectSet::compute_features(const Object& obj, vector<float>* features) {
    const int channels = 11;
    const int height = 40;
    const int width = 40;
    FeatureDescriptor feature_descriptor(obj.cloud);
    feature_descriptor.compute_multi_channel_height_map(
            channels, height, width, features);
}

