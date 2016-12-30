#!/bin/bash

##! @TODO: hadoop mapper
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com
##! @BRIEF: ͨ������query��term�ĵ��ű�Ȼ�����url_title���ݡ��ҳ�
##!         title�е����д�����query��ͳ��query���ִ��������query���ִ���
##!         ��query�еĴ�����ȣ���˵��query����title.

set -o pipefail

chmod a+x ./seg_basic

awk 'BEGIN \
{
    FS=OFS="\t";
}
{
    print $2,$1;
}' | ./seg_basic | awk 'BEGIN \
{
    FS=OFS="\t";
    # ��query set���ص��ڴ��У��������ű�query��queryidx��ʾ[0-N]
    #   term_querylist_dict: term -> query1,query2,...,queryN
    #   queryidx_termnum_dict: query -> termnum
    queryidx = 0;
    # query_set���ݸ�ʽ: query \t queryterms 
    while (getline < "query_set.txt" > 0)
    {
        termnum = split($2, termarray, ",");
        # ��Ϊ�дʺ�����и����ţ�����termidx < termnum
        # ��һ��query�е����йؼ��ʷŵ���ϣ����ȥ��
        for (termidx = 1; termidx < termnum; ++termidx)
        {
            tempdict[termarray[termidx]] = 0;
        }
        termnum = 0;
        for (term in tempdict)
        {
            add_term(term_querylist_dict, term, queryidx);
            termnum += 1;
        }
        queryidx_termnum_dict[queryidx] = termnum;
        queryidx += 1;
        delete tempdict;
    }
}
# ��term->query��ӵ����ű���
function add_term(l_term_querylist_dict, l_term, l_query)
{
    if (!(l_term in l_term_querylist_dict))
    {
        l_term_querylist_dict[l_term] = l_query;
    }
    else
    {
        l_term_querylist_dict[l_term] = l_term_querylist_dict[l_term]","l_query;
    }
}
function get_site(l_url)
{
    split(l_url, l_array, "/");
    return l_array[3];
}
{
    # �������ݸ�ʽ: title \t url \t titleterms 
    if (NF != 3)
    {
        next;
    }
    url = $2;
    titleterms = $3;
    termnum = split(titleterms, termarray, ",");
    # ��title�ִ�, ��һ��title�е����йؼ��ʷŵ���ϣ����ȥ��
    for (termidx = 1; termidx < termnum; ++termidx)
    {
        term = termarray[termidx];
        tempdict[term] = 0;
    }
    for (term in tempdict)
    {
        # ����term
        if (!(term in term_querylist_dict))
        {
            continue;
        }
        # ���term�ж�Ӧ��querylist����ȡ��
        querylist = term_querylist_dict[term];
        querynum = split(querylist, queryarray, ",");
        for (queryidx = 1; queryidx <= querynum; ++queryidx)
        {
            # ��term��Ӧ��query��Ϣͳ�Ƶ�match_query_termcnt_dict��
            query = queryarray[queryidx];
            if (!(query in match_query_termcnt_dict))
            {
                match_query_termcnt_dict[query] = 1;
            }
            else
            {
                match_query_termcnt_dict[query] = match_query_termcnt_dict[query] + 1;
            }
        }
    }
    site = get_site(url);
    match_query_cnt = 0;
    for (query in match_query_termcnt_dict)
    {
        if (!(query in queryidx_termnum_dict))
        {
            continue;
        }
        query_termcnt = queryidx_termnum_dict[query];
        match_query_termcnt = match_query_termcnt_dict[query];
        # ���query�дʵ�������ͳ�Ƶ�match_query_termcnt_dict������ȣ���˵��query��titleƥ��
        if (query_termcnt == match_query_termcnt)
        {
            match_query_cnt += 1;
        }
    }
    print site, match_query_cnt;
    delete match_query_termcnt_dict;
    delete tempdict;
}
END \
{
}'

if [ $? -ne 0 ]
then
    RET_VALUE=$?
    echo -e "FATAL: $0 run error." >> "/dev/stderr"
    exit ${RET_VALUE}
fi
