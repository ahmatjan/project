#!/bin/sh
if [ -z "$1" ]
then
	echo "param error"
	exit 1
fi
ps -axu | grep $1 | grep -v "$0" | grep -v "grep"
cmd=`ps -aux | grep $1 |grep -v "$0" | grep -v "grep" | awk '{dict[$2]}END{str="kill ";for(item in dict) str=str" "item; print str;}'`
echo $cmd
`$cmd`
