#!/bin/bash

old_str='/home/caros/ros'
new_str="$PWD"

sed -i "s#$old_str#$new_str#g" `grep -R $old_str . | grep cmake | awk -F':' '{print $1}'` 2>/dev/null

# ignore errors in sed for binary file
exit 0
