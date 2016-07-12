/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   data_type.h
*@author fengkaiwen01
*@brief
*/

#ifndef CAR_ROS_DRIVERS_VELODYNE_VELODYNE_DRIVER_INCLUDE_VELODYNE_DRIVER_DATA_TYPE_H
#define CAR_ROS_DRIVERS_VELODYNE_VELODYNE_DRIVER_INCLUDE_VELODYNE_DRIVER_DATA_TYPE_H

#include <stdint.h>

namespace velodyne_driver {

/**
* Raw Velodyne packet constants and structures.
*/
const uint16_t RAW_SCAN_SIZE = 3;
const uint16_t SCANS_PER_BLOCK = 32;
const uint16_t BLOCK_DATA_SIZE = (SCANS_PER_BLOCK * RAW_SCAN_SIZE);

const uint16_t PACKET_SIZE = 1206;
const uint16_t BLOCKS_PER_PACKET = 12;
const uint16_t PACKET_STATUS_SIZE = 4;
const uint16_t SCANS_PER_PACKET = (SCANS_PER_BLOCK * BLOCKS_PER_PACKET);

/** \brief Raw Velodyne data block.
*
*  Each block contains data from either the upper or lower laser
*  bank.  The device returns three times as many upper bank blocks.
*
*  use stdint.h types, so things work with both 64 and 32-bit machines
*/
struct RawBlock {
    uint16_t laser_block_id;        ///< UPPER_BANK or LOWER_BANK
    uint16_t rotation;      ///< 0-35999, divide by 100 to get degrees
    uint8_t  data[BLOCK_DATA_SIZE];
};

/** \brief Raw Velodyne packet.
*
*  revolution is described in the device manual as incrementing
*    (mod 65536) for each physical turn of the device.  Our device
*    seems to alternate between two different values every third
*    packet.  One value increases, the other decreases.
*
*  status has either a temperature encoding or the microcode level
*/
union UPacket {
    struct {
        RawBlock blocks[BLOCKS_PER_PACKET];
        unsigned int gps_timestamp;
        unsigned char status_type;
        unsigned char status_value;
    };
    uint8_t data[1206];
};
typedef boost::shared_ptr<UPacket> UPacketPtr;

/**
*\brief Raw Velodyne packet.
*/
enum StatusType {
    HOURS = 72,
    MINUTES = 77,
    SECONDS = 83,
    DATE = 68,
    MONTH = 78,
    YEAR = 89,
    GPS_STATUS = 71
};

struct NMEATime {
    uint16_t year;
    uint16_t mon;
    uint16_t day;
    uint16_t hour;
    uint16_t min;
    uint16_t sec;
};
typedef boost::shared_ptr<NMEATime> NMEATimePtr;

}

#endif /* CAR_ROS_DRIVERS_VELODYNE_VELODYNE_DRIVER_INCLUDE_VELODYNE_DRIVER_DATA_TYPE_H */
