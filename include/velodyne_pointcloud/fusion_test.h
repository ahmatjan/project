/************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 *
 ************************************************************************/
/**
 * @file integrator.h
 * @author fengkaiwen01
 * @date Apr 13, 2016
 *
 **/
#ifndef CAR_ROS_DRIVERS_VELODYNE_VELODYNE_POINTCLOUD_FUSION_TEST_H
#define CAR_ROS_DRIVERS_VELODYNE_VELODYNE_POINTCLOUD_FUSION_TEST_H

#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <sensor_msgs/PointCloud2.h>

#include "rawdata.h"

namespace velodyne_pointcloud {

typedef sensor_msgs::PointCloud2 pc2;
typedef sensor_msgs::PointCloud2ConstPtr pc2ConstPtr;
typedef message_filters::Subscriber<sensor_msgs::PointCloud2> CloudFilterSub;
typedef message_filters::sync_policies::ApproximateTime<pc2, pc2> TwoMsgsSyncPolicy;
typedef message_filters::sync_policies::ApproximateTime<pc2, pc2, pc2> ThreeMsgsSyncPolicy;
typedef message_filters::sync_policies::ApproximateTime<pc2, pc2, pc2, pc2> FourMsgsSyncPolicy;

class FusionTest {
public:
    FusionTest(ros::NodeHandle nh, ros::NodeHandle private_nh);
    virtual ~FusionTest();

    void setup();
    void pointcloud_fusion(const pc2ConstPtr &msg1, const pc2ConstPtr &msg2);
    void pointcloud_fusion(const pc2ConstPtr &msg1, const pc2ConstPtr &msg2,
            const pc2ConstPtr &msg3);
    void pointcloud_fusion(const pc2ConstPtr &msg1, const pc2ConstPtr &msg2,
            const pc2ConstPtr &msg3, const pc2ConstPtr &msg4);
    void split(const std::string &str, const std::string &separator,
            std::vector<std::string> &v_str);

private:
    std::vector<boost::shared_ptr<CloudFilterSub> > _subs;
    std::string _topic_pointclouds;
    std::string _topic_fused_pointcloud;
    ros::Publisher _pub;
    ros::NodeHandle _nh;
    int _queue_size;
    message_filters::Synchronizer<TwoMsgsSyncPolicy>* _two_msgs_sync;
    message_filters::Synchronizer<ThreeMsgsSyncPolicy>* _three_msgs_sync;
    message_filters::Synchronizer<FourMsgsSyncPolicy>* _four_msgs_sync;

    double _max_interval_duration;

    void append_msg(velodyne_rawdata::VPointCloud &cloud, const pc2ConstPtr &msg);
    void register_callback(int topic_count);

    template<class Policy>
    Policy get_policy() {
        Policy policy(_queue_size);
        policy.setMaxIntervalDuration(ros::Duration(_max_interval_duration));
        return policy;
    }
};

} // namespace velodyne_pointcloud

#endif /* CAR_ROS_DRIVERS_VELODYNE_VELODYNE_POINTCLOUD_INCLUDE_VELODYNE_POINTCLOUD_INTEGRATOR_H_ */
