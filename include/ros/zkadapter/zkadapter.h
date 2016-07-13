/**
 * ZooKeeper C++ Wrapper.
 *
 * To provide for varying underlying implementations.
*/

#ifndef ROS_ZK_ADAPTER_H
#define ROS_ZK_ADAPTER_H

#include <iostream>
#include <string>
#include <mutex>
#include <condition_variable>

#include "zookeeper/zookeeper.h"

namespace zkadapter {

class ZooKeeperException :
public std::exception {
public:

    ZooKeeperException(const std::string& msg) :
        m_message(msg), m_zkErrorCode(0) {
    }

    ZooKeeperException(const std::string& msg, int errorCode) :
        m_zkErrorCode(errorCode) {
        char tmp[100];
        sprintf(tmp, " (ZK error code: %d)", errorCode);
        m_message = msg + tmp;
    }

    ~ZooKeeperException() throw() {}

    const char* what() const throw() {
        return m_message.c_str();
    }

    int get_zk_error_code() const {
        return m_zkErrorCode;
    }

private:

    std::string m_message;

    int m_zkErrorCode;
};

class ZKAdapter {

public:
    const static int Max_Znode_Buf_Len = 256;
    ZKAdapter() {
        m_zhandle = NULL;
        _ZOO_ALL_ACL[0].perms = 31;
        _ZOO_ALL_ACL[0].id.scheme = (char*)"world";
        _ZOO_ALL_ACL[0].id.id = (char*)"anyone";
        ZOO_ALL_ACL.count = 1;
        ZOO_ALL_ACL.data = &_ZOO_ALL_ACL[0];
        zoo_set_debug_level(ZOO_LOG_LEVEL_ERROR);
    }

    ~ZKAdapter() {
    }

    friend void zk_watcher(zhandle_t* zh, int type, int state, const char* path, void* watcherCtx);
    int init(const std::string& host, int timeout, bool autoReconnect = true) throw(ZooKeeperException);

    int get_node_data(const std::string& path, std::string& data);
    int wget_node_data(const std::string& path, watcher_fn watcher, std::string& out);
    int get_node_stat(const std::string& path, struct Stat& nodeStat);

    int set_node_data(const std::string& path, const std::string& data) throw(ZooKeeperException);
    int set_node_data(const std::string& path, int data);

    int exists(const std::string& path);
    int wexists(const std::string& path, watcher_fn watcher, void* watcherCtx);

    int get_node_child(const std::string& path, String_vector* sv);
    int wget_node_child(const std::string& path, watcher_fn watcher, void* watcherCtx);

    void session_event(int type, int state, const char* path);

    /**
     *
     * \brief create a node synchronously.
     *
     * This method will create a node in ZooKeeper.The Create Flags affect
     * the creation of nodes.  If ZOO_EPHEMERAL flag is set, the node
     * will automatically get removed if the client session goes
     * away. If the ZOO_SEQUENCE flag is set, a unique monotonically
     * increasing sequence number is appended to the path name.
     * \return one of following codes are returned:
     * 0 create successfully
     * -1 create failed
     */
    int create_node(const std::string& path);
    int create_node(const std::string& path, const std::string& nodeData);
    int create_eph_node(const std::string& path);
    int create_eph_node(const std::string& path, const std::string& nodeData);
    int create_seq_node(const std::string& path, const std::string& nodeData, std::string& seq_path);

    int delete_node(const std::string& path);

    std::string get_zk_server() {
        return m_zkServer;
    }

    zhandle_t* get_zhandle() {
        return m_zhandle;
    }

    int close() {
        int ret =  zookeeper_close(m_zhandle);
        return ret;
    }

    enum ZK_STATE {
        //state set to S_DISCONNECTED call zookeeper_close() is called.
        S_DISCONNECTED = 0,
        //state set to S_CONNECTING when the client is reconnecting.
        S_CONNECTING,
        //state set to S_CONNECTED when the client is connected to a zookeeper server.
        S_CONNECTED,
        //state set to S_SEESEION_EXPIRED when the client lost the connect to zookeeper cluster.
        S_SESSION_EXPIRED
    };

private:
    int m_zkTimeout;
    bool m_connected;
    bool m_autoReconnect;
    char outbuf[Max_Znode_Buf_Len];
    struct ACL _ZOO_ALL_ACL[1]; /* {31,{"world","anyone"}} */
    struct ACL_vector ZOO_ALL_ACL; /* {1,_ZOO_ALL_ACL}; */
    std::string m_zkServer; /*zkIP:PORT */
    zhandle_t* m_zhandle;

    std::mutex m_stateLock;
    std::condition_variable m_stateCond;

    void set_state(ZK_STATE state);
    void check_connection() throw(ZooKeeperException);
    void wait_for_connected();
    void validate_path(const std::string& path) throw(ZooKeeperException);
    void validate_parent(const std::string& path) throw(ZooKeeperException);

    ZK_STATE m_state;

    ZK_STATE get_state() const {
        return m_state;
    };
};
}
#endif
