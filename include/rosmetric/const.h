/***************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$
 *
 **************************************************************************/

/**
* @file const.hpp
* @author hewei03@baidu.com
* @date 2016/04/13 20:25:13
* @version $Revision$
* @brief
*
**/

#ifndef ROSMETRIC_CONST_H
#define ROSMETRIC_CONST_H

#include <memory>

namespace ros {
const std::size_t EXECUTOR_NUM = 20;
const std::size_t TICK_TIME = 100;
const std::size_t WATCHDOG_TICK_TIME = 500;
const std::size_t TOLERANCE = 10;

const int STATUS_OK      = 0;
const int STATUS_WARNING = 1;
const int STATUS_ERROR   = 2;
const int STATUS_UNKNOWN = 3;
const int STATUS_TIMEOUT = 4;

const int DEC_STATUS_INIT    = -1;
const int DEC_STATUS_OK      = 0;
const int DEC_STATUS_WARNING = 1;
const int DEC_STATUS_ERROR   = 2;
const int DEC_STATUS_UNKNOWN = 3;
const int DEC_STATUS_TIMEOUT = 4;

const int METRIC_OK      = 0;
const int METRIC_WARNING = 1;
const int METRIC_ERROR   = 2;
const int METRIC_UNKNOWN = 3;
}

#endif
