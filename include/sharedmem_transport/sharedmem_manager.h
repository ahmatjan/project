#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_MANAGER_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_MANAGER_H

#include <boost/thread.hpp>

#include "sharedmem_transport/sharedmem_util.h"
#include "sharedmem_transport/sharedmem_api.h"

namespace sharedmem_transport {

typedef std::set<std::string>::iterator iterator;

const uint32_t MANAGER_LOOP_TIME_SEC = 2; // Loop time, sec
const uint32_t MANAGER_EXECUTE_TIMEOUT_SEC = 2; // Execute timeout, sec

const std::string MANAGER_SHELL_ROSTOPIC_LIST = "rostopic list";
const std::string MANAGER_SHM_NAME = "sharedmem_manager";
const std::string MANAGER_SHM_REGISTER_SERVICE = "register_segment";
const std::string MANAGER_SHM_LOCAL_TOPIC_TMP_FILE = "/tmp/local_topic_list";

class SharedMemoryManager {
public:
    SharedMemoryManager() {
    }

    virtual ~SharedMemoryManager() {
    }

    /**
     * \brief Destroy dead topic segment and reset block status regularly
     *
     */
    void check_segment_and_timeout_loop();

    /**
     * \brief Remove expired topic segment memory
     *
     * Return remove result, true or false
     */
    bool remove_topic_segment(const char* topic_name);

    /**
     * \brief Compare block waiting time
     *
     */
    void compare_block_waiting_time(const char* topic_name);

private:
    /**
     * \brief Destroy dead topic segment
     *
     */
    void check_segment();

    /**
     * \brief Check blocks timeout
     *
     */
    void check_timeout();

    /**
     * \brief TODO: Get local topic list
     *
     * Read topic list from txt and save topic list to txt is a temporary method. It
     * will be replaced with the node state store/restore mechanism later, the mechanism
     * is being developed by multi_master team.
     *
     * Return get result, true or false
     */
    bool get_local_topic_list();

    /**
     * \brief Get master topic list through executing command
     *
     * Return get result, true or false
     */
    bool get_master_topic_list();

    /**
     * \brief TODO: Save local topic list
     *
     * Read topic list from txt and save topic list to txt is a temporary method. It
     * will be replaced with the node state store/restore mechanism later, the mechanism
     * is being developed by multi_master team.
     *
     * Return save result, true or false
     */
    bool save_local_topic_list();

    /**
     * \brief Check whether topic name is in set
     *
     * Return topic existed status, true or false
     */
    bool exist_topic(std::string topic_name);

    /**
     * \brief Remove expired topic segment memory
     *
     * Return remove result, true or false
     */
    bool remove_topic_segment(std::string topic_name);

    /**
     * \brief Compare block waiting time
     *
     */
    void compare_block_waiting_time(std::string topic_name);

private:
    boost::mutex _main_mutex;
    std::set<std::string> _local_topic_set;
    std::map<std::string, std::string> _master_topic_map;
    std::map<std::string, std::string>::iterator _master_topic_map_it;
};

extern "C"
bool remove_segment(const char* topic_name) {
    sharedmem_transport::SharedMemoryManager shm_manager;
    return shm_manager.remove_topic_segment(topic_name);
}

extern "C"
bool compare_block(const char* topic_name) {
    sharedmem_transport::SharedMemoryManager shm_manager;
    shm_manager.compare_block_waiting_time(topic_name);
    return true;
}


} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_MANAGER_H