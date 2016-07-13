/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
*
************************************************************************/
/**
* @file rawdata.h
* @author fengkaiwen01
* @date 2016/03/8
*
**/

#ifndef VELODYNE_POINTCLOUD_RAWDATA_H
#define VELODYNE_POINTCLOUD_RAWDATA_H

#include <errno.h>
#include <stdint.h>
#include <string>
#include <boost/format.hpp>
#include <math.h>

#include <ros/ros.h>
#include <pcl_ros/point_cloud.h>
#include <sensor_msgs/PointCloud2.h>
#include <std_msgs/Time.h>
#include <sensor_msgs/Imu.h>
#include <nav_msgs/Odometry.h>
#include "velodyne_msgs/VelodyneScanUnified.h"
#include "point_types.h"
#include "calibration.h"
#include "const_variables.h"
#include "math_util/math_util.h"
#include "time_util/time_util.h"

namespace velodyne_rawdata {

// Shorthand typedefs for point cloud representations
typedef velodyne_pointcloud::PointXYZIT VPoint;
typedef pcl::PointCloud<VPoint> VPointCloud;

/**
* Raw Velodyne packet constants and structures.
*/
static const int BLOCK_SIZE = 100;
static const int RAW_SCAN_SIZE = 3;
static const int SCANS_PER_BLOCK = 32;
static const int BLOCK_DATA_SIZE = (SCANS_PER_BLOCK * RAW_SCAN_SIZE);

static const float ROTATION_RESOLUTION = 0.01f; /**< degrees */
// static const uint16_t ROTATION_MAX_UNITS = 36000; [>*< hundredths of degrees <]
// because angle_rang is [0, 36000], so thie size is 36001
static const uint16_t ROTATION_MAX_UNITS = 36001; /**< hundredths of degrees */

/** According to Bruce Hall DISTANCE_MAX is 65.0, but we noticed
*  valid packets with readings up to 130.0. */
static const float DISTANCE_MAX = 130.0f;        /**< meters */
static const float DISTANCE_RESOLUTION = 0.002f; /**< meters */
static const float DISTANCE_MAX_UNITS = (DISTANCE_MAX / DISTANCE_RESOLUTION + 1.0);

// laser_block_id
static const uint16_t UPPER_BANK = 0xeeff;
static const uint16_t LOWER_BANK = 0xddff;

static const float ANGULAR_RESOLUTION = 0.00300919;

/** Special Defines for VLP16 support **/
static const int VLP16_FIRINGS_PER_BLOCK = 2;
static const int VLP16_SCANS_PER_FIRING = 16;
static const int VLP16_BLOCK_TDURATION = 110.592;
static const int VLP16_DSR_TOFFSET = 2.304;
static const int VLP16_FIRING_TOFFSET = 55.296;


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

/** used for unpacking the first two data bytes in a block
*
*  They are packed into the actual data stream misaligned.  I doubt
*  this works on big endian machines.
*/
union TwoBytes {
    uint16_t uint;
    uint8_t  bytes[2];
};

static const int PACKET_SIZE = 1206;
static const int BLOCKS_PER_PACKET = 12;
static const int PACKET_STATUS_SIZE = 4;
static const int SCANS_PER_PACKET = (SCANS_PER_BLOCK * BLOCKS_PER_PACKET);

enum StatusType {
    HOURS = 72,
    MINUTES = 77,
    SECONDS = 83,
    DATE = 68,
    MONTH = 78,
    YEAR = 89,
    GPS_STATUS = 71
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
struct RawPacket {
    RawBlock blocks[BLOCKS_PER_PACKET];
    // uint16_t revolution;
    // uint8_t status[PACKET_STATUS_SIZE];
    unsigned int gps_timestamp;
    unsigned char status_type;
    unsigned char status_value;
};

//Convert related config, get value from private_nh param server, used by velodyne rawdata
struct Config {
    double max_range;                ///< maximum range to publish
    double min_range;                ///< minimum range to publish
    double max_angle;
    double min_angle;
    double view_direction;
    double view_width;
    std::string calibration_file;
    std::string imu_sync;
    std::string model;                //VLP16,32E, 64E_32
    bool use_gps;
    bool organized;                  //is point cloud order
    bool ts_aligned;                 //timestamp align state
};

static const float nan = std::numeric_limits<float>::signaling_NaN();

/** \brief Velodyne data conversion class */
class RawData {
public:
    RawData(Config config);
    ~RawData() {}

    /** \brief Set up for data processing.
     *
     *  Perform initializations needed before data processing can
     *  begin:
     *
     *    - read device-specific angles calibration
     *
     *  @param private_nh private node handle for ROS parameters
     *  @returns 0 if successful;
     *           errno value for failure
     */
    void setup();
    void generate_pointcloud(const velodyne_msgs::VelodyneScanUnified::ConstPtr &scan_msg,
            velodyne_rawdata::VPointCloud::Ptr &out_msg);
    bool iterate_packets(const velodyne_msgs::VelodyneScanUnified::ConstPtr&
                scan_msg, VPointCloud& out_msg);
    boost::function<void (RawData*, const velodyne_msgs::VelodynePacket &, VPointCloud &)> _unpack;
    boost::function<void (RawData*, VPointCloud::Ptr &)> _order_pointcloud;

    const velodyne_pointcloud::Calibration& get_calibration();
    double get_last_timestamp();

protected:
    //inline void setBaseTimeFromROS(ros::Time time);
    void set_base_time_from_packets(const velodyne_msgs::VelodynePacket &pkt);

private:
    // Previous Velodyne packet time stamp. (offset to the top hour)
//    double _lower_previous_packet_stamp;
//    double _upper_previous_packet_stamp;
    double _previous_packet_stamp[4];
    // Base time. (Full time)
//    uint64_t _lower_gps_base_usec;
//    uint64_t _upper_gps_base_usec;
    uint64_t _gps_base_usec[4];
    // Last Velodyne packet time stamp. (Full time)
    double _last_time_stamp;

    std::vector<int> _offsets;
    Config _config;

    const float (*_inner_time)[12][32];

    /**
     * \brief Calibration file
     */
    velodyne_pointcloud::Calibration _calibration;

    float _sin_rot_table[ROTATION_MAX_UNITS];
    float _cos_rot_table[ROTATION_MAX_UNITS];

    void init_offsets_64e(); // for 64E_s2
    void init_process_functions ();
    bool is_scan_valid(int rotation, float distance);
    void set_angle_params(double view_direction, double view_width);
    void check_gps_status(const velodyne_msgs::VelodynePacket& pkt);

    /**
     * \brief Unpack velodyne packet for VLP16
     *
     * TODO not use this funcion yet, should complete when use
     */
    void unpack16(const velodyne_msgs::VelodynePacket &pkt, VPointCloud &pc);

    /**
     * \brief unpack velodyne packet for both 32E and 64E_32
     *
     * TODO not use this funcion yet, should complete when use
     */
    void unpack_32_and_64(const velodyne_msgs::VelodynePacket &pkt, VPointCloud &pc);

    /**
     * \brief Compute coords with the data in block
     *
     * @param tmp A two bytes union store the value of laser distance infomation
     * @param index The index of block
     */
    void compute_coords(const union TwoBytes &tmp,
            const velodyne_pointcloud::LaserCorrection &corrections,
            const uint16_t &rotation, const uint8_t &intensity, VPoint &point);

    // refer to the official manual
    int intensity_compensate(const velodyne_pointcloud::LaserCorrection &corrections,
            const union TwoBytes &tmp, int intensity);

    //order point cloud fod IDL by velodyne model
    inline void order_pointcloud16(VPointCloud::Ptr &cloud); // TODO not use yet, should check when use
    inline void order_pointcloud32(VPointCloud::Ptr &cloud); // TODO not use yet, should check when use
    inline void order_pointcloud64(VPointCloud::Ptr &cloud);
    //bocong
    inline double get_gps_stamp(double current_stamp, double &previous_stamp,  uint64_t &gps_base_usec);
    /** in-line test whether a point is in range */
    bool point_in_range(float range);

    double get_timestamp(double base_time, float time_offset, uint16_t laser_block_id);

    void timestamp_check(double timestamp);

    inline VPoint get_nan_point(double timestamp);

}; //class RawData
} //namespace velodyne_rawdata

#endif //VELODYNE_POINTCLOUD_RAWDATA_H

