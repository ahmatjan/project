#!/bin/bash


machines="cq01-sf-vchgrd00.vm"
src_var_log[0]="/home/yangkai04"
dst_var_log[0]="/home/work/yangkai/machine"
cmd_head="rsync -av  --bwlimit=20480 "

for machine in $machines
do
      echo "====================  rsync $machine "
      idx=0
      looptimes=${#src_var_log[*]}
      while [ $idx -lt $looptimes ] 
      do
          machine_name=$(echo "$machine" | awk -F"\." '{print $1}')
          local_path="${dst_var_log[$idx]}"
          local_path="${local_path%/}/$machine_name"
          if [ ! -e $local_path ];then
                  mkdir -p $local_path
          fi
          cmd="$cmd_head yangkai04@$machine:${src_var_log[$idx]} $local_path "
          echo "executing $cmd\n"
          eval $cmd
          if [ ! $? == 0 ];then
               echo "execute $cmd err"
               let idx++
               continue
          fi
          let idx++
      done
 
done
exit 0
