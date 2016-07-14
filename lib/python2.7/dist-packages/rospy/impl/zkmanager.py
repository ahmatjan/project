# -*- coding:utf-8 -*-
########################################################################
# 
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
# 
########################################################################

"""
File: zkmanager.py
Author: hewei03(hewei03@baidu.com)
Date: 2016/02/22 13:45:05
"""

import time
import logging
import signal

from kazoo import exceptions
from kazoo.client import KazooClient
from kazoo.client import KazooState

from threading import Event
from threading import Thread

from ..names import get_name

_logger = logging.getLogger("rospy.impl.zkmanager")
_logger.setLevel(logging.DEBUG)  
logging.basicConfig()

"""
# Output to stderr for debug
import sys
ch = logging.StreamHandler(sys.stderr)
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
_logger.addHandler(ch)
"""

def init_zkmanager(hosts, timeout, handler):
    """
        Initialize the zkmanager and start new thread.
        @param hosts: Comma-separated list of hosts to connect to. (e.g. 127.0.0.1:2180,127.0.0.1:2181)
               timeout: The longest to wait for a Zookeeper connection.
               handler: 
        @type  hosts: str
               timeout: float
               handler: ROSHandler
        @return: None
    """
    zm = ZKManager(handler, hosts, timeout)
    zm.run()


class ZKManager(object):
    """ Provide methods for communicating with zookeeper cluster.
    """
     

    def __init__(self, handler, hosts="127.0.0.1:2181", timeout=1.0):
        #signal.signal(signal.SIGINT, self.close)
        self.handler = handler
        self.reconnected = Event()
        self.monitor_path = "/monitor"
        self.path = self.monitor_path + get_name()
        self.master_uri_path = "/master/election"
        self.zk = KazooClient(hosts, timeout)

        import sys
        _logger.info(sys.path)

    def reconnected_callback(self):
        #Create a ephemeral node in /monitor
        self.register_node()

        #Init master uri and set the watcher function.
        self.update_master_uri()

        #Reset the internal flag.Calling wait() will block until next set() is called.
        self.reconnected.clear()

    def run(self):
        th = Thread(target=self.thread_func)
        th.setDaemon(True)
        th.start()

    def thread_func(self):
        self.zk.add_listener(self.zk_listener)
        try:
            self.zk.start()
        except:
            _logger.error('Connecting to zookeeper Failed!')

        while True:
            if self.reconnected.wait(1):
                self.reconnected_callback()
            time.sleep(0.2)

    def __del__(self):
        try:
            self.zk.stop()
            self.zk.close()
        except:
            pass


    def zk_listener(self, state):
        if state == KazooState.LOST:
            _logger.debug("Connection is lost")
         # Register somewhere that the session was lost
        elif state == KazooState.SUSPENDED:
        # Handle being disconnected from Zookeeper
            _logger.debug("Connection is suspended")
        else:
            #SequentialGeventHandler.spawn(self.reconnected_callback)
            self.reconnected.set()
            _logger.debug("Reconnected")
        # Handle being connected/reconnected to Zookeeper

    def register_node(self):
        try:
            path = self.zk.create(self.path, ephemeral=True, makepath=True)
        except exceptions.NodeExistsError:
            _logger.debug("Node is exist[%s]" % self.path)
        except exceptions.NoNodeError:
            _logger.debug("Parent node /monitor is missing")
        except exceptions.ZookeeperError as e:
            _logger.debug("Create monitor node[%s] failed! Ret=%s" % (path, e))
        finally:
            self.zk.get(self.path, watch = self.heartbeat_change_callback)

    def heartbeat_change_callback(self, event):
        try:
            self.register_node()
        except exceptions.NoNodeError:
            _logger.debug("Register to heartbeat path %s" % event.path)
        except exceptions.ZookeeperError as e:
            _logger.debug("Get node[%s] failed! Ret=%s" % (event.path, e))

    def master_change_callback(self, event):
        try:
            data, _stat = self.zk.get(event.path, watch = self.master_change_callback)
            _logger.debug("Master_uri changed into %s" % data)
            self.handler.setMasterUri(data)
        except exceptions.NoNodeError:
            _logger.debug("Master_uri node /master/election is missing")
        except exceptions.ZookeeperError as e:
            _logger.debug("Get master_uri node[%s] failed! Ret=%s" % (event.path, e))
           
    def update_master_uri(self):
        try:
            data, _stat = self.zk.get(self.master_uri_path, watch = self.master_change_callback)
            #Trigger the watch after set the watcher
            _logger.info("update_master_uri %s" % data)
            self.handler.setMasterUri(data)
        except exceptions.NoNodeError:
            _logger.debug("Master_uri node /master/election is missing")
        except exceptions.ZookeeperError:
            _logger.debug("Get master_uri node[%s] failed! Ret=%s" % (event.path, e))


def test():
    init_zkmanager("172.20.70.11:2180,172.20.70.11:2181", 1.0)

if __name__ == "__main__":
    test()

