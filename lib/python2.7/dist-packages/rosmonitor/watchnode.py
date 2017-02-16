#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
# 
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
# 
########################################################################

"""
File: watch_node.py
Author: mayu01(mayu01@baidu.com)
Date: 2016/02/17 16:21:47
"""
import subprocess
import logging
import threading
import os

_logger = logging.getLogger("rosmonitor.watchnode")


class WatchNode(object):
    """
        brief info for: WatchNode

        Args:
    object :
        Return:   
        Raise: 
    """
    def __init__(self, kzclient, allnode):
        """
            brief info for: __init__
                _restartnode = {'nodename': times}
                _restarttimes = {'nodename' : times}
            Args:
        self :
        kzclient :
        allnode :
            Return:   
            Raise: 
        """
        self._allnode = allnode
        self._allnodenames = (self._allnode.keys() if len(self._allnode) > 0 else [])
        self._client = kzclient
        self._watchpath = '/monitor'
        self._lastpath = []
        self._restartnode = {}
        self._restartlock = threading.Lock()
        self._restarttimes = {}
        self._restarttimeslock = threading.Lock()
        self._rewatch_children = False

    def _watch_nchildren(self, event):
        """
            brief info for: _watch_nchildren

            Args:
        self :
        event :
            Return:   
            Raise: 
        """
        self._rewatch_children = True
        children = []
        try:
            children = self._client.get_children(self._watchpath, watch=self._watch_nchildren)
            self._rewatch_children = False
        except Exception as e:
            _logger.fatal("watch get_children failed!:%s" % e)
            return
        if(event.type == 'CHILD'):
            newpath = []
            for node in children:
                newpath.append(self._watchpath + '/' + node)
            addpath = [val for val in newpath if val not in self._lastpath]
            delpath = [val for val in self._lastpath if val not in newpath]
            if len(addpath) != 0:
                self._lastpath.extend(addpath)
                _logger.info('Add Child:%s!' % addpath)
                if self._restartlock.acquire() and self._restarttimeslock.acquire():
                    for node in addpath:
                        child = node.split('/')
                        if child[2] in self._restartnode:
                            self._restartnode.pop(child[2])
                        if child[2] in self._restarttimes:
                            self._restarttimes.pop(child[2])
                self._restartlock.release()
                self._restarttimeslock.release()
            elif len(delpath) != 0:
                _logger.info('Delete Child:%s!' % delpath)
                self._lastpath = [val for val in self._lastpath if val not in delpath]
                if self._restartlock.acquire():
                    for node in delpath:
                        child = node.split('/')
                        if child[2] in self._allnode.keys():
                            pgid = self._find_pgid(self._allnode[child[2]])
                            if pgid:
                                if child[2] in self._restartnode:
                                    self._restartnode[child[2]] += 1
                                else:
                                    self._restartnode[child[2]] = 0
                            else:
                                self._restartnode[child[2]] = 0
                                self._restart_node(child[2], pgid)
                self._restartlock.release()
            else:
                _logger.fatal('Watch Child Error! Has not add or del')

    def monitor_nodes(self):
        """
            brief info for: monitor_nodes

            Args:
        self :
            Return:   
            Raise: 
        """
        if self._rewatch_children:
            if not self.start():
                return 

        nodescripts = []
        if self._restartlock.acquire():
            for k, v in self._restartnode.items():
                v += 1
                if v >= 3:
                    if self._allnode[k] not in nodescripts:
                        nodescripts.append(self._allnode[k])
                        pgid = self._find_pgid(self._allnode[k])
                        self._restart_node(k, pgid)
                        self._restartnode[k] = 0
                    else:
                        self._restartnode[k] = 0
                else:
                    self._restartnode[k] += 1
        self._restartlock.release()

    def _find_pgid(self, nodescript):
        """
            brief info for: _find_pgid

            Args:
        self :
        nodescript :
            Return:   
            Raise: 
        """
        tmp = ''
        if nodescript:
            cmd = "ps kstart_time -ef|grep \"" + nodescript + "\"|grep -v grep|awk {'print $2'}"
            popen = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
            tmp = popen.communicate()[0].strip()
        pgid = []
        if tmp != '':
            result = tmp.split('\n')
            for pid in result:
                pgid.append(os.getpgid(int(pid)))
            pgid = list(set(pgid))
            currentpid = os.getpid()
            if currentpid in pgid:
                pgid.remove(currentpid)
        return pgid

    def _restart_node(self, nodename, pgid):
        """
            brief info for: _restart_node

            Args:
        self :
        nodename :
            Return:   
            Raise: 
        """
        if nodename not in self._allnode.keys():
            _logger.fatal('Restart node %s is not in allnode' % nodename)
            return
        nodescript = self._allnode[nodename]
        if pgid:
            for pid in pgid:
                subprocess.Popen("kill -- -%s" % pid, shell=True)
                _logger.info("Node %s shutdown successfully" % nodename)
        p = subprocess.Popen(nodescript, shell=True, preexec_fn=os.setpgrp, stdin=subprocess.PIPE)
        if self._restarttimeslock.acquire(): 
            if nodename in self._restarttimes:
                self._restarttimes[nodename] += 1
                if self._restarttimes[nodename] >= 3:
                    _logger.warning("Node %s is restarted %s times!" %
                            (nodename, str(self._restarttimes[nodename])))
            else:
                self._restarttimes[nodename] = 0
        self._restarttimeslock.release()
        _logger.info("Node %s is restarted! pid is %s" % (nodename, p.pid))

    def start(self):
        """
            brief info for: start

            Args:
        self :
            Return:   
            Raise: 
        """
        self._client.ensure_path(self._watchpath)
        self._restartnode = {}
        self._restarttimes = {}
        self._lastpath = []
        children = []
        try:
            children = self._client.get_children(self._watchpath, watch=self._watch_nchildren)
            self._rewatch_children = False
        except Exception as e:
            _logger.fatal("get children first failed!%s" % e)
            self._rewatch_children = True
            return False
        restartnodes = [val for val in self._allnodenames if val not in children]
        nodescripts = []
        for node in restartnodes:
            if self._allnode[node] not in nodescripts:
                nodescripts.append(self._allnode[node])
                pgid = self._find_pgid(self._allnode[node])
                if not pgid:
                    self._restart_node(node, pgid)
                else:
                    if self._restartlock.acquire():
                        self._restartnode[node] = 0
                    self._restartlock.release()
        for node in children:
            self._lastpath.append(self._watchpath + '/' + node)
        return True
