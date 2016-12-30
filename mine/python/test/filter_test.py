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

def f(x):
    return x % 2 != 0 and x % 3 != 0

def test_filter():
    print filter(f, range(60))

if __name__ == '__main__':
    test_filter()

