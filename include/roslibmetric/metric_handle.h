/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/



/**
 * @file metric_handle.h
 * @brief
 *
 **/
#ifndef ROS_METRIC_HANDLE_H
#define ROS_METRIC_HANDLE_H

#include <memory>
#include "roslibmetric/metric/metric_registry.h"

namespace ros {
class MetricHandle {
    friend class MetricManager;
public:
    MetricHandle(std::string nodename = "");
    ~MetricHandle();
    void set_healthy(uint8_t level, std::string msg);
    metric::Counter& new_counter(std::string metric_name, int64_t init);
    void set_frequence();
    void set_topichz(std::string topic_name, double expt_hz);
    void publish_callback(std::string topic_name);
private:
    std::shared_ptr<metric::MetricsRegistry> _metric_registry;
    //metric::Frequence& _frequence;
};

MetricHandle& get_metric_handle(std::string nodename = "");

}
#endif  //ROS_METRIC_HANDLE_H

/* vim: set ts=4 sw=4 sts=4 tw=100 noet: */
