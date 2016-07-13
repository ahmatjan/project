#! /usr/bin/env python
# -*- coding: utf-8 -*-

# Software License Agreement (BSD)
#
#  file      @publisher.py
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

import rospy
import diagnostic_updater

from diagnostic_msgs.msg import DiagnosticStatus
from novatel_msgs.msg import BESTPOS
from novatel_msgs.msg import INSPVAX
from novatel_msgs.msg import LOGFILESTATUS
from novatel_msgs.msg import CommonHeader

class NovatelDiagnostics(object):
    def __init__(self):
        self.last_bestpos = None
        self.last_inspvax = None
        rospy.Subscriber("dusensor/novatel/bestpos", BESTPOS, self.bestpos_callback)
        rospy.Subscriber("dusensor/novatel/inspvax", INSPVAX, self.inspvax_callback)
        rospy.Subscriber("novatel_data/logfilestatus", LOGFILESTATUS, self.logfilestatus_callback)        

        self.updater = diagnostic_updater.Updater()
        self.updater.setHardwareID("none")
        self.updater.add("Novatel SPAN", self.produce_diagnostics)

    def logfilestatus_callback(self, msg):
        """log file status : media_capacity"""
        media_free_space = msg.media_free_space
        media_capacity = msg.media_capacity
        if media_free_space > (0.8 * media_capacity):
            rospy.logwarn("STORAGE_STATUS: media_free_space > 80%%  %d", media_free_space)
        elif media_free_space < (0.5 * media_capacity):
            rospy.logerr("STORAGE_STATUS: media_free_space < 50%% %d", media_free_space)   

    def bestpos_callback(self, msg):

        header=msg.header
        cpu_idle=(header.idle_time)/2.0
        receiver_status=header.receiver_status
        svs=msg.svs
        time_status = header.time_status
        sol_svs=msg.sol_svs
        if time_status != 180:
            GPS_REFERRENCE_TIME_STATUS = {20: "UNKNOWN", 60: "APPROXIMATE", 80: "COARSEADJUSTING", \
            100: "COARSE", 120: "COARSESTEERING", 130: "FREEWHEELING", \
            140: "FINEADJUSTING", 160: "FINE", 170: "FINEBACKUPSTEERING", \
            180: "FINESTEERING", 200: "SATTIME"} 
            time_status_str = GPS_REFERRENCE_TIME_STATUS.get(time_status)
            if time_status_str is not None:
                rospy.logwarn("GPS_REFERRENCE_TIME_STATUS: %s", time_status_str)

        if receiver_status is not None:
            rospy.logerr("RECEIVER_STATUS: CURRENT_STATUS: %d",receiver_status)

            if receiver_status&32==32 or receiver_status&64==64:
                rospy.logerr("RECEIVER_STATUS: ANTENNA PROBLEM")
            elif receiver_status&128==128:
                rospy.logerr("RECEIVER_STATUS: CPU_OVERLOAD")
    
            if cpu_idle<40:
                rospy.logwarn("CPU_IDLE < 40\tCURRENT_CPU_IDLE:%d",cpu_idle)
            elif cpu_idle<10:
                rospy.logerr("CPU_IDLE < 10\tCURRENT_CPU_IDLE:%d",cpu_idle)


        if msg.solution_status==1:
            rospy.logerr("SOLUTION_STATUS: INSUFFICIENT_OBSERVATIONS")

        if svs<5 or msg.solution_status==1:
            rospy.logerr("SATELLITE_STATUS:\tTRACKED:%d\tUSED:%d",svs,sol_svs)

        self.last_bestpos = msg
        #self.updater.setHardwareID("firmware-%d" % msg.header.software_version)
        #self.updater.update()

    def inspvax_callback(self, msg):
        ins_status=msg.ins_status

        if ins_status==7:
            if (msg.header.gps_week_milliseconds/1000)%10==0:
                rospy.loginfo("INS_STATUS: ALIGNMENT_COMPELETE")
            return
        if ins_status==3:
            if (msg.header.gps_week_milliseconds/1000)%10==0:
                rospy.loginfo("INS_STATUS: INS_SOLUTION_GOOD")
            return
        elif ins_status==1:
            rospy.logwarn("INS_STATUS: ALIGNING")
        elif ins_status==0:
            rospy.logerr("INS_STATUS: INACTIVE")
        elif ins_status==6:
            rospy.logwarn("INS_STATUS: SOLUTION_FREE")
        else:
            rospy.logwarn("INS_STATUS: %d",ins_status)            

        if msg.latitude_std > 1.0 or  msg.longitude_std > 1.0 or msg.altitude_std > 1.0:
            rospy.logerr("POSITION STD TOO BIG! lat:%.2f\tlon:%.2f\thgt:%.2f", \
            msg.latitude_std, msg.longitude_std, msg.altitude_std)
        if msg.north_velocity_std > 1.0 or msg.east_velocity_std > 1.0 or msg.up_velocity_std > 1.0:
            rospy.logerr("VELOCITY STD TOO BIG! north:%.2f\teast:%.2f\tup:%.2f", \
            msg.north_velocity_std, msg.east_velocity_std, msg.up_velocity_std)
        if  msg.roll_std > 1.0 or msg.pitch_std > 1.0 or msg.azimuth_std > 1.0:
            rospy.logerr("ATTITUDE STD TOO BIG! roll:%.2f\tpitch:%.2f\tyaw:%.2f", \
            msg.roll_std, msg.pitch_std, msg.azimuth_std)
        self.last_inspvax = msg
        #self.updater.update()


    @staticmethod
    def get_status_string(msg, field):
        value = getattr(msg, field)
        matching_status = [x[len(field) + 1:] for x in dir(msg) if x.startswith(field.upper()) and
                           value == getattr(msg, x)]
        if len(matching_status) != 1:
            return "No matching constant"
        return matching_status[0]

    @staticmethod
    def get_status_bitfield(msg, field):
        value = getattr(msg, field)
        matching_statuses = [x[len(field) + 1:] for x in dir(msg) if x.startswith(field.upper()) and
                             value & getattr(msg, x)]
        return ', '.join(matching_statuses)

    def produce_diagnostics(self, stat):
        rospy.logerr("produce_diagnostics")
        if self.last_bestpos:
            stat.add("GNSS Solution Status",
                     self.get_status_string(self.last_bestpos, "solution_status"))
            stat.add("GNSS Position Type",
                     self.get_status_string(self.last_bestpos, "position_type"))
            self.last_bestpos = None

        if self.last_inspvax:
            if self.last_inspvax.ins_status != INSPVAX.INS_STATUS_SOLUTION_GOOD:
                stat.summary(DiagnosticStatus.WARN, "INS Solution not GOOD.")
            elif self.last_inspvax.position_type != INSPVAX.POSITION_TYPE_PPP:
                stat.summary(DiagnosticStatus.WARN, "INS Position type not PPP.")
            else:
                stat.summary(DiagnosticStatus.OK, "INS Solution GOOD, PPP fix present.")

            stat.add("INS Solution Status",
                     self.get_status_string(self.last_inspvax, "ins_status"))
            stat.add("INS Position Type",
                     self.get_status_string(self.last_inspvax, "position_type"))
            stat.add("INS Extended Status",
                     self.get_status_bitfield(self.last_inspvax, "extended_status"))
            stat.add("Seconds since last ZUPT or position update.",
                     self.last_inspvax.seconds_since_update)
            stat.add("Receiver Status",
                     self.get_status_bitfield(self.last_inspvax.header, "receiver_status"))
            self.last_inspvax = None
        else:
            stat.summary(diagnostic_msgs.msg.DiagnosticStatus.ERROR,
                         "No INSPVAX logs received from Novatel system.")

        return stat
