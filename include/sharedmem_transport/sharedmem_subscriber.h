#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_SUBSCRIBER_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_SUBSCRIBER_H

#include "message_transport/simple_subscriber_plugin.h"
#include "sharedmem_transport/SharedMemoryHeader.h"
#include "sharedmem_transport/sharedmem_util.h"

namespace sharedmem_transport {

/**
 * \brief Template class for SharedMemorySubscriber, extends SimpleSubscriberPlugin
 *
 */
template<class Base>
class SharedMemorySubscriber: public message_transport::SimpleSubscriberPlugin < Base,
        sharedmem_transport::SharedMemoryHeader > {
public:
    SharedMemorySubscriber() {
    }

    virtual ~SharedMemorySubscriber() {
    }

    virtual std::string getTransportName() const {
        return ROS_SHM_TRANSPORT_NAME;
    }

protected:
    /**
     * \brief receive msg from subscriber
     *
     * @param segment_mgr: segment manager pointer
     * @param descriptors_sub: descriptors maped address from sharedmem subscriber
     * @param addr_sub: block maped address from sharedmem subscriber
     */
    void receive_msg(SharedMemorySegment*& segment_mgr, 
        SharedMemoryBlock*& descriptors_sub, uint8_t** addr_sub) {
        ROS_DEBUG("Receive running");
        
        // Define variables
        bool is_new_msg = false;
        int32_t last_read_index = -1;
        boost::shared_ptr < Base > message_ptr(new Base);
        
        // Receive msg
        while (ros::ok()) {
            is_new_msg = segment_mgr->read_data(*message_ptr, &last_read_index, 
                descriptors_sub, addr_sub);
            
            if (is_new_msg && _user_cb && ros::ok()) {
                ROS_DEBUG("==== Read block %d and excute callback ====", last_read_index);
                (*_user_cb)(message_ptr);
            }
        }
    }

    virtual void internalCallback(const sharedmem_transport::SharedMemoryHeaderConstPtr& message,
                                  const typename message_transport::SimpleSubscriberPlugin < Base,
                                  sharedmem_transport::SharedMemoryHeader >::Callback& user_cb) {
        // Get user callback
        _user_cb = &user_cb;

        // Define variables
        boost::interprocess::managed_shared_memory* segment = NULL;
        SharedMemorySegment* segment_mgr = NULL;
        SharedMemoryBlock* descriptors_sub = NULL;
        uint32_t queue_size;
        uint8_t** addr_sub = NULL;
        SharedMemoryUtil sharedmem_util;

        // Get segment
        segment = sharedmem_util.get_segment(this->getTopic().c_str());
        
        // Get setment mgr
        segment_mgr = sharedmem_util.get_segment_mgr(segment);

        // Get block descriptors
        sharedmem_util.get_header_and_size(segment, descriptors_sub, &queue_size);
        
        if (!segment || !segment_mgr || !descriptors_sub) {
            ROS_FATAL("==== Connected to SHM failed! ====");
            delete segment;
            segment = NULL;
            return;
        }

        // Map all blocks from subscriber
        addr_sub = new uint8_t*[queue_size];
        if (!segment_mgr->map_all_blocks(*segment, queue_size, addr_sub)) {
            ROS_FATAL("==== Map all blocks failed! ====");
            return;
        }

        // Receive message
        receive_msg(segment_mgr, descriptors_sub, addr_sub);
    }

private:
    const typename message_transport::SimpleSubscriberPlugin < Base,
          sharedmem_transport::SharedMemoryHeader >::Callback* _user_cb;
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_SUBSCRIBER_H
