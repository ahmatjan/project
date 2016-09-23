/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file metric_registry.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/04/08 15:26:26
* @version $Revision$
* @brief
*
**/
#ifndef ROS_METRIC_REGISTRY_H
#define ROS_METRIC_REGISTRY_H

#include <map>

#include <ros/common.h>
#include "roslibmetric/metric/metric_interface.h"
#include "roslibmetric/metric/counter.h"
#include "roslibmetric/metric/healthy.h"

namespace metric {
class MetricsRegistry;
typedef boost::shared_ptr<metric::MetricsRegistry> MetricsRegistryPtr;

class MetricsRegistry {
public:
    MetricsRegistry();
    ~MetricsRegistry();

    Healthy& new_healthy(std::string metric_name, uint8_t lvl = 2,
                         const std::string s = "No message was set");
    Counter& new_counter(std::string metric_name, int64_t init_value = 0);

    void set_healthy(std::string metric_name, uint8_t lvl,
                     const std::string s);
    void set_counter(std::string metric_name, int64_t init_value);

    std::map<std::string, boost::shared_ptr<MetricInterface> > get_all_metrics() const;
    std::map<std::string, metric_msgs::MetricStatus> process_all();
private:
    class Impl;
    boost::shared_ptr<Impl> _impl;

};
}

#endif  // METRIC_REGISTRY_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
