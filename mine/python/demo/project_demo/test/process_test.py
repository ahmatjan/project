#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module test the functions of class process.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import unittest
import threading
import sys
import os

script_path=os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/script"
sys.path.append(script_path)

import process

class ProducerProcessTestCase(unittest.TestCase): 
    """test the ProducerProcess class."""
    def test_init_normal(self): 
        """test the init func of ProducerProcess class, normal."""
        producerprocess = process.ProducerProcess(0)
        self.assertEqual(producerprocess.init(), True)

    def test_proc_normal(self): 
        """test the proc func of ProducerProcess class, normal."""
        producerprocess = process.ProducerProcess(0)
        self.assertEqual(producerprocess.init(), True)
        self.assertEqual(producerprocess.proc(), True)


class ConsumerProcessTestCase(unittest.TestCase): 
    """test the ConsumerProcess class."""
    def test_init_abnormal(self): 
        """test the init func of ConsumerProcess class, abnormal."""
        idxdict = {}
        consumerprocess = process.ConsumerProcess(0, idxdict)
        self.assertEqual(consumerprocess.init("20141111-0000", 0), False)

    def test_proc_abnormal(self): 
        """test the proc func of ConsumerProcess class, abnormal."""
        idxdict = {}
        consumerprocess = process.ConsumerProcess(0, idxdict)
        self.assertEqual(consumerprocess.init("20141111-0000", 0), False)
        self.assertEqual(consumerprocess.proc(), False)


if __name__ == '__main__': 
    unittest.main()
