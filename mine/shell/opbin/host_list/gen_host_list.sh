#!/bin/sh

awk 'BEGIN{
	print "i=0\n";
	hostinfo=0;
}
{
	if(0==NF)
	{
		next;
	}
	#if (0 != match($0,"#[hostinfo]"))
	if ($0 == "#[hostinfo]")
	{
		hostinfo=1;
		next;
	}
	if (!hostinfo)
	{
		next;
	}
	if (0 != match($0, "#.*"))
	{
        #print $0;
		next;
	}
	gsub("@"," ",$0);
	gsub("'\''"," ",$0);
    key = $4" "$5;
    if (key in dict)
    {
        next;
    }
	print "host[$i]="$5;
	print "user[$i]="$4;
	print "((i++))"
	print ""
    dict[key] = 0;
}
' ~/.bashrc > host_list.sh
