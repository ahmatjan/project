#!/bin/sh
i=0
while((i!=5))
do
    sleep 3
    echo "$1"
    ((i++))
done
