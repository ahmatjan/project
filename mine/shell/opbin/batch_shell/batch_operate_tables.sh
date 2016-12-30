:> tables.log

#select count tables
/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -Dbgtserver_dashboard -N -e"select concat('select count(*) from ', table_name, ';') from information_schema.tables where table_name like 'add_status_%'" | while read line

#test
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"select concat('select reason, count(*) from ', table_name, ' group by reason;') from information_schema.tables where table_name like 'add_status%_action_%';" | while read line

#show tables
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"select concat(table_name) from information_schema.tables where table_name like 'add_status_%'" | while read line
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"select concat(table_name),TABLE_SCHEMA from information_schema.tables where table_name like 'action_20%'" | while read line
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -Dfcdashboard -N -e"select concat(table_name) from information_schema.tables where table_name like '%'" | while read line
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -N -e"use fcdashboard;show tables;" | while read line

#drop tables
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -Dbgtserver_dashboard -N -e"select concat('drop table ', table_name, ';') from information_schema.tables where table_name like 'add_status_%';" | while read line
#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -Dbgtserver_dashboard -N -e"select concat('drop table ', table_name, ';') from information_schema.tables where table_name like 'action_20%';" | while read line
do
	echo ${line} >> tables.log
	echo "${line}"
	#/home/work/local/mysql/bin/mysql -h10.50.77.12 -P6606 -ufcwrite -p123456 -Dfcdashboard -N -e"${line}"
done

