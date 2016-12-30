#!/bin/sh

rm userlist

wget ftp://cq01-sf-chgrd00.cq01.baidu.com:/home/work/chudawei/select_bd_user/userlist

echo "check onoroffline"

awk 'BEGIN{
	FS=OFS="\t";
	while(getline<"userlist">0) 
	{
		dict[$1]=0;
	}
	in_dump=0;
}
{
	if($1==9 && $4=="BM_BEGIN" && $5==40)
	{
		in_dump=1;
		print "in_dump true";
		next;
	} 

	if($1==9 && $4=="BM_END" && $5==40)
	{
		in_dump=0;
		print "in_dump false";
		next;
	}

	if($1==40 && !in_dump && ($4 in dict))
	{
		if ($4 in dict)
		{
			print $0, strftime("%Y-%m-%d %H:%M:%S",$2);
		}
	}

}' /home/work/var/bcmain/20131127/outputflow.20131127-13*.log

