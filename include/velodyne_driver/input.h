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

#ifndef VELODYNE_DRIVER_INPUT_H
#define VELODYNE_DRIVER_INPUT_H

#include <unistd.h>
#include <stdio.h>
#include <pcap.h>
#include <ros/ros.h>

#include "data_type.h"
#include "velodyne_msgs/VelodyneScanUnified.h"

namespace velodyne_driver {

static const size_t FIRING_DATA_PACKET_SIZE = 1206;
static const size_t POSITIONING_DATA_PACKET_SIZE = 512;
static const size_t ETHERNET_HEADER_SIZE = 42;
static const int PCAP_FILE_END = -1;
static const int SOCKET_TIMEOUT = -2;
static const int RECIEVE_FAIL = -3;

/** @brief Pure virtual Velodyne input base class */
class Input {
public:
    Input() {}
    virtual ~Input() {};

    /** @brief Read one Velodyne packet.
     *
     * @param pkt points to VelodynePacket message
     *
     * @returns 0 if successful,
     *          -1 if end of file
     *          > 0 if incomplete packet (is this possible?)
     */
    virtual int get_firing_data_packet(velodyne_msgs::VelodynePacket *pkt) = 0;
    virtual int get_positioning_data_packtet(const NMEATimePtr& nmea_time) = 0;
    virtual void init() {};
    virtual void init(int &port) {};
protected:
    bool exract_nmea_time_from_packet(const NMEATimePtr& nmea_time, const uint8_t* bytes);

};

} // velodyne_driver namespace

#endif // __VELODYNE__inputH
