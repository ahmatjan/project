/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file types.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/

#ifndef ROSMETRIC_TYPES_HPP
#define ROSMETRIC_TYPES_HPP

#include <boost/variant.hpp>
#include "metric_msgs/Metric.h"
#include "rosmetric/job_loader.h"
#include "ros/time.h"

namespace ros {
//typedef metric_msgs::MetricStatus Result;

/*struct DecisionResult {
    int level;
};*/

class Result {
public:
    metric_msgs::MetricStatus _msg;
    TaskConfig _task;
};

class Stat {
public:
    std::string _node_name;
    std::string _metric_name;
    std::string _group_name;
    metric_msgs::MetricStatus _msg;
    ros::WallTime _timestamp;
    std::map<std::string, boost::variant<std::string, int, double> > _data;
};

//typedef std::deque<Stat> D_Stat;
//typedef std::map<std::string, D_Stat> > GroupStats;
//typedef std::map<std::string, GroupStats> MetricGroupStats;

class EqualTo: public boost::static_visitor<bool> {
public:
    bool operator()(const int& a, const int& b) const {
        return a == b;
    };

    bool operator()(const int& a, const double& b) const {
        return false;
    };

    bool operator()(const int& a, const std::string& b) const {
        return false;
    };

    bool operator()(const double& a, const double& b) const {
        static const float EPSINON = 0.00001;
        float tmp = a - b;

        if (tmp > - EPSINON && tmp < EPSINON) {
            return true;
        } else {
            return false;
        };
    };

    bool operator()(const double& a, const int& b) const {
        return false;
    };

    bool operator()(const double& a, const std::string& b) const {
        return false;
    };

    bool operator()(const std::string& a, const std::string& b) const {
        return a == b;
    };

    bool operator()(const std::string& a, const double& b) const {
        return false;
    };

    bool operator()(const std::string& a, const int& b) const {
        return false;
    };
};

class GreaterThan: public boost::static_visitor<bool> {
public:
    bool operator()(const int& a, const int& b) const {
        return false;
    };

    bool operator()(const int& a, const double& b) const {
        return false;
    };

    bool operator()(const int& a, const std::string& b) const {
        return false;
    };

    bool operator()(const double& a, const double& b) const {
        return false;
    };

    bool operator()(const double& a, const int& b) const {
        return false;
    };

    bool operator()(const double& a, const std::string& b) const {
        return false;
    };

    bool operator()(const std::string& a, const std::string& b) const {
        return false;
    };

    bool operator()(const std::string& a, const double& b) const {
        return false;
    };

    bool operator()(const std::string& a, const int& b) const {
        return false;
    };
};



}
#endif
