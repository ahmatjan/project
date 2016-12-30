#!/bin/bash

exec 2>&-
SERVER=http://cq01-testing-ps70245.vm.baidu.com:8080/coverage/bashcheck
if [ $# -eq 0 ]; then
  echo "build date: 2014.2.28"
  echo "./bashcheck.sh [-a] <dir>"
  exit 0
elif [ "x$1" == "x-a" ]; then
  ALL=".all"
  FPATH="$2"
else
  ALL=""
  FPATH="$1"
fi
ID=`find "$FPATH" -name "*.sh" | tar -T - -czf - | curl -F file=@-  $SERVER/upload.php`

if [[ ${ID} =~ ^[0-9]+$ ]];then  
  echo -n "[bashcheck] checking "
  while :
  do
    RESULT=`curl $SERVER/get.php?id=$ID`
    if [[ $RESULT == "wait" ]]; then
       echo -n " . "
       sleep 1
    elif [[ $RESULT == "succ" ]]; then
       echo "succ"
       curl "$SERVER/result/$ID$ALL.txt"
       if [ $? -ne 0 ]; then
          echo "server fail!"
       fi
       break
    else
       echo "fail"
       echo "$RESULT"
       break
    fi
  done
else
  echo "[bashcheck] fail"
fi
