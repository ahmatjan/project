#ifndef PROJECT_PATH_FEATURE_DESCRIPTOR_H
#define PROJECT_PATH_FEATURE_DESCRIPTOR_H

#include <float.h>

#include "pcl_types.h"

class FeatureDescriptor {
public:
    FeatureDescriptor(PointCloudPtr cloud) {
        _cloud = cloud;
    }
    ~FeatureDescriptor() {}

    void compute_lowlevel(std::vector<float>& feature) {
        get_min_max_center();

        // distance to (0, 0, 0)
        float distance = sqrt(pow(_center_pt.x, 2) + pow(_center_pt.y, 2) + pow(_center_pt.z, 2));

        // length, width, height
        float length = _max_pt.x - _min_pt.x;
        float width = _max_pt.y - _min_pt.y;
        float height = _max_pt.z - _min_pt.z;

        // output feature
        feature.resize(8);
        feature[0] = _center_pt.x;
        feature[1] = _center_pt.y;
        feature[2] = _center_pt.z;
        feature[3] = length;
        feature[4] = width;
        feature[5] = height;
        feature[6] = distance;
        feature[7] = _cloud->points.size();
    }

    void compute_histogram(int bin_size, std::vector<float>& feature) {
        get_min_max_center();
       
        int xstep = bin_size;
        int ystep = bin_size;
        int zstep = bin_size;
        int stat_len = xstep + ystep + zstep;
        std::vector<int> stat_feat(stat_len, 0);
        float xsize = (_max_pt.x - _min_pt.x) / xstep + 0.000001;
        float ysize = (_max_pt.y - _min_pt.y) / ystep + 0.000001;
        float zsize = (_max_pt.z - _min_pt.z) / zstep + 0.000001;

        int pt_num = _cloud->points.size();
        for (int i = 0; i < pt_num; ++i) {
            Point& pt = _cloud->points[i];
            stat_feat[static_cast<int>((pt.x - _min_pt.x) / xsize)]++;
            stat_feat[static_cast<int>(xstep + (pt.y - _min_pt.y) / ysize)]++;
            stat_feat[static_cast<int>(xstep + ystep + (pt.z - _min_pt.z) / zsize)]++;
        }

        feature.resize(stat_len + 7);
        feature[0] = _center_pt.x / 10.0;   
        feature[1] = _center_pt.y / 10.0;
        feature[2] = _center_pt.z;
        feature[3] = xsize;
        feature[4] = ysize;
        feature[5] = zsize;
        feature[6] = pt_num;
        for (size_t i = 0; i < stat_feat.size(); ++i) {
            feature[i+7] = float(stat_feat[i]) / float(pt_num);
        }
    }

    void compute_multi_channel_height_map(
            int channels, 
            int height, 
            int width, 
            std::vector<float>* feature) {
        /// initialize feature
        int feat_size = channels * height * width;
        feature->resize(feat_size, -5.0);

        /// get xyz step
        get_min_max_center();
        float xstep = (_max_pt.x - _min_pt.x) / width + FLT_EPSILON;
        float ystep = (_max_pt.y - _min_pt.y) / height + FLT_EPSILON;
        float zstep = (_max_pt.z - _min_pt.z) / (channels - 1) + FLT_EPSILON;

        /// set feature for each voxel grid 
        int pt_num = _cloud->points.size();
        for (int i = 0; i < pt_num; ++i) {
            const Point& pt = _cloud->points[i];
            int pos_x = static_cast<int>((pt.x - _min_pt.x) / xstep);
            int pos_y = static_cast<int>((pt.y - _min_pt.y) / ystep);
            int pos_z = static_cast<int>((pt.z - _min_pt.z) / zstep);
            int pos = pos_z * width * height + pos_y * width + pos_x;
            if (feature->at(pos) < pt.z) {
                feature->at(pos) = pt.z;
            }
        }

        /// set other 7-dim low level features
        int other_feature_start_pos = (channels - 1) * height * width;
        feature->at(other_feature_start_pos) = pt_num / 100.0;
        feature->at(other_feature_start_pos + 1) = xstep;
        feature->at(other_feature_start_pos + 2) = ystep;
        feature->at(other_feature_start_pos + 3) = zstep;
        feature->at(other_feature_start_pos + 4) = \
                fabs(_min_pt.x + _max_pt.x) / 20.0;
        feature->at(other_feature_start_pos + 5) = \
                fabs(_min_pt.y + _max_pt.y) / 20.0;
        feature->at(other_feature_start_pos + 6) = (_min_pt.z + _max_pt.z) / 2.0;
    }
private:
    void get_min_max_center() {
        float xsum = 0.0;
        float ysum = 0.0;
        float zsum = 0.0;
        _min_pt.x = _min_pt.y = _min_pt.z = FLT_MAX;
        _max_pt.x = _max_pt.y = _max_pt.z = -FLT_MAX;

        int pt_num = _cloud->points.size();
        for (int i = 0; i < pt_num; ++i) {
            Point& pt = _cloud->points[i];
            xsum += pt.x;
            ysum += pt.y;
            zsum += pt.z;
            _min_pt.x = std::min(_min_pt.x, pt.x);
            _max_pt.x = std::max(_max_pt.x, pt.x);
            _min_pt.y = std::min(_min_pt.y, pt.y);
            _max_pt.y = std::max(_max_pt.y, pt.y);
            _min_pt.z = std::min(_min_pt.z, pt.z);
            _max_pt.z = std::max(_max_pt.z, pt.z);
        }        

        // center position
        _center_pt.x = xsum / pt_num;
        _center_pt.y = ysum / pt_num;
        _center_pt.z = zsum / pt_num; 
    }

    PointCloudPtr _cloud;
    Point _min_pt;
    Point _max_pt;
    Point _center_pt;

}; // class FeatureDescriptor

#endif // PROJECT_PATH_FEATURE_DESCRIPTOR_H
