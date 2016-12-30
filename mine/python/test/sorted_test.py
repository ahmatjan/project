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

def test_sorted():
    test_list=[]
    test_list.append(("hello",2,3.1,4))
    test_list.append(("an apple",1,1.3,1))
    test_list.append(("only a test",5,5.4,3))
    test_list.append(("the world",4,4.5,2))
    sorted_list = sorted(test_list, key=lambda l:l[0])
    print sorted_list
    sorted_list = sorted(test_list, key=lambda l:l[0], reverse=True)
    print sorted_list
    sorted_list = sorted(test_list, key=lambda l:l[0], reverse=False)
    print sorted_list
    sorted_list = sorted(test_list, key=lambda l:l[1])
    print sorted_list
    sorted_list = sorted(test_list, key=lambda l:l[1], reverse=True)
    print sorted_list
    sorted_list = sorted(test_list, key=lambda l:l[1], reverse=False)
    print sorted_list
    for list in sorted_list:
        step = len(list)
        print step

def in_list(sublist, list):
    mainlist_index = 0
    for term in sublist:
        if term not in list[mainlist_index:]:
            return 0
        mainlist_index += list[mainlist_index:].index(term) + 1
    return 1 + in_list(sublist, list[mainlist_index:])

def test_in_list():
    print in_list([1,2,3], [1,2,3])
    print in_list([1,2,3], [1,3,4,5])
    print in_list([1,2,3], [1,3,4,5,2])
    print in_list([1,2,3], [1,3,4,5,2,3])
    print in_list([1,2,3], [1,3,4,5,2,4,3])
    print in_list([1,2,3], [1,3,4,5,2,4,3,1,3,4,5,2,4,3])
    print in_list([1,2,3], [1,3,4,5,2,4,3,1,3,4,5,2,4,3,1,2,3])

def test_map():
    test_map = {x:x*x for x in range(10)}
    print test_map

def test_join():
    test_list = ["1","2","3","4"]
    list_str = "\t".join(test_list)
    print list_str[:list_str.rindex("\t")]
 
if __name__ == '__main__':
    #test_sorted()
    #test_in_list()
    #test_join()
    test_map()

