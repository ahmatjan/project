#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_PUBLISHER_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_PUBLISHER_H

#include "message_transport/simple_publisher_plugin.h"
#include "sharedmem_transport/SharedMemoryHeader.h"
#include "sharedmem_transport/sharedmem_publisher_impl.h"

namespace sharedmem_transport {

/**
 * \brief Template class for SharedMemoryPublisher, extends SimplePublisherPlugin
 *
 */
template<class Base>
class SharedMemoryPublisher: public message_transport::SimplePublisherPlugin < Base,
        sharedmem_transport::SharedMemoryHeader > {
public:
    SharedMemoryPublisher() : message_transport::SimplePublisherPlugin<Base, 
        sharedmem_transport::SharedMemoryHeader>(true), // Force latch
        _first_run(true) {
    }

    virtual ~SharedMemoryPublisher() {
    }

    /**
     * \brief Get transport name
     *
     */
    virtual std::string getTransportName() const {
        return ROS_SHM_TRANSPORT_NAME;
    }

protected:
    /**
     * \brief Init advertise node handle
     *
     */
    virtual void postAdvertiseInit() {
        _impl.set_node_handle(this->getNodeHandle());
    }

    /**
     * \brief Publish msg
     *
     */
    virtual void publish(const Base& message,
        const typename message_transport::SimplePublisherPlugin < Base,
        sharedmem_transport::SharedMemoryHeader >::PublishFn& publish_fn) const {
        if (_first_run) {
            ROS_DEBUG("==== First publish run start ====");

            // Define variables
            int32_t index = 0;
            uint64_t msg_size = ros::serialization::serializationLength(message);
            
            // Check if size_ratio is valid
            if (!_impl.check_size_ratio()) {
                ROS_FATAL("==== Size ratio is invalid ====");
                return;
            }

            // Create topic segment
            if (!_impl.create_topic_segement(this->getTopic(), index, this->getQueueSize(), 
                msg_size)) {
                ROS_FATAL("==== Create topic segment failed ====");
                return;
            }
            
            // Register segment to manager
            if (!_impl.register_segment_to_manager(this->getTopic())) {
                ROS_WARN("==== Register segment to manager failed ====");
                return;
            }
            
            // Publishing latched header
            SharedMemoryHeader header;
            header.index = index;
            publish_fn(header);

            // Reset _first_run flag
            _first_run = false;

            ROS_DEBUG("==== First publish run end ====");
        }

        // Publishing SHM message
        _impl.publish_msg(message, this->getQueueSize());
    }

private:
    mutable SharedMemoryPublisherImpl _impl;
    mutable bool _first_run;
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_PUBLISHER_H
