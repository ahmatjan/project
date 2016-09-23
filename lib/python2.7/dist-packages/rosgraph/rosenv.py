# Software License Agreement (BSD License)
#
# Copyright (c) 2009, Willow Garage, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of Willow Garage, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

import os
import sys

ROS_MASTER_URI   = "ROS_MASTER_URI"

ROS_IP           ="ROS_IP"
ROS_IPV6         ="ROS_IPV6"
ROS_HOSTNAME     ="ROS_HOSTNAME"
ROS_NAMESPACE    ="ROS_NAMESPACE"

ROS_MASTER_PATH  = "/master/election"

def get_master_uri(env=None, argv=None):
    """Get master uri from zookeeper.
    """
    import logging
    from kazoo.client import KazooClient        
    logging.basicConfig()

    ret = None
#zk_host = os.getenv(key='ZK_HOST', default="127.0.0.1:2181") 
    zk_host = os.getenv(key='ZK_HOST')
    if zk_host is None:
        if env is None:
            env = os.environ
        if argv is None:
            argv = sys.argv
        try:
            for arg in argv:
                if arg.startswith('__master:='):
                    val = None
                    try:
                        _, val = arg.split(':=')
                    except:
                        pass
                    if not val:
                        raise ValueError("__master remapping argument '%s' \
                                improperly specified" % arg)
                    return val
            return env[ROS_MASTER_URI]
        except KeyError as e:
            return None
    else:
        zk = KazooClient(zk_host, 5.0)     
        try:
            zk.start()
            data, _stat = zk.get(ROS_MASTER_PATH)
            ret = data
        except Exception as e:
            pass
        finally:
            zk.stop()
            zk.close()
        return ret

