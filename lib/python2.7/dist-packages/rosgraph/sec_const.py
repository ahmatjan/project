#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
# Security SDK global define
#
########################################################################

"""
File: sec_const.py
Author: hanyu02
Date: 2016/09/14
"""
import os
import sys
env = os.environ.get('ROS_SEC_DISABLE')
if env is None:
    ENABLE_SEC_FUNCTION = 1
else:
    ENABLE_SEC_FUNCTION = 0

SEC_HEAD_LENGTH = 4
