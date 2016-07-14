#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
#
########################################################################

"""
File: global_data.py
Author: wanghaifeng03(wanghaifeng03@baidu.com)
Date: 2016/02/15 16:53:23
"""

import logging
import traceback
import threading
import functools
import copy
import rosmaster.master_const as master_const


def deco_dict(event_list=None):
    """
    deco_dict decorate master_api function which is change rosmaster internal dict,
    and then set event_list.
    Args:
        event :
    Return:
    Raise:
    """
    def _deco_dict(func):
        @functools.wraps(func)
        def __deco_dict(*args, **kwargs):
            _logger = logging.getLogger(__name__)
            _logger.setLevel(logging.DEBUG)
            try:
                ret = func(*args, **kwargs)
                if event_list is not None:
                    for event in event_list:
                        event.set()
                        _logger.debug("release deco_dict event %s " % event)
                return ret
            except MyException as e:
                _logger.error("deco_dict exception is %s" % e)
                _logger.error(
                    "deco_dict func is %s, *args is %s, **kwargs is %s." %
                    (e.func, str(e.args), str(e.kwargs)))
                _logger.error(traceback.format_exc())
        return __deco_dict
    return _deco_dict


class MyException(Exception):

    """
    MyException class provide customer exception.
    Catch the Exception when deco_dict decorate func
    Attributes:
    """

    def __init__(self, func, *args, **kwargs):
        super(Exception, self).__init__()
        self.func = func
        self.args = args
        self.kwargs = kwargs
        # pass


class GlobalData(object):

    """
    GlobalData class.
    GlobalData class provide thread.event for sync rosmaster internal dict change.
    GlobalData class provide many set methods for update rosmaster internal dict when become leader
    and use master_handler internal ps lock for sync.
    Class Attributes:
        parameters_event: thread event for sync rosmaster parameters dict 
        topics_types_event: thread event for sync rosmaster topics_types dict 
        nodes_event: thread event for sync rosmaster nodes dict 
        publishers_map_event: thread event for sync rosmaster publishers dict 
        subscribers_map_event: thread event for sync rosmaster subscribers dict 
        services_service_api_map_event: thread event for sync rosmaster services dict 
        param_subscribers_map_event: thread event for sync rosmaster param_subscribers dict 
    Attributes:
        self._master_handler : master_handler
        self.parameters: parameters dict 
        self.topics_types : topics_types dict
        self.nodes: nodes dict
        self.publishers_map: publishers dict
        self.subscribers_map: subscribers dict
        self.services_service_api_map: services dict
        self.param_subscribers_map: param_subscribers dict
        self._logger: log file indicator
    """
    parameters_persist_event = threading.Event()    
    parameters_event = threading.Event()
    topics_types_event = threading.Event()
    nodes_event = threading.Event()
    publishers_map_event = threading.Event()
    subscribers_map_event = threading.Event()
    services_service_api_map_event = threading.Event()
    services_map_event = threading.Event()
    param_subscribers_map_event = threading.Event()

    def __init__(self, master_handler):
        """
        __init__ method
        Args:
        Return:
        Raise:
        """
        self._master_handler = master_handler
        self.parameters = {}
        self.topics_types = {}
        self.nodes = {}
        self.publishers_map = {}
        self.subscribers_map = {}
        self.services_service_api_map = {}
        self.services_map = {}        
        self.param_subscribers_map = {}
        self._logger = logging.getLogger(__name__)
        self._logger.setLevel(logging.DEBUG)

    def merge_parameters(self):
        """
        brief info for: merge_parameters
        merge_parameters method will merge parameters and parameters_persist dict
        Args:
            self :
        Return:
        Raise:
        """

        try:
            self._master_handler.ps_lock.acquire()
            self._master_handler.param_server.parameters.update(
                self._master_handler.param_server.parameters_persist)
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_parameters_persist(self, value, skip_key=None):
        """
        brief info for: set_parameters_persist
        set_parameters_persist method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """

        try:
            self.parameters_persist = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.parameters_persist.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.param_server.parameters_persist[k] = v
                    self._logger.debug("set parameters_persist[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_parameters(self, value, skip_key=None):
        """
        brief info for: set_parameters
        set_parameters method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """

        try:
            self.parameters = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.parameters.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.param_server.parameters[k] = v
                    self._logger.debug("set parameters[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_topics_types(self, value, skip_key=None):
        """
        brief info for: set_topics_types
        set_topics_types method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """
        try:
            self.topics_types = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.topics_types.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.topics_types[k] = v
                    self._logger.debug("set topics_types[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_nodes(self, value, skip_key=None):
        """
        brief info for: set_nodes
        set_nodes method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """
        try:
            self.nodes = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.nodes.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.reg_manager.nodes[k] = v
                    self._logger.debug("set nodes[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_publishers_map(self, value, skip_key=None):
        """
        brief info for: set_publishers_map
        set_publishers_map method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """

        try:
            self.publishers_map = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.publishers_map.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.publishers.map[k] = v
                    self._logger.debug(
                        "set publishers_map[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_subscribers_map(self, value, skip_key=None):
        """
        brief info for: set_subscribers_map
        set_subscribers_map method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """
        try:
            self.subscribers_map = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.subscribers_map.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.subscribers.map[k] = v
                    self._logger.debug(
                        "set subscribers_map[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_services_service_api_map(self, value, skip_key=None):
        """
        brief info for: set_services_service_api_map
        set_services_service_api_map method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """

        try:
            self.services_service_api_map = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.services_service_api_map.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    if self._master_handler.services.service_api_map  is None:
                        self._master_handler.services.service_api_map = {}
                        
                    self._master_handler.services.service_api_map[k] = v   
                    self._logger.debug(
                        "set services_service_api_map[%s] : %s" % (k, v))                    

        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_services_map(self, value, skip_key=None):
        """
        brief info for: set_services_map
        set_services_map method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """

        try:
            self.services_map = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.services_map.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.services.map[k] = v   
                    self._logger.debug(
                        "set services_map[%s] : %s" % (k, v))                    

        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()

    def set_param_subscribers_map(self, value, skip_key=None):
        """
        brief info for: set_param_subscribers_map
        set_param_subscribers_map method will deepcopy input dict and insert rosmaster internal dict
        but ignore skip_key . User master_handler.ps_lock for sync
        Args:
            self :
            value : input dict
            skip_key : skip_key of input dict
        Return:
        Raise:
        """
        try:
            self.param_subscribers_map = copy.deepcopy(value)
            self._master_handler.ps_lock.acquire()
            for k, v in self.param_subscribers_map.items():
                if skip_key is not None and k in skip_key:
                    continue
                else:
                    self._master_handler.param_subscribers.map[k] = v
                    self._logger.debug(
                        "set param_subscribers_map[%s] : %s" % (k, v))
        except Exception as e:
            self._logger.error(traceback.format_exc())
        finally:
            self._master_handler.ps_lock.release()


class GlobalDataThread(threading.Thread):

    """
    GlobalDataThread Class.

    Attributes:
        _logger: a logger object indicator log
        _zknode_name: zknode path name
        _queue: queue for "{zkpath : rosmater internal dict}"
        _event: event sync for rosmaster internal dict change
        dict_type: rosmaster dict type
        _master_handler: rosmaster _master_handler object

    Methods:
        run(): thread run method
    """

    def __init__(self, global_queue, zknode_name,
                 global_event, master_handler, dict_type):
        """
        brief info for: __init__

        Args:
            self._logger : a logger object indicator log
            self._zknode_name : zknode path name
            self._queue : queue for "{zkpath : rosmater internal dict}"
            self._event : event sync for rosmaster internal dict change
            self.dict_type: rosmaster dict type
            self._master_handler : rosmaster _master_handler object
        Return:
        Raise:
        """

        super(GlobalDataThread, self).__init__()
        self.setDaemon(True)
        self._logger = logging.getLogger(__name__)
        self._zknode_name = zknode_name
        self._queue = global_queue
        self._event = global_event

        self.dict_type = dict_type
        self._master_handler = master_handler

    def run(self):
        """
        brief info for: thread run method
        Thread will wait event set and then deepcopy rosmaster internal dict according to dict_type.
        and then put  "{zkpath : rosmater internal dict}" into Queue
        Args:
            self :
        Return:
        Raise:
        """

        self._logger.info(
            "starting global_data_thread[%s]" % self._zknode_name)
        while True:
            try:
                self._event.wait()
                self._master_handler.ps_lock.acquire()
                self._dict = copy.deepcopy(self._get_master_dict())
                self._queue.put({self._zknode_name: self._dict})
                self._event.clear()
            except Exception as e:
                self._logger.error(
                    "thread[%s] error is  %s" %
                    (self._zknode_name, e))
                self._logger.error(traceback.format_exc())
            finally:
                self._master_handler.ps_lock.release()

    def _get_master_dict(self):
        """
        brief info for: Get _master_handler internal dict stuct according to dict_type
        Args:
            self :
        Return: _master_handler internal dict
        Raise:
        """
        if self.dict_type == master_const.PARAMETERS_DICT:
            return self._master_handler.param_server.parameters
        elif self.dict_type == master_const.TOPIC_TYPES_DICT:
            return self._master_handler.topics_types
        elif self.dict_type == master_const.NODES_DICT:
            return self._master_handler.reg_manager.nodes
        elif self.dict_type == master_const.PUBLISHERS_DICT:
            return self._master_handler.publishers.map
        elif self.dict_type == master_const.SUBSCRIBERS_DICT:
            return self._master_handler.subscribers.map
        elif self.dict_type == master_const.SERVICES_DICT:
            return self._master_handler.services.service_api_map
        elif self.dict_type == master_const.SERVICES_MAP_DICT:
            return self._master_handler.services.map
        elif self.dict_type == master_const.PARAM_SUBSCRIBERS_DICT:
            return self._master_handler.param_subscribers.map
        elif self.dict_type == master_const.PARAMETERS_PERSIST_DICT:
            return self._master_handler.param_server.parameters_persist
        else:
            return None
