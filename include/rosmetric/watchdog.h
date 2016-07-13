/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file watchdog.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/

#ifndef ROSMETRIC_WATCHDOG_H
#define ROSMETRIC_WATCHDOG_H

#include <rosmetric/const.h>
#include <std_msgs/Int16.h>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <ros/ros.h>
#include <chrono>

namespace ros {

class WatchDog {
public:
    friend class Decision;
    WatchDog(): _status(STATUS_UNKNOWN) {
    };

    void start();
    bool init();
    void stop();
    void event_loop();

private:
    bool _shutting_down;
    std::thread _thread;
    std::mutex _server_lock;
    std::condition_variable _server_condition;

    void set_status(int&& status);
    int get_status();
    void publish_status();

    std::mutex _status_lock;
    int _status;
    volatile int count;

    Publisher pub;

    void update_status();
};

}
#endif
