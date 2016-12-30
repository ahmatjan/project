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

def test_map():
    temp_map = {x:x for x in range(10)}
    param_str = ",".join(["%s:%s" % (str(key).encode('utf-8'), str(value).encode('utf-8')) for key, value in temp_map.iteritems()])
    print temp_map
    print param_str
            

if __name__ == '__main__':
    test_map()

