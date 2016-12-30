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

def logged(time_format):
    def decorator(func):
        def decorated_func(*args, **kwargs):
            print "- Running '%s' on %s " % (func.__name__, time.strftime(time_format))
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            print "- Finished '%s', execution time = %0.3fs " % (func.__name__, end_time - start_time)

            return result
        decorated_func.__name__ = func.__name__
        return decorated_func
    return decorator

@logged("%b %d %Y - %H:%M:%S")
def add1(x, y):
    time.sleep(1)
    return x + y;
            
@logged("%b %d %Y - %H:%M:%S")
def add2(x, y):
    time.sleep(2)
    return x + y;

if __name__ == '__main__':
    add1(1, 2)
    add2(3, 4)

