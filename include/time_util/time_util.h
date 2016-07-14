/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   time_util.h
*@author fengkaiwen01
*@brief
*/

#ifndef UTILITIES_TIME_UTIL_H
#define UTILITIES_TIME_UTIL_H

#include <stdint.h>

namespace time_util {

//after 2015/7/1 leapSeconds is 17, this value is genereated manually.
//TUDO:get this value from WEB API
//static const uint64_t LEAPSECONDS = 17;

//Diff sec 1980.6.1(gps begin) - 1970.1.1 (unix begin) - leap : 315964800 -17
static const uint64_t UNIX_GPS_DIFF = 315964783;

//Diff sec 1980.6.1(gps begin) - 1970.1.1 (unix begin) - leap to usec
static const uint64_t UNIX_GPS_DIFF_USEC = 315964783*1e6;

//convet unix timestamp to gps timestamp
uint64_t unix_to_gps (uint64_t unix_time_usec);

//void real_time_or_bag_time_or_die();

} // namespace utilities_time

#endif // UTILITIES_TIME_UTIL_H
