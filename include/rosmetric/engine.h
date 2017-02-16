/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file engine.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/

#ifndef ROSMETRIC_ENGINE_HPP
#define ROSMETRIC_ENGINE_HPP

#include <mutex>

#include <ros/ros.h> 
#include <rosmetric/const.h>
#include <rosmetric/executor.h>
#include <rosmetric/pipeline.h>
#include <rosmetric/watchdog.h>
#include <rosmetric/job_loader.h>
#include <rosmetric/job_scheduler.h>
#include <rosmetric/decision.h>
#include <rosmetric/types.h>

namespace ros {

class Task {
};

class Pipeline;

class RosMetric {
public:
    RosMetric() {
    };

    ~RosMetric() {
    };
};

class Engine;

typedef std::shared_ptr<Engine> EnginePtr; 
typedef std::future<Result> Request;
typedef std::deque<Request> RequestQueue;
typedef std::deque<Result> ResultQueue; 

extern std::string config;
class Engine{

public:
    Engine(): _shutting_down(false), _config(config) {
    };
    
    ~Engine() {
        stop();
    };

    static const EnginePtr& get_instance();

    void start();
    bool init();
    void stop();

    template<class F, class... Args>
    void add_task(F&&, Args&&...);
    void add_stat(Stat&& stat);
    void add_result(Result&& result);


    bool get_request_queue(std::deque<Request>& wait_queue);
    bool get_stat_queue(std::deque<Stat>& stat_queue);
    bool update_stat_queue(std::deque<Stat>& stat_queue);

private:
    std::string _config;

    std::mutex _task_mutex;
    std::queue<Task> _task_queue;

    std::mutex _result_mutex;
    std::deque<Result> _result_queue;

    std::mutex _request_mutex;
    std::deque<Request> _request_queue;

    std::mutex _stat_mutex;
    std::deque<Stat> _stat_queue;

    std::shared_ptr<Executor> executor;
    std::shared_ptr<Pipeline> pipeline;
    std::shared_ptr<WatchDog> watchdog;
    std::shared_ptr<JobScheduler> job_scheduler;
    std::shared_ptr<JobLoader> job_loader;
    std::shared_ptr<Decision> decision;

    std::thread _thread;
    bool _shutting_down;

    void event_loop() const;
    void notify_decision () const;
    void notify_pipeline () const;
};

template<class F, class... Args>
void Engine::add_task(F&& f, Args&&... args) {
    auto req = executor->enqueue(std::forward<F>(f), std::forward<Args>(args)...);
    std::lock_guard<std::mutex> lg(_request_mutex);
    _request_queue.emplace_back(std::move(req));
}

}
#endif
