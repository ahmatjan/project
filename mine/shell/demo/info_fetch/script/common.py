#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module provide common function.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import os
import logging
import ConfigParser
import logging.handlers

def get_confpath(): 
    """
    return conf path.

    Args:
        None

    Returns:
        None

    Raises:
        None
    """
    return "../conf/conf_filter.conf" 


def sigint_handler(signum, frame): 
    """
    handle the sigint signal.

    Args:
        None

    Returns:
        None

    Raises:
        None
    """
    pass


def init_log(conf_path, log_path="", level=logging.INFO, when="D", backup=7):
    """
    init_log - initialize log module

    Args: 
      log_path      - Log file path prefix.
                      Log data will go to two files: log_path.log and log_path.log.wf
                      Any non-exist parent directories will be created automatically
      level         - msg above the level will be displayed
                      DEBUG < INFO < WARNING < ERROR < CRITICAL
                      the default value is logging.INFO
      when          - how to split the log file by time interval
                      'S': Seconds
                      'M': Minutes
                      'H': Hours
                      'D': Days
                      'W': Week day
                      default value: 'D'
      backup        - how many backup file to keep
                      default value: 7

    Returns: 
        True: succ to init log
        False: fail to init log

    Raises:
        None
    """
    if not log_path.strip(): 
        try:
            config = ConfigParser.ConfigParser()
            config.read(conf_path)
            log_path = config.get("log", "log_path")
        except Exception as ex: 
            print(
                'read conf to get log_path error: %s: %s'
                % (Exception, ex))
            return False

    try: 
        format = "%(levelname)s: %(asctime)s: %(filename)s: %(lineno)d " \
            "%(funcName)s * %(thread)d %(message)s"
        datefmt = "%m-%d %H: %M: %S"
        formatter = logging.Formatter(format, datefmt)
        logger = logging.getLogger()
        logger.setLevel(level)

        dir = os.path.dirname(log_path)
        if not os.path.isdir(dir): 
            os.makedirs(dir)

        handler = logging.handlers.TimedRotatingFileHandler(
            log_path + ".log", 
            when = when, 
            backupCount = backup)
        handler.setLevel(level)
        handler.setFormatter(formatter)
        logger.addHandler(handler)

        handler = logging.handlers.TimedRotatingFileHandler(
            log_path + ".log.wf", 
            when = when, 
            backupCount = backup)
        handler.setLevel(logging.WARNING)
        handler.setFormatter(formatter)
        logger.addHandler(handler)
    except Exception as ex: 
        print(
            'init log error, logpath: [%s], %s: %s'
            % (log_path, Exception, ex))
        return False
    return True
 

