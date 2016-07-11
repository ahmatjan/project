/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file proc.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/
#ifndef ROSMETRIC_PIPE_HPP
#define ROSMETRIC_PIPE_HPP

#include <rosmetric/types.h>
#include <glog/logging.h>
#include "ros/time.h"

namespace ros {

class Impl {
public:
    virtual Stat& run(Stat& stat) const {
        ROS_INFO_STREAM("Base parsing stat:" << stat._node_name << ":" << stat._metric_name);
    };
};

class Pipe {
public:
    Pipe(Impl* imp): _impl(imp) {
    };

    ~Pipe() {
    };

    Stat& operator() (Stat& stat) const {
        return _impl->run(stat);
    };

    Stat operator() (const Result& result) const {
        Stat stat;
        stat._node_name = result._task.name;
        ROS_INFO_STREAM("node_name:" << result._task.name);
        stat._group_name = result._task.group;
        stat._msg = result._msg;
        stat._timestamp = ros::WallTime::now();
        stat._metric_name = result._task.testargs;
        return _impl->run(stat);
    };

private:
    class Impl* _impl;
};

class LogPipe: public Impl {
public:
    LogPipe() {
    };

    Stat& run(Stat& stat) const {
        ROS_INFO_STREAM("LogPipe parsing stat:" << stat._node_name << ":" << stat._metric_name);
        if (stat._msg.level == 1) {
            LOG(WARNING) << stat._node_name << ":" << stat._metric_name;
        } else if (stat._msg.level == 2) {
            LOG(ERROR) << stat._node_name << ":" << stat._metric_name;
        }
        return stat;
    };

private:
};

typedef boost::variant<Result, Stat> PipeValue;

class PipeVisitor: public boost::static_visitor<PipeValue> {
public:
    PipeVisitor(Pipe& pipe): _pipe(pipe) {
    };
        
    PipeValue operator() (Stat& stat) const {
        return _pipe(stat);
    };

    PipeValue operator() (Result& stat) const {
        return _pipe(stat);
    };

private:
    Pipe _pipe;
};

}
#endif
