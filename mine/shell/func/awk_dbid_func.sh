#!/bin/bash
set -x

echo "" | awk 'BEGIN \
{
    FS = OFS = "\t";
}
function get_dbid_5858(l_userid) {
    l_userid1 = l_userid;
    l_userid2 = l_userid;
    return or(rshift(and(l_userid1,768),6),and(l_userid2,3));
}
function get_dbid_5959(l_userid) {
    return and(rshift(l_userid, 10), 15);
}

{
    print get_dbid_5858(1900);
    print get_dbid_5959(1900);
}
END \
{
}'
