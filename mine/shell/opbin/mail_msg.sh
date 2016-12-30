#!/bin/sh
#echo "test" | mail -s "[budget-server]`hostname` test" "yangkai04@baidu.com"
echo -e "hi,all:\n\n    我要请鸡翅!\n\n\n    谢谢\n    大为" | mail -s "" "chudawei@baidu.com" -- -fchudawei@baidu.com
#cat mail.txt | mail -s "圣诞快乐！——国电通公司/产品创新部/王晓媛" "yangck0410672@163.com" -- -fwangxiaoyuan@sgepri.sgcc.com.cn
#cat mail.txt | mail -s "圣诞快乐！——国电通公司/产品创新部/王晓媛" "wangxiaoyuan@sgepri.sgcc.com.cn" -- -fyangck0410672@163.com
echo -e "hi,:\n\n    see attachment\n\n\nThanks\nYangKai" | mutt -a budget.tar.gz -s "budget offline" "yangkai04@baidu.com"
