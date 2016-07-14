#! /usr/bin/env python
# -*- coding: utf-8 -*-

# Software License Agreement (BSD)
#
#  file      @bridge.py
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

# ROS
import rospy
import time
import serial
from novatel_msgs.msg import *
from std_msgs.msg import String

# Package modules
from novatel_span_driver.data import DataPort
from novatel_span_driver.monitor import Monitor

# Standard
import socket
import struct
from cStringIO import StringIO
import time

from novatel_span_driver import translator

DEFAULT_IP = '192.168.1.40'
DEFAULT_PORT = 2000

SOCKET_TIMEOUT = 100.0
socks = []
ports = {}
monitor = Monitor(ports)


def init():
    ip = rospy.get_param('~ip', DEFAULT_IP)
    data_port= rospy.get_param('~port', DEFAULT_PORT)
    serial_port = rospy.get_param('~serialport', "/dev/ttyS0")
    serial_baudrate = rospy.get_param('~baudrate', 115200)
    # 0 for socket;  1 for serial
    port_type = rospy.get_param('~porttype', 0)
    imu_type = rospy.get_param('~imu_type', 'ADIS16488')
    test = rospy.get_param('~pc_filename',"NULL")


    rospy.logerr("imu_type: %s",imu_type)
    rospy.logerr("test: %s",test)

    # Pass this parameter to use pcap data rather than a socket to a device.
    # For testing the node itself--to exercise downstream algorithms, use a bag.
    pcap_file_name = rospy.get_param('~pcap_file', False)

    if not pcap_file_name:
        if port_type==0:
            sock = create_sock('data', ip, data_port)
        else:
            sock = create_serial('data',serial_baudrate,serial_port)
    else:
        sock = create_test_sock(pcap_file_name)

    ports['data'] = DataPort(sock)

    configure_receiver(sock)

    for name, port in ports.items():
        port.start()
        rospy.loginfo("Port %s thread started." % name)
    monitor.start()

    time.sleep(5)
    enable_trigger(sock)

    rospy.on_shutdown(shutdown)


def create_sock(name, ip, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        ip_port = (ip, port)
        sock.connect(ip_port)
        rospy.loginfo("Successfully connected to %%s port at %s:%d" % ip_port % name)
    except socket.error as e:
        rospy.logfatal("Couldn't connect to %%s port at %s:%d: %%s" % ip_port % (name, str(e)))
        exit(1)
    sock.settimeout(SOCKET_TIMEOUT)
    socks.append(sock)
    return sock


def create_test_sock(pcap_filename):
    rospy.sleep(0.1)

    try:
        import pcapy
    except ImportError:
        import pure_pcapy as pcapy

    from StringIO import StringIO
    from impacket import ImpactDecoder

    body_list = []
    if pcap_filename.endswith("gz"):
        # From: http://projects.honeynet.org/honeysnap/changeset/35/trunk/honeysnap/__init__.py
        import tempfile
        import gzip
        tmph, tmpf = tempfile.mkstemp()
        tmph = open(tmpf, 'wb')
        gfile = gzip.open(pcap_filename)
        tmph.write(gfile.read())
        gfile.close()
        tmph.close()
        pcap_filename = tmpf

    cap = pcapy.open_offline(pcap_filename)
    decoder = ImpactDecoder.EthDecoder()

    while True:
        header, payload = cap.next()
        if not header:
            break
        try:
            tcp = decoder.decode(payload).child().child()
            body_list.append(tcp.child().get_packet())
        except AttributeError:
            print decoder.decode(payload)
            raise

    data_io = StringIO(''.join(body_list))

    class MockSocket(object):
        def recv(self, byte_count):
            rospy.sleep(0.002)
            data = data_io.read(byte_count)
            if data == "":
                rospy.signal_shutdown("Test completed.")
            return data

        def settimeout(self, timeout):
            pass

    return MockSocket()

def create_serial(name, rate_, port_):    
  ser = serial.Serial(
     port=port_,
	 baudrate=rate_,
	 parity=serial.PARITY_NONE,
     bytesize=serial.EIGHTBITS,
	 stopbits=serial.STOPBITS_ONE,
     timeout=SOCKET_TIMEOUT/100,
     rtscts=False,
     dsrdtr=False,
     xonxoff=False)
 
  if ser.isOpen():
    ser.close()

  try:
    ser.open()
    rospy.loginfo("Successfully connected to %%s port at %s" % port_ % name)
  except serial.ValueError as e:
    rospy.logfatal("%s" % str(e))
  except serial.SerialException as e:
    rospy.logfatal("Couldn't connect serial: %s: %%s" % port_ % str(e))

  ser.flushInput()
  socks.append(ser)
  return ser


def configure_receiver(port):
    receiver_config = rospy.get_param('~configuration', None)
    onboard_filename_dft=time.strftime("%Y%m%d_%H%M%S")+".bin"
    onboard_filename = rospy.get_param('~onboard_filename', onboard_filename_dft)
    imu_type = rospy.get_param('~imu_type', 'ADIS16488')

    if type(port) != type(serial.Serial()):
      put = port.send
    else:
      put = port.write

    imu_connect = None
    put('UNLOGALL\r\n')

    if receiver_config is not None:
        imu_connect = receiver_config.get('imu_connect', None)
        if imu_connect is not None:
            rospy.loginfo("Sending IMU connection string to SPAN system.")
            put('connectimu ' + imu_connect['port'] + ' ' + imu_connect['type'] + '\r\n')

        logger = receiver_config.get('log_request', [])
        rospy.loginfo("Enabling %i log outputs from SPAN system." % len(logger))
        for log in logger:
            put('log ' + log+' '+ str(logger[log]) + '\r\n')
            rospy.logerr('log ' + log +' '+ str(logger[log]))
            time.sleep(0.2)

        #commands = receiver_config.get('command', [])
        #rospy.loginfo("Sending %i user-specified initialization commands to SPAN system." % len(commands))
        #for cmd in commands:
        #    put(cmd + ' ' + str(commands[cmd]) + '\r\n')
    pp_log = receiver_config.get('postprocess_log', [])
 
    for log in pp_log:
    #    if imu_type == "ADIS16488":
        put('LOG FILE  ' + log + ' ' + pp_log[log] + '\r\n')
        rospy.logerr('ONBOARD_LOGS: LOG FILE  ' + log + ' ' + pp_log[log])
        time.sleep(0.2)

    #if imu_type == "ADIS16488":
    put('LOGFILE OPEN' + ' ' + onboard_filename + '\r\n')
    rospy.logerr("Logging to onboard storage. Filename: %s", onboard_filename)

    time.sleep(0.5)

    login_commands = receiver_config.get('login_commands', [])
    for cmd in login_commands:
      put(login_commands[cmd]+"\r\n")
      time.sleep(0.2)


def enable_trigger(port):
    if type(port) != type(serial.Serial()):
      put = port.send
    else:
      put = port.write

    put("EVENTOUTCONTROL MARK2 ENABLE POSITIVE 999999990 10\r\n")


def shutdown():
    receiver_config = rospy.get_param('~configuration', None)
    logout_commands = receiver_config.get('logout_commands', [])

    monitor.finish.set()
    monitor.join()
    rospy.loginfo("Thread monitor finished.")
    for name, port in ports.items():
      port.finish.set()
      port.join()
      port.close_file()
      rospy.loginfo("Port %s thread finished." % name)
    for sock in socks:
      if type(sock) != type(serial.Serial()):
        for cmd in logout_commands:
          sock.send(logout_commands[cmd]+"\r\n")
          time.sleep(0.5)
        #sock.send("UNLOGALL\r\n")
        sock.shutdown(socket.SHUT_RDWR)
      else:
        for cmd in logout_commands:
          sock.write(logout_commands[cmd]+"\r\n")
          time.sleep(0.5)
        #sock.write("UNLOGALL\r\n")

      sock.close()

    rospy.loginfo("Sockets closed.")
