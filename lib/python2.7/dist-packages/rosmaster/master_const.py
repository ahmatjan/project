#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
#
########################################################################

"""
File: master_const.py
Author: haifeng(haifeng@baidu.com)
Date: 2016/02/22 16:05:20
"""

MASTER_ZKPATH = "/master"
ELECTION_ZKPATH = "/election"
KAZOO_TIMEOUT = 0.1

ROSMASTER_ZKPATH = "/rosmaster"

PARAMETERS_PERSIST_ZKPATH = ROSMASTER_ZKPATH + "/parameters_persist"
PARAMETERS_ZKPATH = ROSMASTER_ZKPATH + "/parameters"
TOPIC_TYPES_ZKPATH = ROSMASTER_ZKPATH + "/topics_types"
NODES_ZKPATH = ROSMASTER_ZKPATH + "/nodes"
PUBLISHERS_ZKPATH = ROSMASTER_ZKPATH + "/publishers"
SUBSCRIBERS_ZKPATH = ROSMASTER_ZKPATH + "/subscribers"
SERVICES_ZKPATH = ROSMASTER_ZKPATH + "/services"
SERVICES_MAP_ZKPATH = ROSMASTER_ZKPATH + "/services_map"
PARAM_SUBSCRIBERS_ZKPATH = ROSMASTER_ZKPATH + "/param_subscribers"

PARAMETERS_SKIP = ["roslaunch", "run_id"]
TOPIC_TYPES_SKIP = []
NODES_SKIP = []
PUBLISHERS_SKIP = []
SUBSCRIBERS_SKIP = []
SERVICES_SKIP = []
SERVICES_MAP_SKIP = []
PARAM_SUBSCRIBERS_SKIP = []
PARAMETERS_PERSIST_SKIP = []
SHM_SEGMENT = []

PARAMETERS_DICT = 1
TOPIC_TYPES_DICT = 2
NODES_DICT = 3
PUBLISHERS_DICT = 4
SUBSCRIBERS_DICT = 5
SERVICES_DICT = 6
SERVICES_MAP_DICT = 7
PARAM_SUBSCRIBERS_DICT = 8
PARAMETERS_PERSIST_DICT = 9

ZOO_RETRY_TIMES = 5