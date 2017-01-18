#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H

#include "sharedmem_transport/sharedmem_block.h"
#include "ros/message_deserializer.h"
#include "ros/subscription_callback_helper.h"
#include "ros/forwards.h"

namespace sharedmem_transport {

/**
 * \brief Class for Shared Memory Segment, which is defined to describer the segment
 *
 */
class SharedMemorySegment {
public:
    SharedMemorySegment() : _wrote_num(-1), _writing_num(-1), _transport_mechanism(RADICAL) {
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
                         uint32_t queue_size, uint64_t msg_size, 
                         SharedMemoryBlock*& descriptors_pub,
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
    bool write_data(const ros::SerializedMessage& msg, uint32_t queue_size,
        SharedMemoryBlock* descriptors_pub, uint8_t** addr_pub);

    /**
     * \brief Read data from block for sharedmem subscriber
     *
     * @param msg: msg waited to be read
     * @param queue_size: total block num
     * @param last_read_index: index which is used to record last readable block
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     * @param helper: subscription callback helper
     * @param topic: topic name
     * Return read result, true or false
     */
    bool read_data(ros::VoidConstPtr& msg, uint32_t& queue_size, int32_t& last_read_index,
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub,
        ros::SubscriptionCallbackHelperPtr& helper, const std::string& topic);

    bool read_data(uint32_t& queue_size, int32_t& last_read_index,
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub,
        const std::string& topic, int32_t& msg_buffer, uint32_t& msg_size);

    /**
     * \brief Write data to block for sharedmem publisher
     *
     * @param msg: msg waited to be wrote
     * @param queue_size: total block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param addr_pub: block maped address from sharedmem publisher
     * Return write result, true or false
     */
    bool write_radical_data(const ros::SerializedMessage& msg, uint32_t queue_size,
        SharedMemoryBlock* descriptors_pub, uint8_t** addr_pub);

    /**
     * \brief Read data from block for sharedmem subscriber
     *
     * @param msg: msg waited to be read
     * @param last_read_index: index which is used to record last readable block
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     * @param helper: subscription callback helper
     * @param topic: topic name
     * Return read result, true or false
     */
    bool read_radical_data(ros::VoidConstPtr& msg, int32_t& last_read_index,
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub,
        ros::SubscriptionCallbackHelperPtr& helper, const std::string& topic);
    
    //overload
    bool read_radical_data(int32_t& last_read_index,
        SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub, const std::string& topic, 
        int32_t & msg_buffer, uint32_t& msg_size);

    /**
     * \brief Write conservative data to block for sharedmem publisher
     *
     * @param msg: msg waited to be wrote
     * @param queue_size: total block num
     * @param descriptors_pub: descriptors maped address from sharedmem publisher
     * @param addr_pub: block maped address from sharedmem publisher
     * Return write result, true or false
     */
    bool write_conservative_data(const ros::SerializedMessage& msg,
        uint32_t& queue_size, SharedMemoryBlock* descriptors_pub,
        uint8_t** addr_pub);

    /**
     * \brief Read conservative data from block for sharedmem subscriber
     *
     * @param msg: msg waited to be read
     * @param queue_size: total block num
     * @param last_read_index: index which is used to record last read block
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     * @param helper: subscription callback helper
     * @param topic: topic name
     * Return read result, true or false
     */
    bool read_conservative_data(ros::VoidConstPtr& msg, uint32_t& queue_size,
        int32_t& last_read_index, SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub,
        ros::SubscriptionCallbackHelperPtr& helper, const std::string& topic);

    //overload
    bool read_conservative_data(uint32_t& queue_size, int32_t& last_read_index,
    SharedMemoryBlock* descriptors_sub, uint8_t** addr_sub, const std::string& topic, 
    int32_t& msg_buffer, uint32_t& msg_size);

    //overload
    bool read_conservative_data(uint32_t& queue_size, int32_t& block_index, 
        SharedMemoryBlock* descriptors_sub);

    /**
     * \brief Set _transport_mechanism, when node init
     *
     * @param transport_mechanism: radicl mechanism is 0, conservative mechanism is 1
     */
    void set_transport_mechanism(int32_t transport_mechanism) {
        _transport_mechanism = transport_mechanism;
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

    /**
     * \brief Allow write the message
     *
     * @param queue_size: queue size
     * @param descriptors_mgr: descriptors maped address from sharedmem manager
     */
    void allow_write_message(uint32_t queue_size, SharedMemoryBlock*& descriptors_mgr);

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
    void reset_next_conservative_writable_block(uint32_t queue_size, 
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
    enum transport_mechanism_enum {RADICAL = 0, CONSERVATIVE = 1, SIMULATOR = 2};
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_SEGMENT_H
