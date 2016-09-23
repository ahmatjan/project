/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
*
************************************************************************/
/**
* @file ieout.h
* @author car-os
* @date 2016/03/8
*
**/

#ifndef NOVATEL_PREPROCESS_IEOUT_H
#define NOVATEL_PREPROCESS_IEOUT_H

#include <string>

#include "pose_spline.h"

namespace novatel_preprocess {

void load_ieout_pose_spline(const std::string& file_name,
        PoseSplineXd& pose_spline, const std::string proj_param,
        float ratio_ctrls = 1.0);

void load_ieout_pose_array(const std::string& file_name,
        std::vector<double>& timestamps,
        std::vector<Eigen::Affine3d, Eigen::aligned_allocator<Eigen::Affine3d>>& poses,
        const std::string proj_param);
}  // namespace novatel_preprocess

#endif
