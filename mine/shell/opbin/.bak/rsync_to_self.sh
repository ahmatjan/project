########################################
#
# logger  rsync 
#
########################################

#�����ɻ���Aͬ��������B
#����A�ϲ��𱾽ű�����������B�Ի���A�����ι�ϵ
#����A��ִ�У�ssh-keygen -t rsa��һ·�س��󣬽�id_rsa.pub������������B��
#����B��ִ�У�cat id_rsa.pub >> .ssh/authorized_keys
#����B��ִ��: chmod 600 authorized_keys
#����A�ϵ�½����B: ssh B�����������½

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

