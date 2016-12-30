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

def test_condition():
    print 0 if True else 1
    print 0 if False else 1

    print 0 and True or 1
    print 2 and True or 1
    print 2 and False or 1

if __name__ == '__main__':
    test_condition()

