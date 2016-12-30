#!/bin/bash

##! @TODO: hadoop mapper
##! @VERSION: 1.0.0.0
##! @AUTHOR: yangkai04@baidu.com
##! @BRIEF: 通过建立query中term的倒排表，然后遍历url_title数据。找出
##!         title中的所有词所在query，统计query出现次数。如果query出现次数
##!         与query中的词数相等，则说明query命中title.

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
    # 将query set加载到内存中，建立倒排表，query用queryidx表示[0-N]
    #   term_querylist_dict: term -> query1,query2,...,queryN
    #   queryidx_termnum_dict: query -> termnum
    queryidx = 0;
    # query_set数据格式: query \t queryterms 
    while (getline < "query_set.txt" > 0)
    {
        termnum = split($2, termarray, ",");
        # 因为切词后最后有个逗号，所以termidx < termnum
        # 将一个query中的所有关键词放到哈希表中去重
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
# 将term->query添加到倒排表中
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
    # 输入数据格式: title \t url \t titleterms 
    if (NF != 3)
    {
        next;
    }
    url = $2;
    titleterms = $3;
    termnum = split(titleterms, termarray, ",");
    # 将title分词, 将一个title中的所有关键词放到哈希表中去重
    for (termidx = 1; termidx < termnum; ++termidx)
    {
        term = termarray[termidx];
        tempdict[term] = 0;
    }
    for (term in tempdict)
    {
        # 遍历term
        if (!(term in term_querylist_dict))
        {
            continue;
        }
        # 如果term有对应的querylist，则取出
        querylist = term_querylist_dict[term];
        querynum = split(querylist, queryarray, ",");
        for (queryidx = 1; queryidx <= querynum; ++queryidx)
        {
            # 将term对应的query信息统计到match_query_termcnt_dict中
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
        # 如果query中词的总数和统计的match_query_termcnt_dict的数相等，则说明query与title匹配
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
