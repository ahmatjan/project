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
    sendmail "subject" "./testfile" "key value" "20150101"
}

sendmail()
{
    local fn_SUBJECT=$1
    local fn_FILE=$2
    local fn_COLNAMES=$3
    local fn_DATE=$4
    local fn_TO="yangkai04@baidu.com"
    local fn_FROM="yangkai04@baidu.com"
    local fn_CC="yangkai04@baidu.com,yangkai04@baidu.com"
    :>${FUNCTION}.temp
    cat ${fn_FILE} | while read -r line
    do
        key=`echo "${line}" | cut -f 1`
        value=`echo "${line}" | cut -f 2`
        echo "<tr><td class=bold>$key</td><td class=bold>$value</td></tr>" >> ${FUNCTION}.temp
    done < ${fn_FILE}
    local fn_MAIL_CONTENT=`cat ${FUNCTION}.temp`
    rm -f ${FUNCTION}.temp
    local fn_COLNAME_CONTENT=""
    for COLNAME in ${fn_COLNAMES}
    do
        fn_COLNAME_CONTENT="${fn_COLNAME_CONTENT}<th>${COLNAME}</th>"
    done
    fn_SUBJECT="${fn_SUBJECT}【${fn_DATE}】"
    local fn_MESSAGE="
    <html>
        <head>
            <meta http-equiv='Content-Type' content='text/html; charset=gb2312'/>
            <title>${fn_SUBJECT}</title>
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
                <!--    width: 50%;-->
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
        <div id='name' align='center'><strong><SPAN lang='EN-US'><font face='微软雅黑, 宋体' size='4'>${fn_SUBJECT}</font></SPAN></strong></div>
            <table width='90%'>
                <thead>
                    <tr>
                    ${fn_COLNAME_CONTENT}
                    </tr>
                </thead>
                <tbody>
                ${fn_MAIL_CONTENT}
                </tbody>
            </table>

            <br />
            <hr />
            以上邮件内容如有疑问请直接回复邮件
            <br />
            <span class='gray'>From: 一站式计费团队 yangkai</span>
        </body>
    </html>"
    echo "${fn_MESSAGE}" | mail -c "${fn_CC}" -s"$(echo -e "${fn_SUBJECT}\nContent-Type:text/html")" "${fn_TO}" -- -f "${fn_FROM}"
    echo 'sendmail ok.'
}

#########################################
#--------------- Main ------------------#
#########################################

yesterday=`date --date='1 days ago' +%Y%m%d`
result=""
work_dir='./'

main
exit
