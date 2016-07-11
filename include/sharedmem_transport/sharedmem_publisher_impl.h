#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_PUBLISHER_IMPL_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_PUBLISHER_IMPL_H

#include "sharedmem_transport/SharedMemoryRegisterSegment.h"
#include "sharedmem_transport/sharedmem_util.h"

namespace sharedmem_transport {

/**
 * \brief Class for SharedMemoryPublisherImpl, which implements basic functions 
 * for SharedMemoryPublisher.
 *
 */
class SharedMemoryPublisherImpl {
public:
    SharedMemoryPublisherImpl();

    virtual ~SharedMemoryPublisherImpl();

    /**
     * \brief Check if size ratio is valid
     * 
     * Return result for size ratio, true or false
     */
    bool check_size_ratio();

    /**
     * \brief Create topic segment when pulish first msg
     *
     * @param topic: topic name
     * @param index: index which publish_fn needs
     * @param queue_size: block num
     * @param msg_size: msg size
     * Return result for create topic segment, true or false;
     */
    bool create_topic_segement(const std::string& topic, int32_t& index, 
        uint32_t queue_size, uint64_t msg_size);

    /**
     * \brief Register segment to manager
     * 
     * @param topic: topic name
     * Return result for register segment to manager, true or false
     */
    bool register_segment_to_manager(const std::string& topic);

    /**
     * \brief Set node handle
     *
     * @param nh node handle pointer
     */
    void set_node_handle(ros::NodeHandle& nh) {
        _nh = nh;
    }

    /**
     * \brief Publish msg
     *
     * @param message: message which will be published
     * @param queue_size: block num
     */
    template<class M>
    void publish_msg(const M& message, uint32_t queue_size) {
        // Publish msg to shared memory
        if (!_segment_mgr->write_data(message, queue_size, _descriptors_pub, _addr_pub)) {
            ROS_WARN("==== Publish message failed! ====");
        }
    }

private:
    boost::interprocess::managed_shared_memory* _segment;
    SharedMemorySegment* _segment_mgr;
    SharedMemoryBlock* _descriptors_pub;
    uint8_t** _addr_pub;
    
    bool _client_registered;
    ros::NodeHandle _nh;
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_PUBLISHER_IMPL_H
