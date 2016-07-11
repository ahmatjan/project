#! /bin/bash
ROS_DIR=/home/caros
for server in server0 server1 server2
do
   rm $ROS_DIR/ros/zookeeper/$server/data/version-2/snapshot.* >/dev/null 2>&1
   rm $ROS_DIR/ros/zookeeper/$server/data/version-2/log.* >/dev/null 2>&1
done

for server in server0 server1 server2
do
   count="`ps -ef | grep zookeeper.*$server | grep -v grep |wc -l`"
   if [[ $count -eq 0 ]] 
   then
       bash $ROS_DIR/ros/zookeeper/bin/zkServer.sh start $ROS_DIR/ros/zookeeper/$server/conf/zoo.cfg &
   fi
done

service cron start
