/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file metric_service.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/05/12 12:54:28
* @version $Revision$
* @brief
*
**/
#ifndef ROS_METRIC_SERVICE_H
#define ROS_METRIC_SERVICE_H

#include "ros/callback_queue.h"
#include "metric_msgs/Metric.h"
#include "metric_msgs/MetricStatus.h"

namespace metric {

class MetricSrv {
public:
    MetricSrv(std::string nodename = "");
    ~MetricSrv();
    void spin();
    void set_service(std::map<std::string, metric_msgs::MetricStatus> status);

private:
    std::string _node_name;
    ros::CallbackQueue _check_queue;
    std::map<std::string, metric_msgs::MetricStatus> _m_status;
    bool reg_srv(metric_msgs::Metric::Request& req, metric_msgs::Metric::Response& res);
};
}
#endif  // ROS_METRIC_SERVICE_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
