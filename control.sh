#!/bin/sh

##############################################
# @file: control.sh
# @desc: Script for set ip, set ros_ip, set zk and start roscore
# @time: 2016-04-22
##############################################

### Set machine ip
set_ip() {
    # Get file and set variables
    INTERFACES=/etc/network/interfaces
    RESOLV=/etc/resolv.conf

    IP_MOD=192.168.10.13
    MASK_MOD=255.255.255.0
    GW_MOD=192.168.10.1
    DNS_MOD=192.168.10.1

    # Mod interfaces
    cp -r $INTERFACES ${INTERFACES}.bak
    echo -ne "auto eth0
    iface eth0 inet static
    address $IP_MOD
    netmask $MASK_MOD
    gateway $GW_MOD" > $INTERFACES

    # Mod resolv
    cp -r $RESOLV ${RESOLV}.bak
    echo -e "nameserver $DNS_MOD" > $RESOLV

    # Restart network
    ifdown eth0
    ifup eth0 -i $INTERFACES

    echo "Set ip ok..."
}

### Set ros ip
set_ros_ip() {
    # Get file and set variables
    BASHRC=/home/caros/.bashrc
    ROS_IP=192.168.10.13
    
    cp -r $BASHRC ${BASHRC}.bak
    echo -e "ROS_IP=$ROS_IP" >> $BASHRC
    source $BASHRC

    echo "Set ros ip ok..."
}

### Set zookeeper
set_zk() {
    # Get file and set variables
    ZK_DIR=/home/caros/ros/zookeeper

    source $ZK_DIR/bin/zkinit.sh
    source $ZK_DIR/bin/zkcheck.sh
    
    echo "Set zk ok..."
}

### Start roscore
start_roscore() {
    roscore &
    echo "Start roscore ok..."
}

### Main of script
echo "Set env start......"
set_ip
set_ros_ip
set_zk
start_roscore
echo "Set env end......"
