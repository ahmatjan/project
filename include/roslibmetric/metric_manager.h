/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file metric_manager.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/04/12 19:36:02
* @version $Revision$
* @brief
*
**/
#ifndef ROS_METRIC_MANAGER_H
#define ROS_METRIC_MANAGER_H

#include <memory>
#include <mutex>
#include <thread>
#include <map>

#include "roslibmetric/metric/metric_registry.h"
#include "roslibmetric/metric/metric_service.h"
#include "roslibmetric/metric_handle.h"

namespace ros {
class MetricManager;
typedef boost::shared_ptr<MetricManager> MetricManagerPtr;

class MetricManager {

public:
    static const MetricManagerPtr& instance();

    MetricManager();
    ~MetricManager();

    void start();
    void shutdown();

    inline bool isstarted() {
        return _started;
    }
    ros::MetricHandle& get_metric_handle(std::string nodename);

private:
    void thread_func();
//    bool is_node_name(std::string nodename, std::string thisnode);
    std::map<std::string, boost::shared_ptr<ros::MetricHandle>> _m_metrichandles;
    std::map<std::string, boost::shared_ptr<metric::MetricSrv>> _m_services;
    std::thread _server_thread;
    mutable std::mutex _mutex;
    bool _shutting_down;
    bool _started;

    inline bool isShuttingDown() {
        return _shutting_down;
    }
};
}


#endif  // METRIC_MANAGER_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
