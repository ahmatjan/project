# Software License Agreement (BSD License)
#
# Copyright (c) 2008, Willow Garage, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of Willow Garage, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Revision $Id$

"""
ROS Master. 

This module integrates the lower-level implementation modules into a
single interface for running and stopping the ROS Master.
"""

import os
import logging
import time
import threading
import Queue
import simplejson as json
import traceback

from kazoo.exceptions import ConnectionDropped
import rosgraph.xmlrpc
import rosmaster.master_api
import rosmaster.global_data
from rosmaster.global_data import GlobalData
from rosmaster.global_data import GlobalDataThread
from rosmaster.zk.zkleaderclient import ZKLeaderClient
import rosmaster.master_const as master_const



DEFAULT_MASTER_PORT = 11311  # default port for master's to bind to


def byteify(input):
    """ byteify
         input : json.loads
        Return: unicode to string  
        Raise: 
    """
    if isinstance(input, dict):
        return {byteify(key): byteify(value) for key, value in input.iteritems()}
    elif isinstance(input, list):
        return [byteify(element) for element in input]
    elif isinstance(input, unicode):
        return input.encode('utf-8')
    else:
        return input


def object2dict(obj):
    "Convert object to a dict"
    d = {}
    d['__class__'] = obj.__class__.__name__
    d['__module__'] = obj.__module__
    d.update(obj.__dict__)
    return d


def dict2object(d):
    "Convert dict to object"
    if'__class__' in d:
        class_name = d.pop('__class__')
        module_name = d.pop('__module__')
        module = __import__(module_name, {}, {}, [class_name])
        class_ = getattr(module, class_name)
        # get args
        args = dict((key.encode('ascii'), value) for key, value in d.items())
        # create new instance
        inst = class_(**args)

    else:
        inst = d
    return inst


def recursive_dict(d):
    "Recursive dict format"
    # _logger.debug("recursive_dict : %s" % d
    if isinstance(d, dict):
        new_dict = {}
        for key in d.keys():
            if isinstance(d[key], dict):
                if "__class__" in d[key]:
                    new_dict[key] = dict2object(d[key])
                else:
                    new_dict[key] = recursive_dict(d[key])
            elif not isinstance(d[key], (int, float, long, complex, str, tuple, list, dict)):
                new_dict[key] = object2dict(d[key])
            else:
                new_dict[key] = d[key]
        ret = new_dict
    else:
        ret = d
    return ret


def election_callback(client, global_data):
    "election_callback func when rosmaster become the leader"

    _logger = logging.getLogger("leader.callback")
    _logger.setLevel(logging.DEBUG)

    # switch master indicator .
    _logger.debug("I'm become leader with pid : %s" % os.getpid())

    if int(os.environ.get("MULTI_MASTER_SKIP", "0")) != 1:
        if client.exists(master_const.PARAMETERS_PERSIST_ZKPATH):
            data, stat = client.get(
                master_const.PARAMETERS_PERSIST_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get parameters from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_parameters_persist(
                new_dict, master_const.PARAMETERS_PERSIST_SKIP)   
        if client.exists(master_const.PARAMETERS_ZKPATH):
            data, stat = client.get(
                master_const.PARAMETERS_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get parameters from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_parameters(
                new_dict, master_const.PARAMETERS_SKIP)
      
        #for merging persist parameters when parameters.
        global_data.merge_parameters()
                            
        if client.exists(master_const.TOPIC_TYPES_ZKPATH):
            data, stat = client.get(
                master_const.TOPIC_TYPES_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get topics_types from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_topics_types(
                new_dict, master_const.TOPIC_TYPES_SKIP)           
        if client.exists(master_const.NODES_ZKPATH):
            data, stat = client.get(master_const.NODES_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get nodes from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_nodes(new_dict, master_const.NODES_SKIP)           
        if client.exists(master_const.PUBLISHERS_ZKPATH):
            data, stat = client.get(
                master_const.PUBLISHERS_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get publishers from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_publishers_map(
                new_dict, master_const.PUBLISHERS_SKIP)            
        if client.exists(master_const.SUBSCRIBERS_ZKPATH):
            data, stat = client.get(
                master_const.SUBSCRIBERS_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get subscribers from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_subscribers_map(
                new_dict, master_const.SUBSCRIBERS_SKIP)            
        if client.exists(master_const.SERVICES_ZKPATH):
            data, stat = client.get(master_const.SERVICES_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get services from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_services_service_api_map(
                new_dict, master_const.SERVICES_SKIP)           
        if client.exists(master_const.SERVICES_MAP_ZKPATH):
            data, stat = client.get(master_const.SERVICES_MAP_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get services_map from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_services_map(
                new_dict, master_const.SERVICES_MAP_SKIP)           
        if client.exists(master_const.PARAM_SUBSCRIBERS_ZKPATH):
            data, stat = client.get(
                master_const.PARAM_SUBSCRIBERS_ZKPATH)
            value = byteify(json.loads(data))
            _logger.debug(
                "get param_subscribers from zk : %s" % value)
            new_dict = recursive_dict(value)
            global_data.set_param_subscribers_map(
                new_dict, master_const.PARAM_SUBSCRIBERS_SKIP) 

     
def zookeeper_handler(func, zkclient, global_data, master_handler):
    """
    Zookeeper main thread
    zookeeper start seven GlobalDataThread and each GlobalDataThread be responsible for
    put rosmaster internal dict into queue when set/del, regis/unregis event.set().
    zookeeper main thread get queue and then call zkclient to writedown zookeeper zknode.
    """

    zk_queue = Queue.Queue()

    parameters_persist_thread = GlobalDataThread(
        zk_queue,
        master_const.PARAMETERS_PERSIST_ZKPATH,
        GlobalData.parameters_persist_event,
        master_handler, master_const.PARAMETERS_PERSIST_DICT)
    parameters_thread = GlobalDataThread(
        zk_queue,
        master_const.PARAMETERS_ZKPATH,
        GlobalData.parameters_event,
        master_handler, master_const.PARAMETERS_DICT)
    topics_types_thread = GlobalDataThread(
        zk_queue,
        master_const.TOPIC_TYPES_ZKPATH,
        GlobalData.topics_types_event,
        master_handler, master_const.TOPIC_TYPES_DICT)
    nodes_thread = GlobalDataThread(
        zk_queue,
        master_const.NODES_ZKPATH,
        GlobalData.nodes_event,
        master_handler, master_const.NODES_DICT)
    publishers_map_thread = GlobalDataThread(
        zk_queue,
        master_const.PUBLISHERS_ZKPATH,
        GlobalData.publishers_map_event,
        master_handler, master_const.PUBLISHERS_DICT)
    subscribers_map_thread = GlobalDataThread(
        zk_queue,
        master_const.SUBSCRIBERS_ZKPATH,
        GlobalData.subscribers_map_event,
        master_handler, master_const.SUBSCRIBERS_DICT)
    services_service_api_map_thread = GlobalDataThread(
        zk_queue,
        master_const.SERVICES_ZKPATH,
        GlobalData.services_service_api_map_event,
        master_handler, master_const.SERVICES_DICT)
    services_map_thread = GlobalDataThread(
        zk_queue,
        master_const.SERVICES_MAP_ZKPATH,
        GlobalData.services_map_event,
        master_handler, master_const.SERVICES_MAP_DICT)
    param_subscribers_map_thread = GlobalDataThread(
        zk_queue,
        master_const.PARAM_SUBSCRIBERS_ZKPATH,
        GlobalData.param_subscribers_map_event,
        master_handler, master_const.PARAM_SUBSCRIBERS_DICT)

    parameters_persist_thread.start()
    parameters_thread.start()
    topics_types_thread.start()
    nodes_thread.start()
    publishers_map_thread.start()
    subscribers_map_thread.start()
    services_service_api_map_thread.start()
    services_map_thread.start()
    param_subscribers_map_thread.start()

    while func():
        zk_dict = zk_queue.get()
        if zkclient.hasLeadership():
            zkclient.setData(
                zk_dict.keys()[0], recursive_dict(zk_dict.values()[0]))
        zk_queue.task_done()


class Master(object):

    """
    Master class .

    Attributes:
        self.port: 
        self.num_workers: 

    Method:
        __init__
        start 
        ok
        stop

    """

    def __init__(self, port=None, num_workers=None):
        if port is None:
            self.port = DEFAULT_MASTER_PORT
        else:
            self.port = port

        if num_workers is None:
            self.num_workers = rosmaster.master_api.NUM_WORKERS
        else:
            self.num_workers = num_workers

    def start(self):
        """
        Start the ROS Master.
        """
        self.handler = None
        self.master_node = None
        self.uri = None
        self.zkclient = None

        handler = rosmaster.master_api.ROSMasterHandler(self.num_workers)
        self.global_data = GlobalData(handler)
        master_node = rosgraph.xmlrpc.XmlRpcNode(self.port, handler)
        master_node.start()

        # poll for initialization
        while not master_node.uri:
            time.sleep(0.0001)

        # save fields
        self.handler = handler
        self.master_node = master_node
        self.uri = master_node.uri

        logging.getLogger('rosmaster.master').info(
            "Master initialized: port[%s], uri[%s]", self.port, self.uri)

        if "ZK_HOST" not in os.environ:
            logging.getLogger(__name__).error(
                "ZK_HOST not set .")
            return
#raise Exception("ZK_HOST not set .")
        elif os.environ["ZK_HOST"].strip() == "":
            logging.getLogger(__name__).error(
                "ZK_HOST is null.")
            return 
#raise Exception("ZK_HOST is null.")
        else:
            zk_host = os.environ["ZK_HOST"]

        self.zkclient = ZKLeaderClient(zk_host, os.getpid(), self.uri)
        self.zkclient.electLeader(election_callback, self.zkclient.client, self.global_data)

        logging.getLogger('rosmaster.zookeeper_handler').info(
            "start zookeeper handler")
        zk_thread = threading.Thread(
            target=zookeeper_handler, 
            args=(self.ok, self.zkclient, self.global_data, handler))
        zk_thread.setDaemon(True)
        zk_thread.start()

    def ok(self):
        """
        Status of the ROS Master.
        """
        if self.master_node is not None:
            if self.zkclient is None:
                return self.master_node.handler._ok()
            elif self.zkclient.go_away == False:
                return self.master_node.handler._ok()
        else:
            return False

    def stop(self):
        """
        Stop the ROS Master.
        """
        if self.master_node is not None:
            self.master_node.shutdown('Master.stop')
            self.master_node = None
