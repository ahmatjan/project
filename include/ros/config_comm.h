/***************************************************************************
 * 
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 * $Id$ 
 * 
 **************************************************************************/
 
 /**
 * @file config_comm.h
 * @author haifeng(haifeng@baidu.com)
 * @date 2016/07/04 18:05:11
 * @version $Revision$ 
 * @brief 
 *  
 **/
#ifndef CONFIG_COMM_H
#define CONFIG_COMM_H

#include <iostream>
#include <fstream>
#include <vector> 
#include <set>  

namespace ros {

const int DEFAULT_TRANSPORT_MODE = 0;
const int CONSERVATIVE_TRANSPORT_MODE = 1;
const int SIMULATOR_ENGINE_TRANSPORT_MODE = 2;

struct Config_Comm {
    std::set<std::string> topic_white_list;
    int transport_mode;
};

//extern struct Config_Comm g_config_comm;

}

#endif  // CONFIG_COMM_H

/* vim: set ts=4 sw=4 sts=4 tw=100 */
