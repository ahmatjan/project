#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H

#include "sharedmem_transport/sharedmem_block.h"

namespace sharedmem_transport {

/**
 * \brief Class for Shared Memory Segment, which is defined to describer the segment
 *
 */
class SharedMemorySegment {
public:
    SharedMemorySegment() : _wrote_num(-1), _writing_num(-1), _transport_mechanism(CONSERVATIVE) {
    }

    virtual ~SharedMemorySegment() {
    }

    /**
     * \brief Init all blocks from publisher, before publisher write fisrt msg
     *
     * @param segment: segment pointer
     * @param queue_size: total block num which needs to be allocated
     * @param msg_size: single block size which needs to be allocated
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param addr_pub: block maped address from sharedmem publisher
     * Return init result, true or false
     */
    bool init_all_blocks(boost::interprocess::managed_shared_memory& segment, 
        uint32_t queue_size, uint64_t msg_size, SharedMemoryBlock*& descriptors_pub, 
        uint8_t** addr_pub);

    /**
     * \brief Map all blocks from subscriber, before subscriber read first msg
     *
     * @param segment: segment pointer
     * @param queue_size: total block num
     * @param addr_sub: block maped address from sharedmem subscriber
     * Return map result, true or false
     */
    bool map_all_blocks(boost::interprocess::managed_shared_memory& segment,
        uint32_t queue_size, uint8_t** addr_sub);

    /**
     * \brief Clean timeout blocks from manager, regularly
     *
     * @param queue_size: total block num
     * @param descriptors_mgr: descriptors maped address from sharedmem manager
     */
    void clean_timeout_blocks(uint32_t queue_size, SharedMemoryBlock* descriptors_mgr);

    /**
     * \brief Write data to block for sharedmem publisher
     *
     * @param msg: msg waited to be wrote
     * @param queue_size: total block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param addr_pub: block maped address from sharedmem publisher
     * Return write result, true or false
     */
    template<class M>
    bool write_data(const M& msg, uint32_t queue_size, 
        SharedMemoryBlock* descriptors_pub, uint8_t** addr_pub) {
        if (_transport_mechanism == RADICAL) {
            return write_radical_data(msg, queue_size, descriptors_pub, addr_pub);
        } else if (_transport_mechanism == CONSERVATIVE) {
            return write_conservative_data(msg, queue_size, descriptors_pub, addr_pub);
        }
    }

    /**
     * \brief Read data from block for sharedmem subscriber
     *
     * @param msg: msg waited to be read
     * @param queue_size: total block num
     * @param last_read_index: index which is used to record last readable block
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     * Return read result, true or false
     */
    template<class Base>
    bool read_data(Base& msg, uint32_t& queue_size, int32_t& last_read_index, 
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub) {

        if (_transport_mechanism == RADICAL) {
            return read_radical_data(msg, last_read_index, descriptors_sub, addr_sub);
        } else if (_transport_mechanism == CONSERVATIVE) {
            return read_conservative_data(msg, queue_size, last_read_index, descriptors_sub, 
                addr_sub);
        }
    }

    /**
     * \brief Write radical data to block for sharedmem publisher
     *
     * @param msg: msg waited to be wrote
     * @param queue_size: total block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param addr_pub: block maped address from sharedmem publisher
     * Return write result, true or false
     */
    template<class M>
    bool write_radical_data(const M& msg, uint32_t queue_size, 
        SharedMemoryBlock* descriptors_pub, uint8_t** addr_pub) {
        ROS_DEBUG("==== Write radical start!!!! ====");

        int32_t block_index;

        {
            // Lock _wrote_num_mutex in segment
            ROS_DEBUG("==== Lock _wrote_num_mutex in segment ====");
            boost::interprocess::scoped_lock < boost::interprocess::interprocess_mutex > 
                segment_lock(_wrote_num_mutex);

            // Reserve next writable block
            block_index = reserve_radical_writable_block(queue_size, descriptors_pub);
        }

        // Get descriptor current pointer
        SharedMemoryBlock* descriptors_curr = descriptors_pub + block_index;

        // Write to block
        bool result = descriptors_curr->write_to_block(addr_pub[block_index], msg);

        // Release reserve block, after we have wrote to block
        descriptors_curr->release_reserve_for_radical_write();

        // Check write result, if failed, return; if succeed, continue
        if (!result) {
            return false;
        }

        // Set _wrote_num to current
        set_wrote_num(block_index);

        // Publisher wrote done, notify subscriber read
        _wrote_num_cond.notify_all();

        ROS_DEBUG("==== Write radical end!!!! ====");

        return true;
    }

    /**
     * \brief Read data from block for sharedmem subscriber
     *
     * @param msg: msg waited to be read
     * @param last_read_index: index which is used to record last readable block
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     * Return read result, true or false
     */
    template<class Base>
    bool read_radical_data(Base& msg, int32_t& last_read_index, 
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub) {
        ROS_DEBUG("==== Read radical start!!! ====");

        int32_t block_index;

        {
            // Lock _wrote_num_mutex in segment
            ROS_DEBUG("==== Lock _wrote_num_mutex in segment ====");
            boost::interprocess::scoped_lock < boost::interprocess::interprocess_mutex > 
                segment_lock(_wrote_num_mutex);

            // Block is not available for read, or block has been read
            if (_wrote_num == -1 || _wrote_num == last_read_index) {
                ROS_DEBUG("==== Block %d is not available, or has been read ====", _wrote_num);

                // Define wait timeout
                boost::posix_time::ptime max_wait = 
                    boost::posix_time::microsec_clock::universal_time() + 
                    boost::posix_time::seconds(ROS_SHM_BLOCK_MUTEX_TIMEOUT_SEC);

                // Wait publisher wrote timeout
                if (!_wrote_num_cond.timed_wait(segment_lock, max_wait)) {
                    ROS_WARN("==== Wait publisher wrote timeout ====");
                    return false;
                }
            }

            // Reserve next readable block failed
            if (!reserve_radical_readable_block(descriptors_sub)) {
                return false;
            }

            // Reserve next readable block succeed
            block_index = _wrote_num;
        }

        // Get descriptor current pointer
        SharedMemoryBlock* descriptors_curr = descriptors_sub + block_index;

        // Read from block
        bool result = descriptors_curr->read_from_block(addr_sub[block_index], msg);

        // Release reserve block, after we have read from block
        descriptors_curr->release_reserve_for_radical_read();

        // Check read result, if failed, return; if succeed, continue
        if (!result) {
            return false;
        }

        // Set last read num
        last_read_index = block_index;
        
        ROS_DEBUG("==== Read radical end!!! ====");

        return true;
    }

    /**
     * \brief Write conservative data to block for sharedmem publisher
     *
     * @param msg: msg waited to be wrote
     * @param queue_size: total block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param addr_pub: block maped address from sharedmem publisher
     * Return write result, true or false
     */
    template<class M>
    bool write_conservative_data(const M& msg, uint32_t& queue_size, 
        SharedMemoryBlock* descriptors_pub, uint8_t** addr_pub) {
        ROS_DEBUG("==== Write conservative start!!!! ====");

        int32_t block_index = reserve_conservative_writable_block(queue_size, descriptors_pub); 
        int32_t count = 0;

        while (block_index == -1) {
            usleep(ROS_SHM_BLOCK_CONSERVATIVE_RESERVE_INTERVAL_USEC);  

            if (++count == ROS_SHM_BLOCK_CONSERVATIVE_OVERTIME_TIMES) {
                unset_next_conservative_writable_block(queue_size, descriptors_pub);
                count = 0; 
            }

            // Reserve next conservative readable block
            block_index = reserve_conservative_writable_block(queue_size, descriptors_pub);
        }

        // Publisher wrote done, notify subscriber read
        _writing_num_cond.notify_all();

        // Get descriptor current pointer
        SharedMemoryBlock* descriptors_curr = descriptors_pub + block_index;

        // Write to block
        bool result = descriptors_curr->write_to_block(addr_pub[block_index], msg);

        // Release reserve conservative block, after we have wrote to block
        descriptors_curr->release_reserve_for_conservative_write();

        ROS_DEBUG("==== Write conservative end!!!! ====");

        return result;
    }

    /**
     * \brief Read conservative data from block for sharedmem subscriber
     *
     * @param msg: msg waited to be read
     * @param queue_size: total block num
     * @param last_read_index: index which is used to record last read block
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     * Return read result, true or false
     */
    template<class Base>
    bool read_conservative_data(Base& msg, uint32_t& queue_size, int32_t& last_read_index, 
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub) {
        ROS_DEBUG("==== Read conservative start!!! ====");

        int32_t block_index;
        SharedMemoryBlock* descriptors_curr;

        {
            // Lock _writing_num_mutex in segment
            ROS_DEBUG("==== Lock _writing_num_mutex in segment ====");
            boost::interprocess::scoped_lock < boost::interprocess::interprocess_mutex > 
                segment_lock(_writing_num_mutex);

            // Get next conservative readable block index
            if (last_read_index == -1) {
                // Subscriber first run ,set reading_count for conservative block 
                block_index = _writing_num;
                (descriptors_sub + block_index)->set_reading_count_for_conservative_block();
            } else {
                block_index = (last_read_index + 1) % queue_size;
            }

            // Block is not available for read (no data, or has been read)
            while (_writing_num == -1 || block_index == _writing_num) {
                ROS_DEBUG("==== Block %d is not available ====", block_index);

                // Define wait timeout
                boost::posix_time::ptime max_wait = 
                    boost::posix_time::microsec_clock::universal_time() + 
                    boost::posix_time::seconds(ROS_SHM_BLOCK_MUTEX_CONSERVATIVE_TIMEOUT_SEC);

                // Wait publisher wrote timeout
                if (!_writing_num_cond.timed_wait(segment_lock, max_wait)) {
                    ROS_WARN("==== Wait publisher wrote timeout ====");
                }
            }

            ROS_DEBUG("==== Block %d is available ====", block_index);
        }

        // Get descriptor current pointer
        descriptors_curr = descriptors_sub + block_index;

        // Reserve next conservative readable block
        ROS_DEBUG("==== Reserve conservative block %d ====", block_index);
        reserve_conservative_readable_block(descriptors_curr);
                   
        // Read from block
        bool result = descriptors_curr->read_from_block(addr_sub[block_index], msg);

        // Release reserve conservative block, after we have read from block
        descriptors_curr->release_reserve_for_conservative_read();

        // Check read result, if failed, return; if succeed, continue
        if (!result) {
            return false;
        }

        // Set next block reading_count, when we want to leave current block
        (descriptors_sub + ((block_index + 1) % queue_size))
                ->set_reading_count_for_conservative_block();

        // Set last read block 
        last_read_index = block_index;

        ROS_DEBUG("==== Read conservative end!!! ====");

        return true;
    }

    /**
     * \brief Cleanup the modified block
     *
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param index: block index which has been set reading_count
     * @param queue_size: block num
     */
    void cleanup_modified_block(SharedMemoryBlock* descriptors_sub,
        int32_t index, uint32_t queue_size);

private:
    /**
     * \brief Reserve writable block according _wrote_num
     *
     * @param queue_size: block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * Return block index which is used to record writable block
     */
    int32_t reserve_radical_writable_block(uint32_t queue_size, 
        SharedMemoryBlock* descriptors_pub);

    /**
     * \brief Reserve readable block according _wrote_num
     *
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * Return result for reserve readable block, true or false
     */
    bool reserve_radical_readable_block(SharedMemoryBlock* descriptors_sub);

    /**
     * \brief Reserve conservative writable block according _wrote_num
     *
     * @param queue_size: block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * Return block index which is used to record writable block
     */
    int32_t reserve_conservative_writable_block(uint32_t queue_size, 
    SharedMemoryBlock* descriptors_pub);

    /**
     * \brief Reserve conservative readable block
     *
     * @param descriptors_curr: descriptors maped address from sharedmem subscriber
     */
    void reserve_conservative_readable_block(SharedMemoryBlock* descriptors_curr);


    /**
     * \brief Reset next conservative writable block
     *
     * @param descriptors_curr: descriptors maped address from sharedmem subscriber
     */
    void unset_next_conservative_writable_block(uint32_t queue_size, 
    SharedMemoryBlock* descriptors_pub);

    /**
     * \brief Set _wrote_num, after publisher wrote data to block
     *
     * @param wrote_num: block index which has been wrote last
     */
    inline void set_wrote_num(int32_t wrote_num) {
        boost::interprocess::scoped_lock < boost::interprocess::interprocess_mutex > lock(
            _wrote_num_mutex);

        _wrote_num = wrote_num;
    }

private:
    // Mutex to protect access _wrote_num
    boost::interprocess::interprocess_mutex _wrote_num_mutex;
    boost::interprocess::interprocess_condition _wrote_num_cond;
    int32_t _wrote_num;

    // Mutex to protect access _writing_num
    boost::interprocess::interprocess_mutex _writing_num_mutex;
    boost::interprocess::interprocess_condition _writing_num_cond;
    int32_t _writing_num;

    int32_t _transport_mechanism;
 
    enum transport_mechanism {RADICAL = 0, CONSERVATIVE = 1};
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H
