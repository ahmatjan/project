/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   math_util.h
*@author fengkaiwen01
*@brief
*/

#ifndef UTILITIES_MATH_UTIL_H
#define UTILITIES_MATH_UTIL_H

#include <angles/angles.h>

namespace math_util {

template<typename T>
struct Range {
    T max;
    T min;
};

typedef Range<int> IntRange;

void init_sin_cos_rot_table(float *sin_rot_table, float *cos_rot_table,
                            uint16_t rotation, float rotation_resolution);

}// namespce math_util
#endif // UTILITIES_MATH_UTIL_H
