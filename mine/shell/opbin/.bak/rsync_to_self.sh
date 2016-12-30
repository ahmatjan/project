########################################
#
# logger  rsync 
#
########################################

#数据由机器A同步到机器B
#机器A上部署本脚本，建立机器B对机器A的信任关系
#机器A上执行：ssh-keygen -t rsa，一路回车后，将id_rsa.pub，拷贝到机器B上
#机器B上执行：cat id_rsa.pub >> .ssh/authorized_keys
#机器B上执行: chmod 600 authorized_keys
#机器A上登陆机器B: ssh B，可免密码登陆

# prepare

#scp ~/.ssh/id_rsa.pub work@${host[0]}:/home/work/
#ssh work@${host[0]} "cat /home/work/id_rsa.pub >> /home/work/.ssh/authorized_keys"
#ssh work@${host[0]} "rm /home/work/id_rsa.pub"

machines_0="st01-ecom-shifen03.st01 cq01-sf-anti03.cq01 "
src_var_log_0[0]="/home/work/var/integ/"
dst_var_log_0[0]="/home/work/var/integ_0/"

machines_1="st01-sf-chgq102.st01  cq01-dr-fnq100.cq01"
src_var_log_1[0]="/home/work/var/integ/"
dst_var_log_1[0]="/home/work/var/integ_1/"


cmd_head="rsync -av  --bwlimit=20480 "


for machine in $machines_0
do
      echo "====================  rsync $machine "
      idx=0
      looptimes=${#src_var_log_0[*]}
      while [ $idx -lt $looptimes ] 
      do
          cmd="$cmd_head $machine:${src_var_log_0[$idx]} ${dst_var_log_0[$idx]}" 
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


for machine in $machines_1
do
      echo "====================  rsync $machine "
      idx=0
      looptimes=${#src_var_log_1[*]}
      while [ $idx -lt $looptimes ] 
      do
          cmd="$cmd_head $machine:${src_var_log_1[$idx]} ${dst_var_log_1[$idx]}"
          echo "executing $cmd\n"
          eval $command
          if [ ! $? == 0 ];then
               echo "execute $cmd err"
               let idx++
               continue
          fi
          let idx++
      done
 
done

