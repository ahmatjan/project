#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
# 
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
# 
########################################################################

"""
File: monitor.py
Author: mayu01(mayu01@baidu.com)
Date: 2016/02/17 16:21:40
"""
import logging
import os
import subprocess
import json

from kazoo.client import KazooClient
from kazoo.protocol.states import KazooState

import rosmonitor.watchnode as watchnode

_logger = logging.getLogger("rosmonitor.monitor")


class Monitor(object):
    """
        brief info for: Monitor

        Args:
    object :
        Return:   
        Raise: 
    """
    def __init__(self, servers, allnode):
        """
            brief info for: __init__

            Args:
        self :
        servers :
        allnode :
            Return:   
            Raise: 
        """
        self._allnode = (allnode if isinstance(allnode, dict) else {})
        self.client = KazooClient(servers)
        self._restart = False
        self._suspend = False
        self._unpinged = {}
        self.client.add_listener(self._kzclient_listener)
        self.client.start()
        self.watch_node = watchnode.WatchNode(self.client, self._allnode)

    def rosnode_cleanup(self):
        """
            brief info for: rosnode_cleanup

            Args:
        self :
            Return:   
            Raise: 
        """
        popen = subprocess.Popen('rosnode pingall', shell=True, 
                preexec_fn=os.setpgrp, stdout=subprocess.PIPE)
        res = popen.communicate()[0].strip().split('\n')
        if '' in res:
            res.remove('')
        if len(res) >= 1:
            res = res[len(res) - 1]
        else:
            return
        res = json.loads(res)
        pinged = res['pinged']
        unpinged = res['unpinged']
        for node in unpinged:
            if node in self._unpinged:
                self._unpinged[node] += 1
            else:
                self._unpinged[node] = 0
        for node in pinged:
            if node in self._unpinged:
                self._unpinged.pop(node)
        for k, v in self._unpinged.items():
            if k not in pinged and k not in unpinged:
                self._unpinged.pop(k)
                continue
            if v >= 3:
                subprocess.Popen("rosnode clean %s" % k, shell=True, preexec_fn=os.setpgrp)
                self._unpinged.pop(k)

    def _kzclient_listener(self, state):
        """
            brief info for: _kzclient_listener

            Args:
        self :
        state :
            Return:   
            Raise: 
        """
        if state == KazooState.CONNECTED:
            _logger.warning("Get a New Zookeeper Link!")
            self._restart = True
            self._suspend = False
        elif state == KazooState.SUSPENDED:
            self._suspend = True

    def start(self):
        """
            brief info for: start

            Args:
        self :
            Return:   
            Raise: 
        """
        if self._restart:
            self.watch_node.start()
            logging.info("Watch Node Started!")
            self._restart = False
        elif self._suspend:
            _logger.fatal("zookeeper is suspended!")
        else:
            self.watch_node.monitor_nodes()
            self.rosnode_cleanup()

    def stop(self):
        """
            brief info for: stop

            Args:
        self :
            Return:   
            Raise: 
        """
        self.client.remove_listener(self._kzclient_listener)
        self.client.stop()
        self.client.close()
        _logger.info('Monitor is stopped!')
