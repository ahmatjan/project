#!/bin/bash

set -x

MYSQL_PATH="/home/work/local/mysql/bin/mysql -h10.99.60.36 -P6606 -ufcwrite -p123456 -N"
DATABASE="db_name"
TABLENAME="table_name"

SQL_CREATE_DB="DROP DATABASE IF EXISTS ${DATABASE}; CREATE DATABASE ${DATABASE};"
${MYSQL_PATH} -e"${SQL_CREATE_DB}"

SQL_CREATE_TABLE="DROP TABLE IF EXISTS ${TABLENAME}; CREATE TABLE IF NOT EXISTS ${TABLENAME} (date date NOT NULL default '0000-00-00', app_v char(20) not null, tag_v char(20) not null, value_v int(11) not null default 0, PRIMARY KEY (date, app_v, tag_v)) TYPE=MyISAM;"
#SQL_CREATE_TABLE="DROP TABLE IF EXISTS ${TABLENAME}; CREATE TABLE IF NOT EXISTS ${TABLENAME} (${create_colum_sql}) TYPE=MyISAM;"
${MYSQL_PATH} -D${DATABASE} -e"${SQL_CREATE_TABLE}"

SQL_LOAD_DATA="LOAD DATA INFILE '`pwd`/${RESULT_FINAL}' INTO TABLE ${TABLENAME};"
#${MYSQL_PATH} -D${DATABASE} -e"${SQL_LOAD_DATA}"

DAY="2014-12-31"
keys="date, app_v, tag_v, value_v"
values="\"${DAY}\", \"app_name\", \"tag_name\", 20"
SQL_INSERT_DATA="DELETE FROM ${TABLENAME} WHERE date="${DAY}";INSERT INTO ${TABLENAME} ("${keys}") VALUES ("${values}")"
${MYSQL_PATH} -D${DATABASE} -e"${SQL_INSERT_DATA}"

SQL_SELECT_DATA="SELECT * FROM ${TABLENAME}"
${MYSQL_PATH} -D${DATABASE} -e"${SQL_SELECT_DATA}"
${MYSQL_PATH} -D${DATABASE} -e"${SQL_SELECT_DATA}" > temp
cat temp
rm -f temp
