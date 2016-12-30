#!/bin/bash
set -x

echo "" | awk 'BEGIN \
{
    FS = OFS = "\t";
}
function str_add_byorder(l_str1, l_str2)
{
    l_fields_cnt1 = split(l_str1, l_str1_array, "\t");
    l_fields_cnt2 = split(l_str2, l_str2_array, "\t");
    l_res_str = l_str2_array[1];
    for (l_idx = 2; l_idx <= l_fields_cnt1; ++l_idx)
    {
        l_field1 = l_str1_array[l_idx];
        gsub(":", "=", l_field1);
        split(l_field1, l_field1_array, "=");
        l_field2 = l_str2_array[l_idx];
        gsub(":", "=", l_field2);
        split(l_field2, l_field2_array, "=");
        l_value = l_field1_array[2] + l_field2_array[2];
        l_res_str = l_res_str"\t"l_field1_array[1]"="l_value;
    }
    return l_res_str;
}
function str_add_byname(l_str1, l_str2)
{
    l_fields_cnt1 = split(l_str1, l_str1_array, "\t");
    l_fields_cnt2 = split(l_str2, l_str2_array, "\t");
    l_res_str = l_str2_array[1];
    for (l_idx = 2; l_idx <= l_fields_cnt1; ++l_idx)
    {
        l_field1 = l_str1_array[l_idx];
        gsub(":", "=", l_field1);
        split(l_field1, l_field1_array, "=");
        l_key = l_field1_array[1];
        l_value = l_field1_array[2];
        if (l_key in l_dict)
        {
            l_dict[l_key] = l_dict[l_key] + l_value;
        }
        else
        {
            l_dict[l_key] = l_value;
        }
    }
    for (l_idx = 2; l_idx <= l_fields_cnt2; ++l_idx)
    {
        l_field2 = l_str2_array[l_idx];
        gsub(":", "=", l_field2);
        split(l_field2, l_field2_array, "=");
        l_key = l_field2_array[1];
        l_value = l_field2_array[2];
        if (l_key in l_dict)
        {
            l_dict[l_key] = l_dict[l_key] + l_value;
        }
        else
        {
            l_dict[l_key] = l_value;
        }
    }
    for (l_key in l_dict)
    {
        l_res_str = l_res_str"\t"l_key"="l_dict[l_key];
    }
    delete l_dict;

    return l_res_str;
}

function str_add_byfieldname(l_str, l_fieldname, l_fieldvalue)
{
    l_fields_cnt = split(l_str, l_fields_array, "\t");
    l_res_str = l_fields_array[1];
    for (l_idx = 2; l_idx <= l_fields_cnt; ++l_idx)
    {
        split(l_fields_array[l_idx], l_field_array, "=");
        l_key = l_field_array[1];
        l_value = l_field_array[2];
        l_dict[l_key] = l_value;
    }
    if (l_fieldname in l_dict)
    {
        l_dict[l_fieldname] += l_fieldvalue;
    }
    for (l_key in l_dict)
    {
        l_res_str = l_res_str"\t"l_key"="l_dict[l_key];
    }
    delete l_dict;

    return l_res_str;
}

function test_format_double()
{
    x = 10;
    str1 = x / 3;
    str2 = sprintf("%0.2f", x / 3);
    print str1;
    print str2;
}

{
    test_format_double();
    str1 = "20141230-0000\tkey1=100\tkey2=200\tkey3=300\tkey4=400";
    str2 = "20141230-0000\tkey1=10\tkey2=20\tkey3=30";
    print str_add_byorder(str1, str2);
    print str_add_byname(str1, str2);
    str1 = "20141230-0000\tkey1=100\tkey2=200\tkey3=300\tkey4=400";
    str2 = "20141230-0000\tkey11=10\tkey12=20\tkey13=30";
    print str_add_byorder(str1, str2);
    print str_add_byname(str1, str2);
    print str_add_byfieldname(str2, "key13", 111);
}
END \
{
}'
