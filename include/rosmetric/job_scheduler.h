/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file job_scheduler.h
* @author haifeng(haifeng@baidu.com)
* @date 2016/04/13 20:25:35
* @version $Revision$
* @brief
*
**/
#ifndef ROS_JOB_SCHEDULER_H
#define ROS_JOB_SCHEDULER_H

#include <iostream>
#include <fstream>
#include <string>
#include <list>
#include <thread>
#include <mutex>
#include "rosmetric/timing_wheel.h"
#include "rosmetric/job_loader.h"
#include "boost/shared_ptr.hpp"
#include "boost/asio.hpp"
#include "boost/algorithm/string.hpp"
#include "boost/lexical_cast.hpp"
#include "ros/ros.h"

namespace ros {

class JobScheduler {

public:

    /**
     * \brief JobScheduler constructor.
     * @param const unsigned int time_gran, JobScheduler time tick , unit is ms.
     * @param std::shared_ptr<ros::JobLoader> job_loader, jobloader hanlder ptr.
     * @return None
     */
    JobScheduler(const unsigned int time_gran,
                 std::shared_ptr<ros::JobLoader> job_loader)
                : _time_gran(time_gran), _job_loader(job_loader) {};

    /**
     * \brief JobScheduler destructor.
     * @param None
     * @return None
     */
    virtual ~JobScheduler() {
        if (_running) {
            shutdown();
        }
    };

    /**
     * \brief JobScheduler init. push back the task config into the timing wheel of the job shcheduler.
     * @param None.
     * @return true for success , false for failed.
     */
    bool init();

    /**
     * \brief JobScheduler start. start a new thread to start timing wheel and check dymanic task topic vector.
     * @param None.
     * @return None.
     */
    void start();

    /**
     * \brief JobScheduler shutdown. shutdown to exit job scheduler.
     * @param None.
     * @return None.
     */
    void shutdown();

    /**
     * \brief JobScheduler isrunning.
     * @param None.
     * @return bool. true for job scheduler running. false for shutdown.
     */
    bool isrunning();

private:
    TimingWheel _tw ;
    std::shared_ptr<ros::JobLoader>  _job_loader;
    const unsigned int  _time_gran;
    bool _running ;
    std::thread _scheduler_thread ;
    void _thread_func();
    void _parse_task(TaskConfig& task_config, bool init);

    DISALLOW_COPY_AND_ASSIGN(JobScheduler);

};

class MetricHandler : public TimeoutHandler {

public:
    /**
     * \brief MetricHandler constructor. 
     * @param TaskConfig task_config,
     * @return None
     */
    MetricHandler(TaskConfig task_config): _task_config(task_config) {};

    /**
     * \brief ZKMetric on_timeout. timeout MetricHandler of the timing wheel.
     * @param None.
     * @return None.
     */
    void on_timeout();
private:
    TaskConfig _task_config ;
    ros::NodeHandle  _nh;

};

class ZKMetric {

public:
    /**
     * \brief ZKMetric constructor.
     * @param const std::string host, zookeeper server host or ip
     * @param const int port, zookeeper port.
     * @return None
     */
    ZKMetric(const std::string host, const int port): _host(host), _port(port) {};

    /**
     * \brief ZKMetric get_metric.
     * @param const std::string req, request key for zookeeper metric.
     * @param [out] std::string& res, response results for zookeeper metric.
     * @return bool. true for request success . false for request failed.
     */
    bool get_metric(const std::string req, std::string& res);

private:
    const std::string _host ;
    const int _port ;

};

}

#endif  // JOB_SCHEDULER_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
