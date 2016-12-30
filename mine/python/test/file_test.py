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

def test_file():
    with open("idx") as input:
        for line in input.readlines():
            fields = line.strip().split("\t")
            print fields[1:2]
            print line

def test_char():
    print "ver:0.1\001uo%s\n" % "http://cooder.baidu.com/594601/codiff/785969/9614129"

def test_dict(x):
    #xx = Xxx()
    #xx = x[1]
    #print xx.a
    print x[1].a

class Xxx :
    def __init__(self):
        self.a = 3

if __name__ == '__main__':
    #test_file()
    x = Xxx()
    temp_dict = {}
    temp_dict[1] = x
    test_dict(temp_dict)
    #test_char()

