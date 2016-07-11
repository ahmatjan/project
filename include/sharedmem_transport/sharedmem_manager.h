#ifndef SHAREDMEM_TRANSPORT_SHAREDMEM_MANAGER_H
#define SHAREDMEM_TRANSPORT_SHAREDMEM_MANAGER_H

#include <boost/thread.hpp>

#include "sharedmem_transport/SharedMemoryRegisterSegment.h"
#include "sharedmem_transport/sharedmem_util.h"

namespace sharedmem_transport {

typedef std::set<std::string>::iterator iterator;

const uint32_t MANAGER_LOOP_TIME_SEC = 30; // Loop time, sec
const uint32_t MANAGER_EXECUTE_TIMEOUT_SEC = 5; // Execute timeout, sec

const std::string MANAGER_SHELL_ROSTOPIC_LIST = "rostopic list";
const std::string MANAGER_SHM_NAME = "sharedmem_manager";
const std::string MANAGER_SHM_REGISTER_SERVICE = "register_segment";
const std::string MANAGER_SHM_LOCAL_TOPIC_TMP_FILE = "/tmp/local_topic_list";

static jmp_buf s_env_alarm_topic_list;

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
     * \brief Service for register segment
     *
     * Return register result, true or false
     */
    bool register_segment(sharedmem_transport::SharedMemoryRegisterSegment::Request& req,
        sharedmem_transport::SharedMemoryRegisterSegment::Response& res);

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

    /**
     * \brief Recive get_master_topic_list() alarm signal
     *
     */
    static void sig_alarm_master_topic_list(int signo) {
        ROS_WARN("==== Get master_topic_list timeout ====");
        siglongjmp(s_env_alarm_topic_list, 0);
    }

private:
    boost::mutex _main_mutex;
    std::set<std::string> _local_topic_set;
    std::map<std::string, std::string> _master_topic_map;
    std::map<std::string, std::string>::iterator _master_topic_map_it;

};

} // namespace sharedmem_transport

#endif // SHAREDMEM_TRANSPORT_SHAREDMEM_MANAGER_H