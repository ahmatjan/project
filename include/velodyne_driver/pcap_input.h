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

#ifndef VELODYNE_DRIVER_PCAP_INPUT_H
#define VELODYNE_DRIVER_PCAP_INPUT_H

#include <unistd.h>
#include <stdio.h>
#include <pcap.h>
#include <ros/ros.h>

#include "input.h"

namespace velodyne_driver {
/** @brief Velodyne input from PCAP dump file.
 *
 * Dump files can be grabbed by libpcap, Velodyne's DSR software,
 * ethereal, wireshark, tcpdump, or the \ref vdump_command.
 */
class PcapInput: public Input {
public:
    PcapInput(double packet_rate,
              const std::string &filename,
              bool read_once = false,
              bool read_fast = false,
              double repeat_delay = 0.0);
    virtual ~PcapInput();

    void init();
    int get_firing_data_packet(velodyne_msgs::VelodynePacket *pkt);
    int get_positioning_data_packtet(const NMEATimePtr& nmea_time);

private:

    std::string _filename;
    FILE* _fp;
    pcap* _pcap;
    char _errbuf[PCAP_ERRBUF_SIZE];
    bool _empty;
    bool _read_once;
    bool _read_fast;
    double _repeat_delay;
    ros::Rate _packet_rate;
};

} // velodyne_driver namespace

#endif // __VELODYNE__inputH
