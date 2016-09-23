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
    SharedMemorySegment() : _wrote_num(-1) {
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
        ROS_DEBUG("==== Write start!!!! ====");

        int32_t block_index;

        {
            // Lock _wrote_num_mutex in segment
            ROS_DEBUG("==== Lock _wrote_num_mutex in segment ====");
            boost::interprocess::scoped_lock < boost::interprocess::interprocess_mutex > 
                segment_lock(_wrote_num_mutex);

            // Reserve next writable block
            block_index = reserve_next_writable_block(queue_size, descriptors_pub);
        }

        // Get descriptor current pointer
        SharedMemoryBlock* descriptors_curr = descriptors_pub + block_index;

        // Write to block
        bool result = descriptors_curr->write_to_block(addr_pub[block_index], msg);

        // Release reserve block, after we have wrote to block
        descriptors_curr->release_reserve_for_write();

        // Check write result, if failed, return; if succeed, continue
        if (!result) {
            return false;
        }

        // Set _wrote_num to current
        set_wrote_num(block_index);

        // Publisher wrote done, notify subscriber read
        _wrote_num_cond.notify_all();

        ROS_DEBUG("==== Write end!!!! ====");

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
    bool read_data(Base& msg, int32_t* last_read_index, 
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub) {
        ROS_DEBUG("==== Read start!!! ====");

        int32_t block_index;

        {
            // Lock _wrote_num_mutex in segment
            ROS_DEBUG("==== Lock _wrote_num_mutex in segment ====");
            boost::interprocess::scoped_lock < boost::interprocess::interprocess_mutex > 
                segment_lock(_wrote_num_mutex);

            // Block is not available for read, or block has been read
            if (_wrote_num == -1 || _wrote_num == *last_read_index) {
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
            if (!reserve_next_readable_block(descriptors_sub)) {
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
        descriptors_curr->release_reserve_for_read();

        // Check read result, if failed, return; if succeed, continue
        if (!result) {
            return false;
        }

        // Set last read num
        *last_read_index = block_index;
        
        ROS_DEBUG("==== Read end!!! ====");

        return true;
    }

private:
    /**
     * \brief Reserve next writable block according _wrote_num
     *
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param queue_size: block num
     * Return block index which is used to record next writable block
     */
    int32_t reserve_next_writable_block(uint32_t queue_size, SharedMemoryBlock* descriptors_pub);

    /**
     * \brief Reserve next readable block according _wrote_num
     *
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * Return result for reserve next readable block, true or false
     */
    bool reserve_next_readable_block(SharedMemoryBlock* descriptors_sub);

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
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H
