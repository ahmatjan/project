#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
#
########################################################################

"""
File: zkleaderclient.py
Author: zhangweide(zhangweide@baidu.com)
Date: 2016/02/12 23:29:21
"""
import sys
import os
import threading
import logging
import traceback
import warnings
import simplejson as json
import time
from kazoo.protocol.states import KazooState
from kazoo.exceptions import LockTimeout
from kazoo.exceptions import CancelledError
from kazoo.exceptions import ConnectionLoss
from kazoo.exceptions import ConnectionDropped
from kazoo.exceptions import OperationTimeoutError
from kazoo.exceptions import SessionExpiredError
from kazoo.exceptions import ConnectionClosedError
from kazoo.exceptions import KazooException
from kazoo.client import KazooClient
from rosmaster.threadpool import MarkedThreadPool
from functools import partial
import rosmaster.master_const as master_const

_logger = logging.getLogger("rosmaster.zkleaderclient")


class ZKLeaderClient(object):

    """ ZKLeaderClient for manage leader election

        Attributes:
            servers: zk server string in (host:port,host:port...) 
            identifier: current id of the master node 
            url: master url
    """

    def __init__(self, servers, identifier, url=''):
        self.identifier = identifier
        self.masterurl = url
        self.basepath = master_const.MASTER_ZKPATH
        self.electionpath = self.basepath + master_const.ELECTION_ZKPATH
        _logger.info('zk servers %s' % servers)
        self.client = KazooClient(servers, timeout=master_const.KAZOO_TIMEOUT)
        self.lock = self.client.Lock(self.electionpath, identifier)
        self.event = threading.Event()
        self.thread_pool = MarkedThreadPool(1)
        self.client.add_listener(self._watch_session)
        self.go_away = False
        self.has_leadership = False
        self.client.start()
        self.client.ensure_path(self.electionpath)
        _logger.info('successfully initialized zkleader client')
        _logger.setLevel(logging.DEBUG)

    def electLeader(self, func=None, arg1=None, arg2=None):
        """ electLeader call

            Args:
                func : callback if elected as leader
            Return:  None 
            Raise: Exception  
        """
        try:
            self.thread_pool.queue_task(
                None, self._electLeader, (func, arg1, arg2, ))
        except Exception:
            _logger.error(traceback.format_exc())

    def _electLeader(self, func, arg1, arg2):
        while not self.go_away:
            try:
                self.event.wait()
                _logger.debug("_electLeader self.event.get") 
                if self.lock.acquire():
                    _logger.debug("_electLeader self.event.clear")  
                    _logger.info('begin to elect leader')
                    _logger.info("successfully obtain leadership %s " %
                                 self.identifier)
                    self.event.clear()    
                    self.has_leadership = True
                    if func is not None:
                        func(arg1, arg2)
                    self.setLeader()
            except CancelledError as e:
                _logger.error("kazoo lock canceled exception because kazoo suspended")
            except Exception as e:
                _logger.error("kazoo electLeader exception exit : %s" % e)
                _logger.error(traceback.format_exc())
                self.go_away = True
                self.close()
   
    def setLeader(self):
        """ set leader info for connected master info

            Args:
            Return: None  
            Raise: 
        """
        nodevalue = self._encode_value()
        self.client.set(self.electionpath, nodevalue) 
        _logger.debug("update master url : %s " % nodevalue)

    def _encode_value(self):
        return self.masterurl.encode('utf-8')

    def _watch_session(self, state):
        _logger.debug("state is %s" % state)
        if state == KazooState.LOST:
            _logger.debug("kazoo state lost")
            self.lock.cancel()
        elif state == KazooState.SUSPENDED:
            _logger.debug("kazoo state suspended")
            self.lock.cancel()
        elif state == KazooState.CONNECTED:
            _logger.debug("kazoo state connected")            
            self.event.set()
      
    def close(self):
        """ close the zk connection

            Args:
            Return:   
            Raise: 
        """
        if self.thread_pool is not None:
            self.thread_pool.join_all(
                wait_for_tasks=False, wait_for_threads=False)
            self.thread_pool = None
        _logger.debug("kazoo close")
        self.client.remove_listener(self._watch_session)
        self.client.stop()
        self.client.close()

    def hasLeadership(self):
        """ fetches leadership flag

            Args:
            Return: bool  
            Raise: None
        """
        return self.has_leadership

    def getBasePath(self):
        """
            brief info for: getBasePath

            Args:
            Return: string   
            Raise: 
        """
        return self.basepath

    def getElectionPath(self):
        """ getElectionPath

            Args:
        self :
            Return: string  
            Raise: 
        """
        return self.electionpath

    def getMasterUrl(self):
        """ getMasterUrl

            Args:
        self :
            Return: string  
            Raise: 
        """
        return self.masterurl

    def getIdentifier(self):
        """ getIdentifier

            Args:
        self :
            Return: string  
            Raise: 
        """
        return self.identifier

    def setData(self, path, data):
        """ setData

            Args:
        self :
            Return:   
            Raise: 
        """

        count = 0

        value = json.dumps(data)

        _logger.debug("set zknode path  %s  with value: %s" % (path, value))

        while True:
            try:
                if not self.client.exists(path):
                    self.client.ensure_path(path)
                self.client.set(path, value)
                break
            except ConnectionLoss as e:
                _logger.error("ConnectionLoss!")
                _logger.error(traceback.format_exc())
                count = count + 1
                time.sleep(0.1)
                if count < master_const.ZOO_RETRY_TIMES:
                    continue
                else:
                    self.go_away = True
                    self.close()
                    break                             
            except ConnectionDropped as e:
                _logger.error("ConnectionDropped!")
                _logger.error(traceback.format_exc())
                count = count + 1
                time.sleep(0.1)
                if count < master_const.ZOO_RETRY_TIMES:
                    continue
                else:
                    self.go_away = True
                    self.close()
                    break  
            except OperationTimeoutError as e:
                _logger.error("OperationTimeoutError!")
                _logger.error(traceback.format_exc())
                count = count + 1
                time.sleep(0.1)
                if count < master_const.ZOO_RETRY_TIMES:
                    continue
                else:
                    self.go_away = True
                    self.close()
                    break  
            except SessionExpiredError as e:
                _logger.error("SessionExpiredError!")
                _logger.error(traceback.format_exc())
                count = count + 1
                time.sleep(0.1)
                if count < master_const.ZOO_RETRY_TIMES:
                    continue
                else:
                    self.go_away = True
                    self.close()
                    break     
            except ConnectionClosedError as e:
                _logger.error("ConnectionClosedError!")
                _logger.error(traceback.format_exc())
                count = count + 1
                time.sleep(0.1)
                if count < master_const.ZOO_RETRY_TIMES:
                    continue
                else:
                    self.go_away = True
                    self.close()
                    break               
            except Exception as e:
                _logger.error("kazoo setData exception exit.")
                _logger.error(traceback.format_exc())
                self.go_away = True
                self.close()
                break    
         