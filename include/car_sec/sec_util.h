/*
 * sec_comm.h
 *
 *  Created on: Sep 14, 2016
 *      Author: hanyu02@baidu.com
 */

#ifndef ROS_SECURE_SEC_UTIL_H
#define ROS_SECURE_SEC_UTIL_H

namespace carsec {

/*
 *\brief is_sec_enable
 * judge whether ROS_SEC_ENABLE env is set.
 */
bool is_sec_enable();

/*
 *\brief init_sec_env
 * get ROS_SEC_ENABLE env variable and value
 *\this function should be invoked in ros::init
 */
void init_sec_env();
}

#endif /* ROS_COMM_ROSCPP_INCLUDE_CAR_SEC_SEC_COMM_H_ */
