#!/bin/sh

BEGIN_DATE="20130407"
END_DATE="20130407"

BEGIN="${BEGIN_DATE:0:4}-${BEGIN_DATE:4:2}-${BEGIN_DATE:6:2} 10:00:00"
END="${END_DATE:0:4}-${END_DATE:4:2}-${END_DATE:6:2} 10:29:59"
STEP="$((900))"
FORMAT="%Y%m%d-%H%M"

cur_s=$(date -d" ${BEGIN}" +"%s")
end_s=$(date -d" ${END}" +"%s")

INPUT_LIST=""

while [ "${cur_s}" -lt "${end_s}" ]
do
	cur=$(date -d" 00:00:00 1970-01-01 UTC +${cur_s} sec " +"${FORMAT}")
	echo ${cur}
	sh stat.sh -m cq -t ${cur}
	sh stat.sh -m st -t ${cur}
	day=${cur:0:8}
	cur_s=$((cur_s + STEP))
done

echo ${DATE}

