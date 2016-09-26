/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file frequence.h
* @author mayu01(mayu01@baidu.com)
* @date 2016/07/12 15:32:28
* @version $Revision$
* @brief
*
**/
#ifndef ROS_FREQUENCE_H
#define ROS_FREQUENCE_H

#include <memory>
#include <ros/common.h>
#include "roslibmetric/metric/metric_interface.h"

namespace metric {
class Frequence;
typedef boost::shared_ptr<Frequence> FrequencePtr;

class Frequence : public MetricInterface {
public:
    Frequence();
    ~Frequence();

    void set();
    void process(metric_msgs::MetricStatus& status);
    void set_expecthz(std::string topic_name, double exhz);
    double get_expecthz(std::string topic_name) const;
    double get_realhz(std::string topic_name) const;

    void msgs_callback(std::string topic_name);
    void clear();
private:
    class Impl;
    std::unique_ptr<Impl> _impl;
    //boost::shared_ptr<Impl> _impl;
};
}
#endif  // ROS_FREQUENCE_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
