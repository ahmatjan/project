#include <stdlib.h>

#include <sstream>
#include <string>
#include <vector>

#include <Eigen/Core>
#include <gflags/gflags.h>
#include <glog/logging.h>
#include <json/json.h>
#include <pcl/visualization/pcl_visualizer.h>

#include "macros.h"
#include "file_util.h"
#include "pcd_file_util.h"
#include "pcl_util.h"
#include "string_util.h"

DEFINE_string(pcd_prefix, "/media/yangkai04/SSD/data/PointCloud_train_data_0711/groundtruth", "");
DEFINE_string(label_file, "result.txt", "");

using std::string;
using std::vector;

struct Object {
    double x = 0;
    double y = 0;
    double z = 0;
    double length = 0;
    double width = 0;
    double height = 0;
    double yaw = 0.0;
    string type;
    std::string to_string() {
        std::ostringstream oss; 
        oss << "x: " << GLOG_DOUBLE(x) << " y: " << GLOG_DOUBLE(y)
            << " z: " << GLOG_DOUBLE(z) << " length: " << GLOG_DOUBLE(length)
            << " width: " << GLOG_DOUBLE(width) << " height: " << GLOG_DOUBLE(height)
            << " yaw: " << GLOG_DOUBLE(yaw) << " type: " << type;
        return oss.str();
    }
};

void parse_objects(const string& json_str, vector<Object>* objects) {
    Json::Reader reader;
    Json::Value root;
    if (!reader.parse(json_str, root)) {
        LOG(WARNING) << "Failed to parse json: " << json_str;
        return; 
    }
    int num_objects = root["numberBox"].asInt();
    CHECK_EQ(num_objects, root["result"].size());
    Json::Value result = root["result"];
    for (int idx = 0; idx < num_objects; ++idx) {
        Object obj;
        obj.type = result[idx]["type"].asString();
        obj.yaw = strtod(result[idx]["rotation"]["phi"].asString().c_str(), NULL); 
        obj.x = strtod(result[idx]["position"]["x"].asString().c_str(), NULL);
        obj.y = strtod(result[idx]["position"]["y"].asString().c_str(), NULL);
        obj.z = strtod(result[idx]["position"]["z"].asString().c_str(), NULL);
        obj.length = strtod(result[idx]["size"][0].asString().c_str(), NULL);
        obj.width = strtod(result[idx]["size"][1].asString().c_str(), NULL);
        obj.height = strtod(result[idx]["size"][2].asString().c_str(), NULL);
        LOG(INFO) << "object: " << obj.to_string();
        objects->push_back(obj);
    }
}

int main(int argc, char **argv) {
    google::ParseCommandLineFlags(&argc, &argv, true);

    pcl::visualization::PCLVisualizer viewer;
    viewer.addCoordinateSystem(2.0);

    string label_path = FLAGS_pcd_prefix + "/" + FLAGS_label_file;
    vector<string> lines;
    if (!FileUtil::read_lines(label_path, &lines)) {
        LOG(ERROR) << "Failed to open label_path: " << label_path;
        return 1;
    }
    LOG(INFO) << "read label_path: " << label_path << " num_lines: " << lines.size();
    // Skip line 0.
    for (size_t idx = 1; idx < lines.size(); ++idx) {
        vector<string> fields;
        StringUtil::explode(lines[idx], '\t', &fields);
        if (fields.size() != 4u) {
            LOG(WARNING) << "Invalid line: " << lines[idx];
            continue;
        }
        string pcd_path = FLAGS_pcd_prefix + "/" + fields[2];
        pcl::PointCloud<PointXYZIT> pc;
        if (pcl::io::loadPCDFile(pcd_path, pc) < 0) {
            LOG(WARNING) << "Failed to load pcd_path: " << pcd_path; 
            continue;
        }
        PointCloudPtr pc2(new PointCloud);
        pc2->points.resize(pc.size());
        for (size_t pc_idx = 0; pc_idx < pc.size(); ++pc_idx) {
            auto& point = (*pc2)[pc_idx];
            point.x = pc[pc_idx].x;
            point.y = pc[pc_idx].y;
            point.z = pc[pc_idx].z;
        }

        string pc_id = "pc_" + std::to_string(idx);
        viewer.removeAllPointClouds();
        viewer.removeAllShapes();
        viewer.addPointCloud<Point>(pc2, pc_id, 0);

        vector<Object> objects;
        parse_objects(fields[3], &objects);
        for (size_t obj_idx = 0; obj_idx < objects.size(); ++obj_idx) {
            const Object& obj = objects[obj_idx];
            Eigen::Vector3f translation;
            translation[0] = obj.x;
            translation[1] = obj.y;
            translation[2] = obj.z;
            Eigen::Quaternionf rotation = Eigen::Quaternionf(
                                Eigen::AngleAxisf(obj.yaw, Eigen::Vector3f::UnitZ()));
            std::string viewer_id = "seg_" + std::to_string(idx) + "_" + std::to_string(obj_idx);
            viewer.addCube(translation, rotation, obj.length, obj.width, obj.height, viewer_id);
            Point p;
            p.x = obj.x;
            p.y = obj.y;
            p.z = obj.z;
            std::string text_id = "text_" + std::to_string(idx) + "_" + std::to_string(obj_idx);
            viewer.addText3D(obj.type, p, 0.4, 255, 0, 0, text_id);

            PointCloudPtr object_cloud(new PointCloud);
            Eigen::Vector4f min_p(-obj.length / 2, -obj.width / 2, -obj.height / 2, 1.0);
            Eigen::Vector4f max_p(obj.length / 2, obj.width / 2, obj.height / 2, 1.0);
            Eigen::Vector3f t2;
            t2[0] = obj.x;
            t2[1] = obj.y;
            t2[2] = obj.z;
            Eigen::Vector3f rotation2(0, 0, obj.yaw);
            crop_point_cloud(pc2, max_p, min_p, t2, rotation2, object_cloud);
            CPointCloudPtr color_cloud(new CPointCloud);
            for (size_t o_idx = 0; o_idx < object_cloud->size(); ++o_idx) {
                CPoint cp;
                cp.x = (*object_cloud)[o_idx].x;
                cp.y = (*object_cloud)[o_idx].y;
                cp.z = (*object_cloud)[o_idx].z;
                cp.r = 0;
                cp.g = 255;
                cp.b = 0;
                color_cloud->push_back(cp);
            }
            LOG(INFO) << "obj_pc: " << object_cloud->size();
            string cc_id = "pc_obj_" + std::to_string(idx) + "_" + std::to_string(obj_idx);
            viewer.addPointCloud(color_cloud, cc_id);
        }
        viewer.spin();
    }

    return 0;
}
