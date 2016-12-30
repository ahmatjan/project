#!/bin/sh

INPUT_FILES="/home/work/yangkai/stastic-20120118/20111001/????/*/dcharge.bd.20111001-????.log"

awk '
BEGIN{
	FS=OFS="\t";
}
{
	split($14,array," ");
	key=array[1]"\t"$4;
	dict1[key]+=$9;
	dict2[key]+=$9*$10;
	dict3[key]++;
}
END{
	for(a in dict1)
	{
		print a,dict3[a],dict1[a],dict2[a];
	}
}
' ${INPUT_FILES} | sort -k1,1 > "result.single.txt"
