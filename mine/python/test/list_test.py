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

def test_list():
    list_temp = [1,3,4,5,2,4,3,1,3,4,5,2,4,3,1,2,3]
    print "\t".join(str(item) for item in list_temp)

def test_enumerate():
    list_temp = [1,3,4,5,2,4,3,1,3,4,5,2,4,3,1,2,3]
    for index, value in enumerate(list_temp):
        print index, value
    mydict = {index: value for index, value in enumerate(list_temp)}
    print mydict
    mydict = {value: index for index, value in enumerate(list_temp)}
    print mydict

def test_get():
    list_temp = [1,3,4,5,2,4,3,1,3,4,5,2,4,3,1,2,3]
    mydict = {index: value for index, value in enumerate(list_temp)}
    print mydict.get(1, 0)
    print mydict.get(100, 0)

def test_iteritems():
    list_temp = [1,3,4,5,2,4,3,1,3,4,5,2,4,3,1,2,3]
    mydict = {index: value for index, value in enumerate(list_temp)}
    for key, value in mydict.iteritems():
        print key, value
    for key, value in mydict.items():
        print key, value
    for key in mydict.keys():
        print key
    for value in mydict.values():
        print value
 
def test_level(param):
    limits = [3600, 14400, 86400, 604800, 2592000]
    ret_level = 0;
    for index, limit in enumerate(limits):
        #print param , limit, param / limit
        if param < limit:
            break
        ret_level = index
    return ret_level
            

if __name__ == '__main__':
    #test_list()
    #test_enumerate()
    #test_get()
    #test_iteritems()
    print test_level(0)
    print test_level(3600)
    print test_level(14400)
    print test_level(86400)
    print test_level(604800)
    print test_level(2592000)
    print test_level(12592000)

