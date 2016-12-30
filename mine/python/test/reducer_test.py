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

def add(x, y):
    return x + y

def test_list():
    list_temp = [1,3,4,5,2,4,3,1,3,4,5,2,4,3,1,2,3]
    print reduce(lambda x, y: x + y, [i for i in range(10)])
    print reduce(add, [i for i in range(10)])
    print reduce(lambda x, y: x * y, [i for i in range(1, 10)])
            

if __name__ == '__main__':
    test_list()

