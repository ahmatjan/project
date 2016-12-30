#!/bin/sh
echo -e "date\tuserid\tclicknum\tcharge\tcash">"result.txt"

hadoop fs -cat /app/ecom/remora/yangkai/test/* | sort -k1,1 >> "result.txt"
