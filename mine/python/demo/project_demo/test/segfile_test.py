#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module test the functions of class segfile.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import unittest
import threading
import sys
import os

script_path=os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/script"
sys.path.append(script_path)

import segfile

class ISegfileTestCase(unittest.TestCase): 
    """test the ISegfile class."""
    def test_create_normal(self): 
        """test the create func of ISegfile class, normal."""
        ifile = segfile.ISegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.cycle, 900)

    def test_open_normal(self): 
        """test the open func of ISegfile class, normal."""
        ifile = segfile.ISegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.open("20141101-0000", 0), True)

    def test_open_abnormal(self): 
        """test the open func of ISegfile class, abnormal."""
        ifile = segfile.ISegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.open("20141101-1000", 0), False)

    def test_read_normal(self): 
        """test the read func of ISegfile class, normal."""
        ifile = segfile.ISegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.open("20141101-0000", 0), True)
        self.assertEqual(ifile.readline(), "")

    def test_desc_normal(self): 
        """test the desc func of ISegfile class, normal."""
        ifile = segfile.ISegfile("../data", "change.", ".log", 900)
        print ifile.desc()


class OSegfileTestCase(unittest.TestCase): 
    """test the OSegfile class."""
    def test_create_normal(self): 
        """test the create func of OSegfile class, normal."""
        ifile = segfile.OSegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.cycle, 900)

    def test_open_normal(self): 
        """test the open func of OSegfile class, normal."""
        ifile = segfile.OSegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.open(), True)

    def test_write_normal(self): 
        """test the write func of OSegfile class, normal."""
        ifile = segfile.OSegfile("../data", "change.", ".log", 900)
        self.assertEqual(ifile.open(), True)
        self.assertEqual(ifile.writeline("testline"), True)

    def test_desc_normal(self): 
        """test the desc func of OSegfile class, normal."""
        ifile = segfile.OSegfile("../data", "change.", ".log", 900)
        print ifile.desc()


if __name__ == '__main__': 
    unittest.main()
