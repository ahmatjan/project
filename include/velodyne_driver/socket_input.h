/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   input.h
*@author fengkaiwen01
*@brief
*/

#ifndef VELODYNE_DRIVER_SOCKET_INPUT_H
#define VELODYNE_DRIVER_SOCKET_INPUT_H

#include <unistd.h>
#include <stdio.h>
#include <pcap.h>
#include <ros/ros.h>

#include "input.h"

namespace velodyne_driver {
static int FIRING_DATA_PORT = 2368;
//For HDL32E and VPL16
static int POSITIONING_DATA_PORT = 8308;
static const int POLL_TIMEOUT = 1000; // one second (in msec)

/** @brief Live Velodyne input from socket. */
class SocketInput: public Input {
public:
    SocketInput();
    virtual ~SocketInput();
    void init(int &port);
    int get_firing_data_packet(velodyne_msgs::VelodynePacket *pkt);
    int get_positioning_data_packtet(const NMEATimePtr& nmea_time);
private:
    int _sockfd;
    int _port;
    bool input_available(int timeout);
};

} // velodyne_driver namespace

#endif // __VELODYNE__inputH
