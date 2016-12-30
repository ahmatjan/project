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

import re
import pprint

def test_regex():
    str = "(123)23456"
    m = re.search("(\(.*\)).*", str)
    pprint.pprint(m.group(1))
    print m.group(1)
    print m.string
    print m.re
    print m.pos
    print m.lastgroup

if __name__ == '__main__':
    test_regex()

