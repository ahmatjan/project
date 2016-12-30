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

def test_iterator():
    list_temp = [0,1,2,3,4,5]
    it = iter(list_temp)
    try:
        while True:
            print next(it)
    except StopIteration as ex:
        print "%s %s" % (StopIteration, ex)

class SimpleList(object):
    def __init__(self, *items):
        self.items = items

    def __getitem__(self, i):
        return self.items[i]

# TypeError: 'SimpleList1' object is not iterable''
class SimpleList1(object):
    def __init__(self, *items):
        self.items = items

class SimpleList2(object):
    def __init__(self, *items):
        self.items = items
        self.i = -1

    def __iter__(self):
        return self

    def next(self):
        try:
            self.i += 1
            return self.items[self.i]
        except IndexError as ex:
            raise StopIteration("")

class SimpleList3(object):
    def __init__(self):
        self.n = 0

    def __iter__(self):
        return self

    def next(self):
        self.n += 1
        if self.n > 1000:
            raise StopIteration("")
        return self.n


def test_simple_list():
    list_temp = SimpleList(0,1,2,3,4,5)
    it = iter(list_temp)
    try:
        while True:
            print next(it)
    except StopIteration as ex:
        print "%s %s" % (StopIteration, ex)

def test_simple_list2():
    list_temp = SimpleList2(0,1,2,3,4,5)
    it = iter(list_temp)
    try:
        while True:
            print next(it)
    except StopIteration as ex:
        print "%s %s" % (StopIteration, ex)

def test_simple_list3():
    list_temp = SimpleList3()
    it = iter(list_temp)
    try:
        while True:
            print next(it)
    except StopIteration as ex:
        print "%s %s" % (StopIteration, ex)


if __name__ == '__main__':
    test_iterator()
    test_simple_list()
    test_simple_list2()
    test_simple_list3()

