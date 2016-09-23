#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_BLOCK_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_BLOCK_H

#include <boost/interprocess/managed_shared_memory.hpp>
#include <boost/interprocess/sync/interprocess_mutex.hpp>
#include <boost/interprocess/sync/interprocess_condition.hpp>
#include <boost/interprocess/sync/scoped_lock.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

#include <ros/ros.h>
#include <time.h>
#include <signal.h>
#include <setjmp.h>
#include <inttypes.h>

namespace sharedmem_transport {

// Allocated size compared to msg size for each block, default 2.5
const float ROS_SHM_BLOCK_SIZE_RATIO = 2.5;
const int ROS_SHM_UTIL_SEGMENT_NAME_SIZE = 1000; // Util segment name temp size
const uint64_t ROS_SHM_BLOCK_SIZE = 250; // block size, byte
const uint64_t ROS_SHM_SEGMENT_SIZE = 500; // segment size, byte
const uint32_t ROS_SHM_BLOCK_MUTEX_TIMEOUT_SEC = 1; // Timeout for block mutex, sec
const uint32_t ROS_SHM_BLOCK_STATUS_TIMEOUT_SEC = 2; // Timeout for block status, sec

// Timeout for block conservative mutex, sec
const uint32_t ROS_SHM_BLOCK_MUTEX_CONSERVATIVE_TIMEOUT_SEC = 5;

// Timeout for block conservative overtime, times
const uint32_t ROS_SHM_BLOCK_CONSERVATIVE_OVERTIME_TIMES = 15000;

// Timeout for block conservative reserve inteval, usec
const uint32_t ROS_SHM_BLOCK_CONSERVATIVE_RESERVE_INTERVAL_USEC = 1000;

const std::string ROS_SHM_TRANSPORT_NAME = "sharedmem";
const std::string ROS_SHM_REGISTER_SEGMENT_SERVICE = "/sharedmem_manager/register_segment";

/**
 * \brief Class for Shared Memory Block, which is defined to describer the block.
 * 
 */
class SharedMemoryBlock {
public:
    SharedMemoryBlock();

    SharedMemoryBlock(bool wf, uint32_t rc, uint32_t ms, uint32_t as, long wt);

    virtual ~SharedMemoryBlock() {
    }

    /**
     * \brief Try reserve block for write
     *
     * Return result for try, true or false
     */
    bool try_reserve_for_radical_write();

    /**
     * \brief Try reserve block for read
     *
     * Return result for try, true or false
     */
    bool try_reserve_for_radical_read();

    /**
     * \brief Release reserve block for write
     *
     */
    void release_reserve_for_radical_write();

    /**
     * \brief Release reserve block for read
     *
     */
    void release_reserve_for_radical_read();

    /**
     * \brief Try reserve block for conservative write
     *
     * Return result for try, true or false
     */
    bool try_reserve_for_conservative_write();

    /**
     * \brief Try reserve block for conservative read
     *
     */
    void try_reserve_for_conservative_read();

    /**
     * \brief Release reserve block for conservative write
     *
     */
    void release_reserve_for_conservative_write();

    /**
     * \brief Release reserve block for conservative read
     *
     */
    void release_reserve_for_conservative_read();

    /**
     * \brief Set conservative block reading count. 
     * when we want to leave the current block, we have to ensure the next 
     * wrote block can not be written second times.
     *
     */
    void set_reading_count_for_conservative_block();

    /**
     * \brief Unset conservative reading count. 
     * The subscriber node is aborted  when reading a block, we must unset 
     * reading_count order to publisher node can write a new message into 
     * the block.
     *
     */
    void unset_reading_count_for_conservative_block();

    /**
     * \brief Check block status. If the block waiting time since being wrote last 
     * is larger than some given value, we assume that there are some problems in 
     * the block and then we reset the block status.
     *
     * @param wt_timeout: timeout
     * Return if the block status has been reset, true or false.
     */
    bool check_and_reset_block_status(long wt_timeout);

    /**
     * \brief Reset conservative reading count.
     * The subscriber node is aborted  when reading a block, we must unset
     * reading_count order to publisher node can write a new message into
     * the block.
     *
     */
    void reset_reading_count_for_conservative_block();

    /**
     * \brief Write to block
     *
     * @param dest: block address
     * @param msg: msg waited to be wrote
     * Return write result, true or false
     */
    template<class M>
    bool write_to_block(uint8_t* dest, const M& msg) {
        // Serialize Data
        bool result = serialize(dest, msg);

        return result;
    }

    /**
     * \brief Read from block
     *
     * @param src: block address
     * @param msg: msg waited to be deserialized to
     * Return read result, true or false
     */
    template<class Base>
    bool read_from_block(uint8_t* src, Base& msg) {
        // Deserialze msg from block
        deserialize<Base>(src, msg);
        
        return true;
    }

private:
    /**
     * \brief Serialize msg to block
     *
     * @param dest: block address
     * @param msg: msg waited to be serialized
     * Return serialize result, true or false
     */
    template<class M>
    bool serialize(uint8_t* dest, const M& msg) {
        ROS_DEBUG("==== Serialize start!!! ====");

        {
            // Check size msg, before serialize
            _msg_size = ros::serialization::serializationLength(msg);
            if (_msg_size > _alloc_size) {
                ROS_WARN("==== Msg size overflows the block, serialize failed ====");
                return false;
            }

            // Serialize msg to block
            ROS_DEBUG("==== Serialising to %p, %" PRIu64 " bytes ====", dest, _msg_size);
            ros::serialization::OStream out(dest, _msg_size);
            ros::serialization::serialize(out, msg);
        }

        ROS_DEBUG("==== Serialize end!!! ====");

        return true;
    }

    /**
     * \brief Deserailize msg from block
     *
     * @param src: block address
     * @param msg: msg waited to be deserialized to
     */
    template<class Base>
    void deserialize(uint8_t* src, Base& msg) {
        ROS_DEBUG("==== Deserialize start!!! ====");

        {
            // Deserailize msg from block
            ROS_DEBUG("==== Deserializing from %p, %" PRIu64 " bytes ====", src, _msg_size);
            ros::serialization::IStream in(src, _msg_size);
            ros::serialization::deserialize(in, msg);
        }

        ROS_DEBUG("==== Deserialize end!!! ====");
    }

    /**
     * \brief Reset waiting_time to current system clock, when a publisher 
     * wrote the block every time.
     *
     * It is used to mark the time since the block has been wrote by a publisher.
     * When the time interval is longer than some given value, we assumed that it 
     * exists some timeout problem in the block, including being wrote or being read.
     */
    inline void reset_waiting_time() {
        boost::interprocess::scoped_lock<boost::interprocess::interprocess_mutex> lock(
            _waiting_time_mutex);

        _waiting_time = static_cast<long>(ros::Time::now().toSec());
    }

private:
    // Mutex to protect access to _writing_flag, _reading_count
    boost::interprocess::interprocess_mutex _write_read_mutex;
    // When use conservative mechanism, publisher notified subscribers after writing msg.
    boost::interprocess::interprocess_condition _read_cond;
    bool _writing_flag;
    uint32_t _reading_count;
 
    uint64_t _msg_size;
    uint64_t _alloc_size;

    // Mutex to protect access to _waiting_time
    boost::interprocess::interprocess_mutex _waiting_time_mutex;
    long _waiting_time;
};

} // namespace sharedmem_transport
#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_BLOCK_H
