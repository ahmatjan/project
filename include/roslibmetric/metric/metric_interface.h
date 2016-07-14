/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file metric_interface.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/04/08 14:38:32
* @version $Revision$
* @brief
*
**/
#ifndef ROS_METRIC_INTERFACE_H
#define ROS_METRIC_INTERFACE_H

#include "metric_msgs/MetricStatus.h"
#include "metric_msgs/KeyValue.h"

namespace metric {
class MetricInterface {
public:
    virtual ~MetricInterface() {};
    virtual void process(metric_msgs::MetricStatus& status) = 0;
};
}

#endif  // METRIC_INTERFACE_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
