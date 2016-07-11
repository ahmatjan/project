#!/usr/bin/env python
# -*- coding: utf-8 -*-
########################################################################
# 
# Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
# 
########################################################################
 
"""
File: zkclient.py
Author: zhangweide(zhangweide@baidu.com)
Date: 2016/02/12 23:34:46
"""
import logging 
from functools import partial
from kazoo.protocol.states import KazooState
from kazoo.exceptions import CancelledError 
from kazoo.client import KazooClient
import warnings
import struct 

class ZKClient(object):
    """ zkclient 
        
    zkclient provides methods for interacting with zk 
    all calls are expected to be synchronous to simplify workflows 

    Attributes:
        client: KazooClient
    """
    def __init__(self, servers):
        self.client = KazooClient(servers)
        self.client.start()

    def ensure_sync(self, path):
        """ ensure path in sync with zk 
            
            Args:
                path : zk path to ensure 
            Return:   
                kazoo.interfaces.IAsyncResult
            Raise: 
        """
        return self.client.ensure_path(path)

    def create_sync(self, path, value=b"", acl=None, ephemeral=False, sequence=False, \
        makepath=True):
        """
            create path synchronously with zk 
            
            Args:
                path : zk path
                value : zk node value 
                acl : acl 
                ephemeral :
                sequence :
                makepath :
            Return:
                kazoo.interface.IAsyncResult
            Raise: 
        """
        return self.client.create(path, value, acl, ephemeral, sequence, makepath)
        
    def delete_sync(self, path, recurse=True):
        """ delete path synchronously with zk
            
            Args:
                path : zk path
                recurse : delete recursively
            Return:   
                kazoo.interface.IAsyncResult
            Raise: 
        """
        return self.client.delete(path, recursive=recurse)

    def get_sync(self, path, watch=None):
        """ get value from znode
            
            Args:
                path : zk path 
                watch : watch callback 
            Return:   
                value : (value, zstat)
            Raise: 
        """
        return self.client.get(path, watch)

    def set_sync(self, path, value=b''):
        """ set value for path 
            Args:
                path : zk path 
                value : value encoded 
            Return: ZNodeStat  
            Raise: 
        """
        return self.client.set(path, value)

    def get_children_sync(self, path, watch=None, data=False):
        """
            get children node from current path
            
            Args:
                path : zk path
                watch : 
                data :
            Return:   
                kazoo.interface.IAsyncResult
            Raise: 
        """
        return self.client.get_children(path, watch=watch, include_data=data)
