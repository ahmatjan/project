#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module provide some locks.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import os
import sys
import time
import atexit
import signal
import logging
import threading

class RunLock(object): 
    """
    """
    def __init__(self, file="pid.lock"): 
        self.file = file

    def lock(self): 
        """function to create lock file."""
        if os.path.exists(self.file):
            fd = open(self.file)
            pid = fd.readline().strip()
            if pid and os.path.exists("/proc/%s" % pid):
                return -1
        fd = open(self.file, "w+")
        fd.write("%s\n" % os.getpid())
        fd.close()
        atexit.register(self.clean)
        return 0

    def clean(self): 
        """function to clean lock file."""
        if os.path.exists(self.file):
            os.remove(self.file)


