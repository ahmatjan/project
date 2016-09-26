#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_SUBSCRIBER_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_SUBSCRIBER_H

#include "message_transport/simple_subscriber_plugin.h"
#include "sharedmem_transport/SharedMemoryHeader.h"
#include "sharedmem_transport/sharedmem_util.h"
#include <boost/interprocess/sync/interprocess_mutex.hpp>
#include <boost/interprocess/sync/scoped_lock.hpp>

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
        if (_last_read_index >= 0) {
            boost::interprocess::scoped_lock<boost::interprocess::interprocess_mutex> lock(
                _shm_sub_mutex);
            cleanup_exit_subscriber(_last_read_index);
        }
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
    void receive_msg(SharedMemorySegment*& segment_mgr, uint32_t& queue_size, 
        SharedMemoryBlock*& descriptors_sub, uint8_t** addr_sub) {
        ROS_DEBUG("Receive running");

        // Define variables
        bool is_new_msg = false;
        boost::shared_ptr < Base > message_ptr(new Base);
        _last_read_index = -1;
        // Receive msg
        while (ros::ok()) {
            boost::interprocess::scoped_lock<boost::interprocess::interprocess_mutex> lock(
                _shm_sub_mutex);
            is_new_msg = segment_mgr->read_data(*message_ptr, queue_size, 
                _last_read_index, descriptors_sub, addr_sub);
            lock.unlock();

            if (is_new_msg && _user_cb && ros::ok()) {
                ROS_DEBUG("==== Read block %d and excute callback ====", _last_read_index);
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
        receive_msg(segment_mgr, queue_size, descriptors_sub, addr_sub);
    }

    /**
     * \brief cleanup exit subsciber
     *
     * @param index: last read index
     */
    void cleanup_exit_subscriber(int32_t index)
    {
        boost::interprocess::managed_shared_memory* segment = NULL;
        sharedmem_transport::SharedMemorySegment* segment_mgr = NULL;
        sharedmem_transport::SharedMemoryBlock* descriptors_sub = NULL;
        uint32_t queue_size;
        uint8_t** addr_sub = NULL;
        sharedmem_transport::SharedMemoryUtil sharedmem_util;

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

        segment_mgr->cleanup_modified_block(descriptors_sub, index, queue_size);
    }


private:
    const typename message_transport::SimpleSubscriberPlugin < Base,
          sharedmem_transport::SharedMemoryHeader >::Callback* _user_cb;
    int32_t _last_read_index;
    boost::interprocess::interprocess_mutex _shm_sub_mutex;
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_SUBSCRIBER_H
