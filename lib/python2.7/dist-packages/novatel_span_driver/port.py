#! /usr/bin/env python
# -*- coding: utf-8 -*-

# Software License Agreement (BSD)
#
#  file      @port.py
#  authors   Mike Purvis <mpurvis@clearpathrobotics.com>
#            NovAtel <novatel.com/support>
#  copyright Copyright (c) 2012, Clearpath Robotics, Inc., All rights reserved.
#            Copyright (c) 2014, NovAtel Inc., All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that
# the following conditions are met:
#  * Redistributions of source code must retain the above copyright notice, this list of conditions and the
#    following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
#    following disclaimer in the documentation and/or other materials provided with the distribution.
#  * Neither the name of Clearpath Robotics nor the names of its contributors may be used to endorse or promote
#    products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WAR-
# RANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, IN-
# DIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
import string

import rospy
import struct
import serial
import os
import novatel_msgs.msg as msg
import time
from diagnostics  import NovatelDiagnostics

# Node source
from translator import Translator

# Python
import threading
import socket
import struct
from cStringIO import StringIO


class Port(threading.Thread):
    """ Common base class for DataPort and ControlPort. Provides functionality to
      recv/send novatel-formatted packets from the socket. Could in future
      support LoggingPort and DisplayPort."""
    checksum_struct = struct.Struct("<hh")
    #filename="/home/newton/Desktop/0304gps.bin"
    #filename=rospy.get_param('~filename',"gps.bin")
    pwd=os.path.abspath('.')
    mdir="/"+pwd.split("/")[1]+"/"+pwd.split("/")[2]
    filename=mdir+"/Desktop/"+time.strftime("%Y%m%d_%H%M%S")+".bin"

    def __init__(self, sock, **opts):
        super(Port, self).__init__()
        self.sock = sock
        self.opts = opts
        self.daemon = False
        self.finish = threading.Event()
        self.bSerial = False
        if type(self.sock) == type(serial.Serial()):
            self.fp=open(self.filename,"wb+")
            rospy.logerr("open local file for logging: %s",self.filename)

    def close_file(self):
        if type(self.sock) == type(serial.Serial()):
            self.fp.close()

    def recv_serial(self):
        header = msg.CommonHeader()
        footer = msg.CommonFooter()
        tmpstr=""

        get=self.sock.read

        bytes_before_sync = []
        try:
            while True:
                sync = get(1)
                self.fp.write(sync)
                if sync == "\xAA":
                    bytes_before_sync = ''.join(bytes_before_sync)
                    if len(bytes_before_sync) > 0 and not bytes_before_sync.startswith("\r\n<OK"):
                        rospy.logwarn(("Discarded %d bytes between end of previous message " +
                                      "and next sync byte.") % len(bytes_before_sync))
                        rospy.logwarn("Discarded: %s" % repr(bytes_before_sync))
                    break
                bytes_before_sync.append(sync)

            sync =get(1)
            self.fp.write(sync)
            if sync != "\x44":
                raise ValueError("Bad sync2 byte, expected 0x44, received 0x%x" % ord(sync[0]))
            sync = get(1)
            self.fp.write(sync)
            if sync != "\x12":
                raise ValueError("Bad sync3 byte, expected 0x12, received 0x%x" % ord(sync[0]))
        except serial.SerialTimeoutException:
            return None,None

        # Four byte offset to account for 3 sync bytes and one header length byte already consumed.
        #header_length = ord(get(1)[0]) - 4
        header_len_b=get(1)[0]
        header_length = ord(header_len_b) - 4
        #tmpstr="\xAA\x44\x12"+header_len_b
        tmpstr=header_len_b
        if header_length != header.translator().size:
            raise ValueError("Bad header length. Expected %d, got %d" %
                             (header.translator().size, header_length))

        header_str = get(header_length)
        header_data = StringIO(header_str)
        header.translator().deserialize(header_data)

        tmpstr+=header_str

        #self.header_check(header_str)

        packet_str = get(header.length)
        footer_data_b=get(footer.translator().size)
        footer_data = StringIO(footer_data_b)
        tmpstr+=packet_str
        tmpstr+=footer_data_b

        self.fp.write(tmpstr)
        os.fsync(self.fp)

        return header, packet_str


    def recv(self, d=False):
        """ Receive a packet from the port's socket.
        Returns (header, pkt_str)
        Returns None, None when no data. """

        if type(self.sock) == type(serial.Serial()):
            header,packet_str=self.recv_serial()
            return header, packet_str

        header = msg.CommonHeader()
        footer = msg.CommonFooter()

        get=self.sock.recv


        try:
            bytes_before_sync = []
            while True:
                sync = get(1)
                if sync == "\xAA":
                    bytes_before_sync = ''.join(bytes_before_sync)
                    if len(bytes_before_sync) > 0 and not bytes_before_sync.startswith("\r\n<OK"):
                        rospy.logwarn(("Discarded %d bytes between end of previous message " +
                                      "and next sync byte.") % len(bytes_before_sync))
                        rospy.logwarn("Discarded: %s" % repr(bytes_before_sync))
                    break
                bytes_before_sync.append(sync)

            sync =get(1)
            if sync != "\x44":
                raise ValueError("Bad sync2 byte, expected 0x44, received 0x%x" % ord(sync[0]))
            sync = get(1)
            if sync != "\x12":
                raise ValueError("Bad sync3 byte, expected 0x12, received 0x%x" % ord(sync[0]))

            # Four byte offset to account for 3 sync bytes and one header length byte already consumed.
            header_length = ord(get(1)[0]) - 4
            if header_length != header.translator().size:
                raise ValueError("Bad header length. Expected %d, got %d" %
                                 (header.translator().size, header_length))

        except socket.timeout:
            return None, None

        header_str = get(header_length)
        header_data = StringIO(header_str)
        header.translator().deserialize(header_data)

        #self.header_check(header_str)

        packet_str = get(header.length)
        footer_data = StringIO(get(footer.translator().size))
        
        if header.id==1067:
            now=rospy.get_rostime()
            now_sec=now.secs
            now_nsec=now.nsecs

            header.gps_week_milliseconds=now_sec
            header.receiver_status=now_nsec

        return header, packet_str

    def header_check(self, header_str):
        NovatelDiagnostics.cpu_idle = ord(header_str[8])     # 12-4 = 8  
        NovatelDiagnostics.time_status = ord(header_str[9]) 
      #gps_msec=(struct.unpack('L',header_str[16:20])[0])
      #receiver_status=(struct.unpack('L',header_str[20:24])[0])
 
      #rospy.logerr("%d",gps_msec)
 
        if ord(cpu_idle)/2 < 30:
            rospy.logerr("CPU IDLE TIME DEBUG: %d", ord(cpu_idle)/2)
      #TODO
      #TODO  Time status
      #TODO  receiver status


    def send(self, header, message):
        """ Sends a header/msg/footer out the socket. Takes care of computing
        length field for header and checksum field for footer. """

        msg_buff = StringIO()
        message.translator().preserialize()
        message.translator().serialize(msg_buff)
        pad_count = -msg_buff.tell() % 4
        msg_buff.write("\x00" * pad_count)

        footer = msg.CommonFooter(end=msg.CommonFooter.END)
        header.length = msg_buff.tell() + footer.translator().size

        # Write header and message to main buffer.
        buff = StringIO()
        header.translator().serialize(buff)
        buff.write(msg_buff.getvalue())

        # Write footer.
        footer_start = buff.tell()
        footer.translator().serialize(buff)

        # Compute checksum.
        buff.seek(0)
        footer.checksum = 65536 - self._checksum(buff)

        # Rewrite footer with correct checksum.
        buff.seek(footer_start)
        footer.translator().serialize(buff)

        if type(sock) != type(serial.Serial()):
            self.sock.send(buff.getvalue())
        else:
            self.sock.write(buff.getvalue())

    @classmethod
    def _checksum(cls, buff):
        """ Compute novatel checksum. Expects a StringIO with a
      size that is a multiple of four bytes. """
        checksum = 0

        while True:
            data = buff.read(cls.checksum_struct.size)

            if len(data) == 0:
                break
            if len(data) < 4:
                pad_count = len(data) % 4
                data = data + "\x00" * pad_count
                raise ValueError("Checksum data length is not a multiple of 4. %d" % len(data))
            print(data)
            rospy.logwarn("unpack_data")
            c1, c2 = cls.checksum_struct.unpack(data)
            checksum += c1 + c2
        print(checksum, checksum % 65536)  # novatel 32 bit crc
        return checksum % 65536
