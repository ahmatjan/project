/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file executor.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/

#ifndef ROSMETRIC_EXECUTOR_H
#define ROSMETRIC_EXECUTOR_H

#include <vector>
#include <queue>
#include <memory>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <future>
#include <functional>
#include <stdexcept>

#include <rosmetric/types.h>

namespace ros{
//class Result;

class Executor {
public:
    Executor(std::size_t);

    template<class F, class... Args>
    auto enqueue(F&& f, Args&& ... args)
    -> std::future<Result>;

    ~Executor();

private:
    // need to keep track of threads so we can join them
    std::vector< std::thread > workers;
    // the task queue
    std::queue< std::function<void()> > tasks;

    // synchronization
    std::mutex queue_mutex;
    std::condition_variable condition;
    bool stop;
};

template<class F, class... Args>
auto Executor::enqueue(F&& f, Args&&... args) 
    -> std::future<Result>
{
    using return_type = Result;

    auto task = std::make_shared< std::packaged_task<return_type()> >(
            std::bind(std::forward<F>(f), std::forward<Args>(args)...)
        );
        
    std::future<return_type> res = task->get_future();
    {
        std::unique_lock<std::mutex> lock(queue_mutex);

        // don't allow enqueueing after stopping the pool
        if (stop) {
            throw std::runtime_error("enqueue on stopped ThreadPool");
        }

        tasks.emplace([task](){ (*task)(); });
    }
    condition.notify_one();
    return res;
}

}
#endif
