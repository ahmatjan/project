/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file decision.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/04/22 11:58:09
* @version $Revision$
* @brief
*
**/
#ifndef ROS_DECISION_H
#define ROS_DECISION_H
#include <map>
#include <vector>
#include <mutex>
#include <thread>
#include <memory>
#include <deque>
#include <condition_variable>

#include "ros/time.h"
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "rosmetric/types.h"
#include "rosmetric/job_loader.h"
#include "rosmetric/watchdog.h"
#include "pb/status.pb.h"

namespace ros {

/**
* \brief DecisionResult structure.
* @member int level, node return level.
        0:OK, 1:Warning, 2:Error, 3:UnKnown, 4:Timeout.
* note : define this structure for expend.
*/
struct DecisionResult {
    int level;
    adu::common::metric::NodeStatus node_status;
};

typedef std::vector<DecisionResult> V_DecRes;
typedef std::map<std::string, DecisionResult> M_DecRes;

/**
* \brief NodeStatus structure.
* @member std::string metric_name, read from config.
* @member std::string group_name, read from config.
* @member std::string node_name, read from config.
* @member bool oneshot, read from config. execute for one time.
* @member unsigned int period, if oneshot is false, execute cycle.
* @member WallTime last_real, the time this job was executed, was set by engine.
* @member WallTime next_expect, the time this job will be executed, was calculated by last_real and period.
* @member DecisionResult last_res, the lastest executed result, was used for update dec_res.
* @member DecisionResult dec_res, the executed result, was used for make decision.
* note : the composite (metric_name, group_name, node_name) is key.
*/
struct NodeStatus {
    std::string metric_name;
    std::string group_name;
    std::string node_name;
    bool oneshot;
    unsigned int period;
    ros::WallTime last_real;
    ros::WallTime next_expect;
    ros::DecisionResult last_res;
    ros::DecisionResult dec_res;

    /**
     * @brief : ==Operator overloading
     * @param [in] ns   : const NodeStatus&
     * @return  bool
     * @note
    **/
    inline bool operator==(const NodeStatus& ns) const {
        if (this->metric_name == ns.metric_name &&
                this->group_name == ns.group_name &&
                this->node_name == ns.node_name) {
            return true;
        } else {
            return false;
        }
    }
};

typedef std::map<std::string, M_DecRes> M_GroupStatus;
typedef std::vector<NodeStatus> V_NodeStatus;
typedef std::map<std::string, M_GroupStatus> M_MGroupStatus;

class Decision {
public:
    /**
     * @brief Decision constructor
     * @param [in] watch_dog   : the shared point of Object WatchDog, which is initialized by engine.
     * @return None
    **/
    Decision(std::shared_ptr<ros::WatchDog> watch_dog);

    /**
     * @brief Decision destructor
     * @note
    **/
    ~Decision();

    /**
     * @brief : called by engine, when the executors return results.
     * @param: null
     * @return  void
     * @note
    **/
    void set();

    /**
     * @brief : Decision initializes variables.
     * @param [in] task_config   : config vector which jobloader reads from config file.
     * @return  void
     * @note
    **/
    bool init(const std::vector<struct TaskConfig>& task_config);

    /**
     * @brief Decision starts a new thread to make a decision and notify watchdog.
     * @return  void
     * @note
    **/
    void start();

    /**
     * @brief : Decision thread shutdown;
     * @return  void
     * @note
    **/
    void stop();

private:
    /**
     * @brief : update node status include next expect time, last real time and results.
     * @param [in] stat   : stat queue which is set by engine.
     * @return  void
     * @note
    **/
    void update_nodestatus(std::deque<Stat>& stat);

    /**
     * @brief : basic decision function. all the results do or operator.
     * @param [in] v_decres   : the vector of decision results.
     * @return  DecisionResult
     * @note
    **/
    DecisionResult or_decision(M_DecRes& m_decres);

    /**
     * @brief : basic decision funciton. all the results do and operator.
     * @param [in/out] v_decres   : the vector of decision results.
     * @return  DecisionResult
     * @note
    **/
    DecisionResult and_decision(V_DecRes& v_decres);

    /**
     * @brief : group decision function. default operator is common(call or_decison funciton).
     * @param [in/out] m_decres   : map <nodename, decision_result>
     * @return  DecisionResult
     * @note
    **/
    DecisionResult group_common(M_DecRes& m_decres);

    /**
     * @brief : zookeeper group decision function.
     *          if all zks are ok, then return ok
     *          elif half of zks are ok, then return warning
     *          else return or_decision(zks.levels).
     * @param [in/out] m_decres   : M_DecRes& map <zookeepername, decision_result>
     * @return  DecisionResult
     * @note
    **/
    DecisionResult group_zk(M_DecRes& m_decres);

    void thread_func();

    V_NodeStatus _v_ns;
    M_DecRes _metric_result;
    M_MGroupStatus _metric_group;
    std::shared_ptr<ros::WatchDog> _watch_dog;
    bool _shutting_down;

    std::thread _server_thread;
    std::mutex _server_lock;
    std::condition_variable _server_condition;
    Publisher _detail_pub;
};
}
#endif  // DECISION_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
