#!/bin/bash

#########################################
# 邮件所有服务pv、响应时间
#
# Auth: hezhibin@baidu.com
# Date: 2013-04-22
#
######################################### 
main()
{
	filetc	
	sendmail
}

filetc()
{
	iconv -f utf8 -t gbk "${work_dir}/pv.$yesterday" > "${work_dir}/tcfile"
	while read line
	do
		key=`echo $line|cut -d ":" -f 1`
		value=`echo $line|cut -d ":" -f 2`
		row=" 
            <tr>
                <td class=bold>$key</td>
                <td class=bold>$value</td>
            </tr>"
		echo "$row" >> "${work_dir}/tmpfile"
	done <"${work_dir}/tcfile"
	result=`cat ${work_dir}/tmpfile`
	rm "${work_dir}/tmpfile"
	rm "${work_dir}/tcfile"
}

sendmail()
{
	subject="后端服务pv监控【`date --date='1 days ago' +%Y-%m-%d`】"
	message="
	<html>
		<head>
			<meta http-equiv='Content-Type' content='text/html; charset=gb2312'/>
			<title>${subject}</title>
			<style>
                body {
                    font-family: '宋体','Arial';
                    font-size: 12px;
                    text-align: center
                }
				table{
					border-collapse: collapse;
					border: 1px solid #000000;
				}
				td,th{
				<!--	width: 50%;-->
					border-collapse: collapse;
					border: 1px solid #000000;
				}
				th {
					font-family:Microsoft YaHei;
					font-size:11pt;
					padding:0px;
					background: blue;
				}
				td {
					font-family:Microsoft YaHei;
					font-size:11pt;
					padding:0px;
					background: lightcyan;
				}
				.red {
					color: red;
				}
				.blue {
					color: blue;
				}
				.bold {
					font-weight: bold;
				}
				.gray {
					color: '#999';
				}
			</style>
		</head>
		<body>
        <div id='name' align='center'><strong><SPAN lang='EN-US'><font face='微软雅黑, 宋体' size='4'>user上下线信息汇总</font></SPAN></strong></div>
			<table width='90%'>
				<thead>
					<tr>
						<th>服务</th>
						<th>总数</th>
					</tr>
				</thead>
				<tbody>
				${result}
				</tbody>
			</table>

			<br />
			<hr />
			以上邮件内容如有疑问请直接回复邮件
			<br />
			<span class='gray'>From: 后端测试组 hezhibin</span>
		</body>
	</html>"
	cc_tmp=''
	for c in ${cc[@]}	
	do
		cc_tmp="${cc_tmp} ${c}"
	done
	echo "${message}" | mail -c "${cc_tmp}" -s"$(echo -e "${subject}\nContent-Type:text/html")" "${to}" -- -f "${from}"
	echo 'sendmail ok.'
}

#########################################
#--------------- Main ------------------#
#########################################
from="yangkai04@baidu.com"
to="yangkai04@baidu.com"
cc=(yangkai04@baidu.com yangkai04@baidu.com )

yesterday=`date --date='1 days ago' +%Y%m%d`
result=""
work_dir='./'

main
exit
