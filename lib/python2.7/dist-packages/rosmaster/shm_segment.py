#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
#
########################################################################

"""
File: shm_segment.py
Author: xialiming(xialiming@baidu.com)
Date: 2016/11/23
"""

import logging
import traceback
import threading
import functools
import ctypes
import os
import time
import rosmaster.master_const as master_const
import rosmaster.master_api

class ShmSegmentThread(threading.Thread):

    """
    ShmSegmentThread Class.

    Attributes:
        _logger: a logger object indicator log
        _master_handler: rosmaster _master_handler object

    Methods:
        run(): thread run method
    """

    def __init__(self, master_handler):
        """
        brief info for: __init__

        Args:
            self._logger : a logger object indicator log
            self._master_handler : rosmaster _master_handler object
        Return:
        Raise:
        """
        super(ShmSegmentThread, self).__init__()
        self.setDaemon(True)
        self._logger = logging.getLogger(__name__)
        self._master_handler = master_handler
        self._local_topic_list_file = os.path.join(
            os.environ['ROS_ETC_DIR'], "local_topic_list")
        self._libshm_manager_file = os.path.join(
            os.environ['ROS_ROOT'], "../../lib/", "libshm_manager.so")
        self._pdll = ctypes.CDLL(self._libshm_manager_file)
        if not os.path.exists(self._local_topic_list_file):
            try:
                file_handle = open(self._local_topic_list_file, 'w')
            except IOError:
                _logger.error("Write file error")
            finally:
                file_handle.close()

    def run(self):
        """
        brief info for: thread run method
        Args:
            self :
        Return:
        Raise:
        """
        self._logger.info("starting shm_segment_thread")
        while True:
            try:
                time.sleep(0.1)
                self._master_handler.ps_lock.acquire()
                self._check_loop()
            except Exception as e:
                self._logger.error("shm_segment_thread error is  %s" % e)
                self._logger.error(traceback.format_exc())
            finally:
                self._master_handler.ps_lock.release()

    def _read_segment(self):
        """
        brief info for: _read_segment
        """
        try:
            master_const.SHM_SEGMENT = []
            file_handle = open(self._local_topic_list_file, 'r')
            for line in file_handle:
                if not line in master_const.SHM_SEGMENT:
                    master_const.SHM_SEGMENT.append(line.strip('\n'))
        except IOError:
            self._logger.error("Read file failed, file maybe not exist")
        finally:
            file_handle.close()

    def _write_segment(self):
        """
        brief info for: _write_segment
        """
        try:
            file_handle = open(self._local_topic_list_file, 'w')
            for key in master_const.SHM_SEGMENT:
                file_handle.write(key)
                file_handle.write("\n")
        except IOError:
            self._logger.error("Write file failed")
        finally:
            file_handle.close()

    def _check_loop(self):
        """
        brief info for: _check_loop
        """
        # Get local_shm_segment and master_shm_segment
        self._read_segment()
        master_shm_segment = []
        active_topic = list(set([t for t,_ in self._master_handler.publishers.map.items()]
            + [t for t,_ in self._master_handler.subscribers.map.items()]))

        for k, v in self._master_handler.topics_types.items():
            if k in active_topic:
                master_shm_segment.append(k)

        # Remove unused shm_segment
        for i in master_const.SHM_SEGMENT:
            if i in master_shm_segment:
                self._pdll.compare_block(i)
                continue

            self._logger.error("remove local_shm_segment: %s" % i)
            master_const.SHM_SEGMENT.remove(i)
            self._pdll.remove_segment(i)
            
            # Save local_shm_segment to file
            self._write_segment()
