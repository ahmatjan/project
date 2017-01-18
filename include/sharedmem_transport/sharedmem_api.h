#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_API_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_API_H

#include "ros/forwards.h"
#include "ros/config_comm.h"
#include "sharedmem_transport/sharedmem_util.h"
#include "sharedmem_transport/sharedmem_block.h"
#include "sharedmem_transport/sharedmem_segment.h"

#include <boost/interprocess/ipc/message_queue.hpp>
#include <boost/function.hpp>
#include <boost/thread.hpp>
#include <boost/thread/mutex.hpp>
#include "cstdio"
#include <thread>
#include <iostream>
#include <fstream>
#include <string.h>
#include <stdio.h>

namespace sharedmem_transport {

const int ROS_SHM_API_NAME_SIZE = 1000; // API name temp size
const int ROS_SHM_MESSAGE_QUEUE_SIZE = 100; // API name temp size
const std::string ROS_SHM_MESSAGE_QUEUE_NAME = "shm_message_queue_";
const std::string ROSBAG_SKIP_TOPIC_LIST = "/rosbag_skip_topic.list";
    
typedef boost::function<void (std::string, int, ros::Time)> VoidFunc;
/**
 * \brief Class for Shared Memory API, which is interface to control node.
 *
 */
class SharedMemoryAPI {
public:
    SharedMemoryAPI() : _is_exit(false) {
    }

    ~SharedMemoryAPI();

    typedef void (*shmcallback)(std::string, int, ros::Time);

    void shm_message_ack(VoidFunc& callback, std::vector<std::string> topic_vector);

    /**
     * \brief Allow publish a message
     *
     * @param topic: Which message of topic is allowed
     */
    void allow_publish_one_message(std::string topic);

    /**
     * \brief sharedmemory transport ack
     *
     * @param *shmcallback)(string, int ,ros::Time): user callback
     * @param topic: Which topic is acknowledged
     */
    // void shm_message_ack(void (*shmcallback)(std::string, int, ros::Time), 
    //         std::vector<std::string> topic_vector);
    
    /**
     * \brief sharedmemory rosbag play topics
     *
     * @param topic_vector: rosbag play topics
     */
    void update_rosbag_play_topics(std::vector<std::string> topic_vector);
    
    /**
     * \brief remove message queue
     *
     * @param topic: Which message_queue is removed
     */
    void remove_message_queue(std::string topic);
    
private:
    /**
     * \brief create callback threads
     *
     * @param *shmcallback)(string, int ,ros::Time): user callback
     * @param topic_vector: Which topics are executed
     */
    // void exec_callback_func(void (*shmcallback)(std::string, int, ros::Time), 
    //         std::vector<std::string> topic_vector);

    void exec_callback_func(VoidFunc& callback, std::vector<std::string> topic_vector);

    void callback_thread(VoidFunc& callback, std::string topic);

private:
    boost::mutex _mutex;
    boost::interprocess::managed_shared_memory* _segment = NULL;
    sharedmem_transport::SharedMemorySegment* _segment_mgr = NULL;
    sharedmem_transport::SharedMemoryBlock* _descriptors_sub = NULL;
    uint32_t _queue_size;
    uint8_t** _addr_sub = NULL;
    bool _is_exit;
};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_API_H
