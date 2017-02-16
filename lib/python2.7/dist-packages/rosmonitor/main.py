#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
# 
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
# 
########################################################################

"""
File: main.py
Author: mayu01(mayu01@baidu.com)
Date: 2016/02/17 16:21:29
"""
import sys
import os
import logging
import socket
import subprocess
import ConfigParser
import optparse
import time
import shlex

import rosgraph.roslogging

import rosmonitor.monitor as monitor

DEFAULT_MASTER_PORT = 11311
MASTER_CYCLE = 10
MASTER_NUM = 2
MASTERSCRIPT = "roscore -p %s"
currentport = 0

_logger = logging.getLogger("rosmonitor.main")


def alive(port):
    """
        brief info for: alive
        Check this port is already occupied. 

        Args:
            port: a integer or string
        Return:   
            boolean 
        Raise: 
    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        sock.connect(('127.0.0.1', int(port)))
        sock.shutdown(2)
        return True
    except:
        return False


def findalivemaster():
    """
        brief info for: findalivemaster
        find rosmaster ports which are started.  
        Args:
        Return: rosmaster ports.
            arg type: list.
            if there is no rosmaster which are started,list is []
        Raise: 
    """
    findcmd = "ps -ef|grep \"roscore -p\"|grep -v grep|awk {'print $11'}" 
    popen = subprocess.Popen(findcmd, shell=True, stdout=subprocess.PIPE)
    port = popen.communicate()[0].strip().split('\n')
    if "" in port:
        port.remove("")
    return port


def start_master():
    """
        brief info for: start_master
        Make sure at least Master_NUM masters on running after run this function. 

        Args:
    mastport :
        Return:   
        Raise: 
    """
    global currentport
    list_port = findalivemaster()
    if len(list_port) > 0:
        for port in list_port:
            if not port.isdigit():
                list_port.remove(port)
                continue
            if (int(port) < int(DEFAULT_MASTER_PORT) + int(MASTER_CYCLE) 
                and int(port) >= int(DEFAULT_MASTER_PORT)):
                if int(currentport) < int(port) % int(MASTER_CYCLE):
                    currentport = int(port) % int(MASTER_CYCLE)
    if len(list_port) > MASTER_NUM:
        _logger.info("ROSCORE's Num is %s in this machine" % str(len(list_port)))
        return
    needmasternum = MASTER_NUM - len(list_port)
    while needmasternum > 0:
        needmasternum -= 1
        num = 0
        while alive(DEFAULT_MASTER_PORT + currentport) or num >= MASTER_CYCLE:
            currentport = (currentport + 1) % MASTER_CYCLE
            num += 1
        if num >= MASTER_CYCLE:
            _logger.warning("NO PORT AVALIBLE")
            return
        port = DEFAULT_MASTER_PORT + currentport
        currentport = (currentport + 1) % MASTER_CYCLE
        cmd = MASTERSCRIPT % port
        args = shlex.split(cmd)
        subprocess.Popen(args, preexec_fn=os.setpgrp)
        _logger.info("Master on Port:%s is Started!" % port)


def monitor_main(argv=None):
    """
        brief info for: monitor_main

        Args:
    argv :
    logdir :
        Return:   
        Raise: 
    """
    if argv is None:
        argv = sys.argv
    rosgraph.roslogging.configure_logging('rosmonitor', logging.DEBUG, filename="monitor.log")
    parser = optparse.OptionParser(usage="usage: monitor [options]")
    parser.add_option("-c", "--conf", dest="config_file", metavar="FILE",
        help="config file path. section [allnodes] is needed!")
    (options, args) = parser.parse_args(argv)

    if not options.config_file:
        parser.print_help()
        return

    cf = ConfigParser.ConfigParser()
    cf.read(options.config_file)
    sections = cf.sections()

    if 'allnodes' not in sections:
        parser.print_help()
        return

    kvDict = {}
    for section in sections:
        kvs = cf.items(section)
        nvDict = dict((key, value) for key, value in kvs)
        kvDict[section] = nvDict

    if "ZK_HOST" not in os.environ:
        _logger.fatal("Environ Variable 'ZK_HOST' not set.")
        return 
    elif os.environ["ZK_HOST"].strip() == "":
        _logger.fatal("Environ Variable 'ZK_HOST' is null.")
        return
    else:
        zkservers = os.environ["ZK_HOST"] 

    global MASTER_NUM
    if 'master' in kvDict:
        MASTER_NUM = int(kvDict['master']['master_num'])
    if MASTER_NUM < 0 or MASTER_NUM > MASTER_CYCLE:
        _logger.fatal("set master_num wrong in monitor.conf ")
        return

    if MASTER_NUM != 0:
        start_master()
        time.sleep(1)

    allnodes = kvDict['allnodes']

    mon = monitor.Monitor(zkservers, allnodes)
    try:
        while True:
            mon.start()
            if MASTER_NUM != 0:
                start_master()
            time.sleep(1)
    except KeyboardInterrupt:
        _logger.info("KeyboardInterrupt")
    finally:
        mon.stop()         
