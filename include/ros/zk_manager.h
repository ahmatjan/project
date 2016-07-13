#ifndef ROSCPP_ZK_MANAGER_H
#define ROSCPP_ZK_MANAGER_H

#include <condition_variable>
#include <functional>
#include <future>
#include <queue>
#include <memory>
#include <mutex>
#include <stdexcept>
#include <string>
#include <set>
#include <thread>
#include <vector>

#include <ros/time.h>

#include "common.h"
#include "ros/zkadapter/zkadapter.h"

namespace ros {
class ZKManager;
typedef std::shared_ptr<ZKManager> ZKManagerPtr;

class ROSCPP_DECL ZKManager {

public:
    static const ZKManagerPtr& instance();
    const static std::string heartbeat_path;
    const static std::string data_path;
    const static std::string master_path;

    friend void watch_heartbeat(zhandle_t* zh, int type, int state, const char* path, void* watcherCtx);

    ZKManager();
    ~ZKManager();

    void start();
    void shutdown();
    void set_data(std::string key, std::string value);
    auto get_data(std::string key) -> std::future<std::string>;
    void update_master();

private:
    std::string zk_hosts_;
    int timeout;
    int port_;

    bool shutting_down_;

    ros::WallDuration master_retry_timeout_;
    zkadapter::ZKAdapter* zk_;

    std::thread server_thread_;
    std::queue< std::function<void()> > tasks;

    // synchronization
    std::mutex queue_mutex;
    std::condition_variable condition;

    void thread_func();
    void connect_zk();
    void create_heartbeat();
    void update_uri(std::string uri);
    template<class F, class... Args>
    auto add_task(F&& f, Args&&... args) -> std::future<typename std::result_of<F(Args...)>::type>;

    bool isShuttingDown() {
        return shutting_down_;
    }
};

} // namespace ros

#endif

