:> tables.log

database="budget_dashboard"
table_prefix="add_data"
database="fcdashboard"
table_prefix="sivachg"
table_prefix="sivaign"
table_prefix="clksivaignbyminutes"
database="bgtserver_dashboard"
table_prefix="add_status_sivabudget_cq_action_"
table_prefix="add_status_sivabudget_st_action_"
table_prefix="add_status_sivabudget"
database="budget_dashboard"
table_prefix="siva_budget_action"
table_prefix="siva_budget"
database="basedata_dashboard"
table_prefix="add_delta"

#drop tables
/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -D${database} -N -e"select concat('drop table ', table_name, ';') from information_schema.tables where table_name like '${table_prefix}_%';" | while read line
do
	echo "${line}"
	#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -D${database} -N -e"${line}"
done

