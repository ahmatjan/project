#ifndef ADU_PERCEPTION_TOOLS_LABEL_OBJECT_SET_H
#define ADU_PERCEPTION_TOOLS_LABEL_OBJECT_SET_H

#include <sstream>
#include <string>
#include <vector>
#include <omp.h>

#include <Eigen/Core>
//#include <glog/logging.h>
#include <json/json.h>

#include "macros.h"
#include "noncopyable.h"
#include "pcl_util.h"
#include "file_util.h"
#include "string_util.h"
#include "pcd_file_util.h"
#include "feature_descriptor.h"

enum ObjectType {
    UNKNOWN = 0,
    SMALL_MOT = 1,
    PEDESTRIAN = 2,
    BIG_MOT = 3,
    NON_MOT = 4,
    INVALID = 5
};

struct Object {
    double x = 0;
    double y = 0;
    double z = 0;
    double length = 0;
    double width = 0;
    double height = 0;
    double yaw = 0.0;
    std::string type_name;
    ObjectType type;
    PointCloudPtr cloud;
    // std::vector<float> features;

    std::string to_string() {
        std::ostringstream oss;
        oss << "x: " << GLOG_DOUBLE(x) << " y: " << GLOG_DOUBLE(y)
            << " z: " << GLOG_DOUBLE(z) << " length: " << GLOG_DOUBLE(length)
            << " width: " << GLOG_DOUBLE(width) << " height: " << GLOG_DOUBLE(height)
            << " yaw: " << GLOG_DOUBLE(yaw) << " type: " << type_name
            << " pc_size: " << cloud->size();
        return oss.str();
    }
};

class ObjectSet {
public:
    ObjectSet() = default;
    ~ObjectSet() = default;

    bool load_from_file(const std::string& pcd_prefix, const std::string& label_file);
    bool load_from_memory(
            const std::string& pcd_prefix,
            const std::vector<std::string>& lines);

    void get_all_objects(std::vector<Object>* objects);
    void compute_features(const Object& obj, std::vector<float>* features);

private:
    void parse_objects(
            const PointCloudPtr& pc,
            const std::string& json_str,
            std::vector<Object>* objects);

    ObjectType parse_object_type(const std::string& type_name);

    using ObjectsPerFrame = std::vector<Object>;
    std::vector<ObjectsPerFrame> _all_objects;
    DISALLOW_COPY_AND_ASSIGN(ObjectSet);
};

#endif  // ADU_PERCEPTION_TOOLS_LABEL_OBJECT_SET_H
