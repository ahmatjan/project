/***************************************************************************
 * 
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$ 
 * 
 **************************************************************************/
 
 /**
 * @file shm_manager.h
 * @author haifeng(haifeng@baidu.com)
 * @date 2016/11/22 19:16:39
 * @version $Revision$ 
 * @brief 
 *  
 **/
#ifndef ROS_SHM_MANAGER_H
#define ROS_SHM_MANAGER_H

#include <memory>
#include <mutex>
#include <thread>
#include <map>
#include <boost/make_shared.hpp>
#include <boost/thread/recursive_mutex.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/enable_shared_from_this.hpp>
#include <boost/interprocess/sync/interprocess_mutex.hpp>
#include <boost/interprocess/sync/scoped_lock.hpp>

namespace ros {

class ShmManager;
typedef boost::shared_ptr<ShmManager> ShmManagerPtr;

class ShmManager {

public:
    static const ShmManagerPtr& instance();

    ShmManager();
    ~ShmManager();

    void start();
    void shutdown();

    inline bool isstarted() {
        return _started;
    }

private:
    void thread_func();
    std::thread _server_thread;
    mutable std::mutex _mutex;
    bool _started;
    boost::interprocess::interprocess_mutex _shm_sub_mutex;
};

}

#endif  // ROS_SHM_MANAGER_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
