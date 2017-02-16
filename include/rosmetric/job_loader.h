/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file job_loader.h
* @author haifeng(haifeng@baidu.com)
* @date 2016/04/06 15:39:56
* @version $Revision$
* @brief
*
**/
#ifndef ROS_JOB_LOADER_H
#define ROS_JOB_LOADER_H

#include "yaml-cpp/yaml.h"
#include <iostream>
#include <fstream>
#include <string>
#include <list>
#include <thread>
#include <mutex>
#include "boost/shared_ptr.hpp"
#include "boost/enable_shared_from_this.hpp"
#include "metric_msgs/RosMetric.h"
#include "ros/ros.h"

namespace ros {

#define DISALLOW_COPY_AND_ASSIGN(TypeName) \
    TypeName(const TypeName&);             \
    TypeName& operator=(const TypeName&)

/**
* \brief TaskConfig structure.
* @member std::string group,  test metric group 
* @member std::string name,test metric name, eg. master, node1, node2, zookeeper.
* @member unsigned int  testtype, test metric type, 0 for nodes, 1 for master, 2 for zookeeper.
* @member std::string testfunc, test metric function, node check_metric service, master api or zookeeper api
* @member std::string testargs , tesst metric function args
* @member bool oneshot, true for test only one time. false for period test .
* @member unsigned int period, test period, how many ticks. eg. TICK_TIME 100ms,period=2, 200ms test period.
*/  
struct TaskConfig {
    std::string group;
    std::string name;
    unsigned int  testtype;
    std::string testfunc;
    std::string testargs;
    bool oneshot;
    unsigned int period;
};

/**
* \brief DynamicTask structure.
* @member struct TaskConfig task_config, dynamic task_config of  the nodes publishing topic. 
* @member int status, nodes status.
*/  
struct DynamicTask {
    struct TaskConfig task_config;
    int status;
};

class JobLoader {

public:

    /**
     * \brief Jobloader constructor.
     * @param file (std::string)  config yaml file 
     * @return None
     */
    JobLoader(const std::string file): _file(file) {};

    /**
     * \brief Jobloader destructor
     * @param None
     * @return None
     */
    virtual ~JobLoader() {
        if (_running) {
            shutdown();
        }
    };

    /**
     * \brief Jobloader initial, parse config yaml file
     * @param None
     * @return bool, true for success , false for failed.
     */
    bool init();

    /**
     * \brief Jobloader start a new thread to subscribe rosmetric topic for dynamic task 
     * @param None
     * @return None
     */    
    void start();
    /**
     * \brief Jobloader shutdown to exit jobloader.
     * @param None
     * @return None
     */
    void shutdown();

    /**
     * \brief Jobloader isrunning, check the jobloader whether or not runnning.
     * @param None
     * @return bool, true for jobloader running , false for jobloader shutdown already.
     */  
    bool isrunning() const;

    /**
     * \brief Jobloader get_all_config_task, return all config task in the yaml file.
     * @param None
     * @return vector for taskconfig struct, 
     */  
    std::vector<struct TaskConfig> get_all_config_task();

    /**
     * \brief Jobloader pop_config_task, return the front of TaskConfig Vector.
     * @param None
     * @return TaskConfig struct, 
     */  
    struct TaskConfig pop_config_task();

    /**
     * \brief Jobloader get_config_task
     * @param None
     * @return the reference taskconfig struct of vector[position], 
     */  
    struct TaskConfig& get_config_task(size_t pos);

    /**
     * \brief Jobloader erase_config_task,delete taskconfig struct of vector[position]
     * @param None
     * @return None
     */  
    void erase_config_task(size_t pos);

    /**
     * \brief Jobloader get_len_config_task
     * @param None
     * @return size_t config_taks vector length,.
     */  
    size_t get_len_config_task();

    /**
     * \brief Jobloader isempty_config_task
     * @param None
     * @return true for config task vector empty , or else false.
     */  
    bool isempty_config_task();

    /**
     * \brief Jobloader pop_dynamic_task, return the front of DynamicTask Vector.
     * @param None
     * @return DynamicTask struct, 
     */  
    struct DynamicTask pop_dynamic_task();

    /**
     * \brief Jobloader get_dynamic_task
     * @param None
     * @return the reference dynamic task struct of vector[position], 
     */  
    struct DynamicTask& get_dynamic_task(size_t pos);

    /**
     * \brief Jobloader erase_dynamic_task,delete dynamic task  struct of vector[position]
     * @param None
     * @return None
     */ 
    void erase_dynamic_task(size_t pos);

    /**
     * \brief Jobloader get_len_dynamic_task
     * @param None
     * @return size_t dynamic task  vector length,.
     */  
    size_t get_len_dynamic_task();

    /**
     * \brief Jobloader isempty_dynamic_task
     * @param None
     * @return true for dynamic task vector empty , or else false.
     */ 
    bool isempty_dynamic_task();

private:
    const std::string  _file;
    std::vector<struct TaskConfig> _config_vector;
    std::vector<struct DynamicTask> _dynamic_vector;
    std::set<std::string> _config_set;

    std::recursive_mutex _rmutex;
    bool _running ;

    ros::NodeHandle _nh;
    std::thread _subscribe_thread;
    void _thread_func();
    void _metric_callback(const metric_msgs::RosMetricConstPtr& msg);

    DISALLOW_COPY_AND_ASSIGN(JobLoader);

};

}

#endif  // job_loader_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
