#!/bin/sh
#echo "test" | mail -s "[budget-server]`hostname` test" "yangkai04@baidu.com"
echo -e "hi,all:\n\n    ��Ҫ�뼦��!\n\n\n    лл\n    ��Ϊ" | mail -s "" "chudawei@baidu.com" -- -fchudawei@baidu.com
#cat mail.txt | mail -s "ʥ�����֣���������ͨ��˾/��Ʒ���²�/������" "yangck0410672@163.com" -- -fwangxiaoyuan@sgepri.sgcc.com.cn
#cat mail.txt | mail -s "ʥ�����֣���������ͨ��˾/��Ʒ���²�/������" "wangxiaoyuan@sgepri.sgcc.com.cn" -- -fyangck0410672@163.com
echo -e "hi,:\n\n    see attachment\n\n\nThanks\nYangKai" | mutt -a budget.tar.gz -s "budget offline" "yangkai04@baidu.com"
