/***************************************************************************
 * * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file pipeline.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/ 

#ifndef ROSMETRIC_PIPELINE_HPP
#define ROSMETRIC_PIPELINE_HPP

#include <vector> 
#include <iostream>
#include <memory> 
#include <ros/ros.h>
#include <rosmetric/types.h>
#include <rosmetric/pipe.h>
#include <rosmetric/engine.h>
#include <boost/variant.hpp>

namespace ros {

typedef std::future<Result> Request;

class Chain {
public:
    Chain (Result& result) {
    };

    Chain () {
    };

    Stat run(const Result& result);
    //Stat run(boost::variant<Result, Stat>& result);

    //void link(Pipe&& f) {
    void link(Pipe f) {
        _pipe_list.emplace_back(f);
    };

private:
    std::vector<Pipe>  _pipe_list;

};

class Pipeline {
public:
    Pipeline(): _shutting_down(false) {
        _chain = std::make_shared<Chain>();
        Pipe p1(&_p_log);
        _chain->link(p1);
    };

    ~Pipeline() {
    }

    bool init(); 
    void start(); 
    void stop(); 
    void wake();

private:
    bool _shutting_down;
    std::deque<Request> _wait_queue;
    std::deque<Result> _result_queue;
    std::thread _thread;
    std::shared_ptr<Chain> _chain;

    LogPipe _p_log;

    std::mutex _server_lock;
    std::condition_variable _server_cond;

    void event_loop();
};

}
#endif
