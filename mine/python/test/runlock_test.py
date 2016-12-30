#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module test some functions

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2015/01/12 12:23:06
"""

import time
import sys
sys.path.append("../script")

import lock

if __name__ == '__main__':
    rlock = lock.RunLock()
    if 0 != rlock.lock():
        print "already running."
        exit(0)
    while True:
        time.sleep(1)
        print "running..."

