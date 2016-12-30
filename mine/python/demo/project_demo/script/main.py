#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module provide the main function to create object of CentralCtrl.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import sys
import time
import getopt
import signal
import logging
import optparse
import ConfigParser
import multiprocessing

import common
import process

def main(args): 
    """the main function of this module."""
    if not common.init_log(): 
        logging.error("init_log error.")
        return 1
    try:
        opts, args = getopt.getopt(args, "hv", ["help", "version"])
        for opt, arg in opts:
            if opt in ("-h", "--help"):
                print "usage"
                return 0
            elif opt in ("-v", "--version"):
                print "version"
                return 0
    except getopt.GetoptError: 
        print "get opt error."
        return 1
    except Exception as ex:
        logging.error('get opt error, %s: %s' % (Exception, ex))
        return 1
    logging.info("PROCESS BEGIN.")
    signal.signal(signal.SIGINT, common.sigint_handler)
    signal.signal(signal.SIGTERM, common.sigint_handler)
    central_ctrl = process.CentralCtrl()
    central_ctrl.start()
    central_ctrl.join()
    time.sleep(1)
    logging.info("PROCESS FINISH.")
    return 0

if __name__ == '__main__': 
    usage = "usage: %prog [options] args"
    parser = optparse.OptionParser(usage=usage, version="%prog 1.0.0.0")
    parser.add_option("-f", "--file", action="store",
            dest="dataset_file",
            default="None",
            help="pair path dataset file")
    parser.add_option("-c", "--config", action="store",
            dest="conf_file",
            default="None",
            help="app configuration file")
    (options, args) = parser.parse_args()
    print options.dataset_file
    print options.conf_file
    #ret = main(sys.argv[1:])
    #exit(ret)


