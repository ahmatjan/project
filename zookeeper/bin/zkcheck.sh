#! /bin/bash
ROS_DIR=/home/caros

all_zk="`ps -ef | grep zookeeper | grep -v grep |grep -v zkcheck|wc -l`"
if [[ $all_zk -eq 0 ]] 
then
  echo "sleep 10"
  sleep 10
fi

for server in server0 server1 server2
do
 count="`ps -ef | grep zookeeper.*$server | grep -v grep |wc -l`"
 if [[ $count -eq 0 ]] 
 then
   bash $ROS_DIR/ros/zookeeper/bin/zkServer.sh restart $ROS_DIR/ros/zookeeper/$server/conf/zoo.cfg &
  fi
done
