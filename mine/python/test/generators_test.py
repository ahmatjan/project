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

def count_generator():
    n = 0
    while True:
        yield n
        n += 1

def hofstadter_generator(s):
    a = s[:]
    while True:
        try:
            q = a[-a[-1]] + a[-a[-2]]
            a.append(q)
            yield q
        except IndexError:
            return

def test_generator():
    counter = count_generator()
    print next(counter)
    print next(counter)
    print next(counter)
    print next(counter)

    print ""
    counter = hofstadter_generator([1,2])
    print next(counter)
    print next(counter)
    print next(counter)
    print next(counter)

import itertools

# È«ÅÅÁÐ
def test_permutations():
    for p in itertools.permutations([1,2,3]):
        print p

if __name__ == '__main__':
    test_generator()
    test_permutations()

