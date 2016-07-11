/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file timing_wheel.h
* @author haifeng(haifeng@baidu.com)
* @date 2016/04/11 20:00:58
* @version $Revision$
* @brief
*
**/
#ifndef ROS_TIMING_WHEEL_H
#define ROS_TIMING_WHEEL_H

#include <list>
#include <thread>
#include <mutex>
#include <boost/shared_ptr.hpp>

namespace ros {

class TimeoutHandler {
public:
    /**
     * \brief  virtual TimeoutHandler destructor.
     * @param None
     * @return None
     */
    virtual ~TimeoutHandler() {}

    /**
     * \brief pure virtual on_timeout method. Timeout callback hanlder,need override.
     * @param None
     * @return None
     */
    virtual void on_timeout() = 0;
};

class TimingWheel {
public:

    /**
     * \brief TimingWheel constructor.
     * @param None
     * @return None
     */
    TimingWheel();

    /**
     * \brief TimingWheel copy constructor.
     * @param TimingWheel Object ref
     * @return None
     */
    TimingWheel(const TimingWheel& obj);

    /**
     * \brief TimingWheel assign constructor.
     * @param TimingWheel Object ref
     * @return None
     */
    TimingWheel& operator=(const TimingWheel& obj);

    /**
     * \brief TimingWheel destructor.
     * @param None
     * @return None
     */
    virtual ~TimingWheel();

    /**
     * \brief TimingWheel add_timer.
     * @param unsigned int inteval, period time
     * @param std::shared_ptr<TimeoutHandler> handler, Callback handler when time-out.
     * @param  bool oneshot, true for only one time ,false for period
     * @return None
     */
    void add_timer(unsigned int inteval, std::shared_ptr<TimeoutHandler> handler, bool oneshot);

    /**
     * \brief TimingWheel tick step method.
     * @param None
     * @return None
     */
    void step();

private:

    typedef std::shared_ptr<TimeoutHandler> Handler;

    struct ListNode {
        unsigned int  inteval;
        Handler handler;
        bool oneshot ;
        unsigned int time_left;
        ListNode(int inteval, Handler handler, bool oneshot, unsigned int time_left)
            : inteval(inteval), handler(handler), oneshot(oneshot), time_left(time_left) {
        }
    };

    enum {WHEEL_CNT = 5};
    unsigned int  _cursor[WHEEL_CNT];
    std::list<ListNode>* _wheels[WHEEL_CNT];
    std::recursive_mutex _mtx;

    void _update_timer(ListNode& node);

    static const unsigned int  ELEMENT_CNT_PER_WHEEL[];
    static const unsigned int  RIGHT_SHIFT_PER_WHEEL[];
    static const unsigned int  BASE_PER_WHEEL[];
};

}

#endif  // TIMING_WHEEL_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
