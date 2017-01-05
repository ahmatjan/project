#include "pcd_file_util.h"

//#include <xlog.h>

using Eigen::Affine3d;
using Eigen::Matrix3d;
using Eigen::Matrix4d;
using Eigen::Quaterniond;
using Eigen::Translation3d;
using std::string;
using std::vector;

bool load_pcl_pcds(
        const std::string& file_path,
        const Affine3d& pose,
        bool is_global,
        PointCloudPtr* cloud_out) {
    pcl::PointCloud<PointXYZIT>::Ptr org_cloud(new pcl::PointCloud<PointXYZIT>);
    if (pcl::io::loadPCDFile(file_path, *org_cloud) < 0) {
        //XLOG(ERROR) << "Failed to load pcd file: " << file_path;
        return false;
    }

    if (is_global) {
        pcl::PointCloud<PointXYZIT>::Ptr transformed_cloud(new pcl::PointCloud<PointXYZIT>);
        pcl::transformPointCloud(*org_cloud, *transformed_cloud, pose.matrix());
        org_cloud = transformed_cloud;
    }

    (*cloud_out)->points.reserve(org_cloud->points.size());
    for (size_t i = 0; i < org_cloud->points.size(); ++i) {
        Point point;
        point.x = org_cloud->points[i].x;
        point.y = org_cloud->points[i].y;
        point.z = org_cloud->points[i].z;
        point.intensity = org_cloud->points[i].intensity;
        (*cloud_out)->points.push_back(point);
    }
    return true;
}

bool load_pcd_poses(
        const string& file_path,
        const Affine3d& extrinsic,
        bool start_from_origin,
        vector<Affine3d>* poses,
        vector<double>* timestamps) {
    FILE* file = fopen(file_path.c_str(), "r");
    if (file == NULL) {
        //XLOG(ERROR) << "Failed to open file: " << file_path;
        return false;
    }
    unsigned int index = 0;
    double timestamp = 0.0;
    Translation3d translation;
    Affine3d pos_init;
    pos_init.setIdentity();
    double tx = 0;
    double ty = 0;
    double tz = 0;
    double qx = 0;
    double qy = 0;
    double qz = 0;
    double qr = 0;
    int size = 0;
    bool first_read = true;
    while ((size = fscanf(file, "%u %lf %lf %lf %lf %lf %lf %lf %lf\n",
                          &index, &timestamp, &tx, &ty, &tz, &qx, &qy, &qz, &qr)) == 9) {
        if (start_from_origin && first_read) {
            Affine3d pos_first = Translation3d(tx, ty, tz) * Quaterniond(qr, qx, qy, qz);
            pos_init = pos_first.inverse(Eigen::Affine);
            first_read = false;
        }

        Affine3d pos_org = Translation3d(tx, ty, tz) * Quaterniond(qr, qx, qy, qz);
        poses->push_back(pos_init * pos_org);
        timestamps->push_back(timestamp);
    }  // end of while
    fclose(file);
    return true;
}

bool load_extrinsic(const std::string& file_path, Affine3d* extrinsic) {
    YAML::Node config = YAML::LoadFile(file_path);
    if (!config["transform"]) {
        return false;
    }
    if (config["transform"]["translation"] && config["transform"]["rotation"]) {
        double tx = config["transform"]["translation"]["x"].as<double>();
        double ty = config["transform"]["translation"]["y"].as<double>();
        double tz = config["transform"]["translation"]["z"].as<double>();
        
        double qx = config["transform"]["rotation"]["x"].as<double>();
        double qy = config["transform"]["rotation"]["y"].as<double>();
        double qz = config["transform"]["rotation"]["z"].as<double>();
        double qw = config["transform"]["rotation"]["w"].as<double>();
        *extrinsic = Translation3d(tx, ty, tz) * Quaterniond(qw, qx, qy, qz);
        return true;
    }
    return false;
}

