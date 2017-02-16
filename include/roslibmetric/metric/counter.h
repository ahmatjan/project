/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file counter.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/04/08 15:08:34
* @version $Revision$
* @brief
*
**/
#ifndef ROS_COUNTER_H
#define ROS_COUNTER_H

#include <memory>
#include <ros/common.h>
#include "roslibmetric/metric/metric_interface.h"

namespace metric {
class Counter;
typedef boost::shared_ptr<Counter> CounterPtr;

class Counter : public MetricInterface {
public:
    Counter(int64_t init = 0);
    ~Counter();
    void process(metric_msgs::MetricStatus& status);
    int64_t count() const;
    void set(int64_t n);
    void inc(int64_t n = 1);
    void dec(int64_t n = 1);
    void clear();
private:
    class Impl;
    std::unique_ptr<Impl> _impl;
};
}


#endif  // COUNTER_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
