/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file healthy.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/04/08 14:54:59
* @version $Revision$
* @brief
*
**/
#ifndef ROS_HEALTHY_H
#define ROS_HEALTHY_H

#include <memory>
#include <ros/common.h>
#include "roslibmetric/metric/metric_interface.h"

namespace metric {
class Healthy;
typedef boost::shared_ptr<Healthy> HealthyPtr;
class Healthy : public MetricInterface {
public:
    Healthy(uint8_t lvl = 2, const std::string s = "No message was set");
    ~Healthy();
    void process(metric_msgs::MetricStatus& status);
    void set(uint8_t lvl, const std::string s);
private:
    class Impl;
    std::unique_ptr<Impl> _impl;
};
}

#endif  // HEALTHY_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
