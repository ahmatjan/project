# -*- coding: utf-8 -*-

import sys

import mysql.connector

class db_base:
    def __init__(self):
        self.host = ""
        self.port = ""
        self.user = ""
        self.passwd = ""
        self.database = ""

class table_op:
    def __init__(self):
        self.tablename = ""
        self.type = ""
        self.build_sql = ""
        self.insert_sql = ""
        self.update_sql = ""
        self.delete_sql = ""
        self.select_sql = ""

def fill_sql(sql, params):
    for (k,v) in params.items():
        k = '@'+k
        sql = sql.replace(k, str(v))
    return sql
    
"""
    类名: db_operator
    作用: 数据库操作类，包括连接数据库
    创建table,批量插入数据，删除数据
"""
class db_operator:
    def __init__(self, db_base):
        self.db_base = db_base
        #批量插入的数目
        self.insert_rowcount = -1
        self.delete_rowcount = -1
        self.update_roucount = -1
        
    def connect_to(self):
        try:
            self.db = mysql.connector.Connect(host=self.db_base.host, port=self.db_base.port,\
                                              user=self.db_base.user, password=self.db_base.passwd,\
                                              database=self.db_base.database)
        except mysql.connector.errors.InterfaceError as e:
            return -1
        self.cursor = self.db.cursor()
        return 0
    def db_ping(self, reconnect=True, attempts=1, delay=0):
        try:
            self.db.ping(reconnect=True, attempts=1, delay=0)
        except mysql.connector.Error as err:
            print mysql.connector.Error, err
            return -1
        return 0

    def create_table(self, create_sql, param):            
        full_create_sql = fill_sql(create_sql, param)       
        try:
            self.cursor.execute(full_create_sql)
            self.db.commit()
        except mysql.connector.Error as err:
            print mysql.connector.Error, err
            return -1
        return 0

    #忽略IntegrityError Duplicate entry
    def insert_sql(self, insert_sql, param, values):
        if len(values) <= 0:
            return 0
        full_insert_sql = fill_sql(insert_sql, param)
        try:
            self.cursor.executemany(full_insert_sql, values)
            self.db.commit()
        except mysql.connector.errors.IntegrityError as err:
            print mysql.connector.errors.IntegrityError, err
            self.insert_rowcount = self.cursor.rowcount
            return 0
        except mysql.connector.Error as err:
            self.insert_rowcount = self.cursor.rowcount    
            print mysql.connector.Error, err
            return -1
        self.insert_rowcount = self.cursor.rowcount
        return 0
    
    def update_sql(self, update_sql, param):
        full_update_sql = fill_sql(update_sql, param)
	try:
            str = self.cursor.execute(full_update_sql)
            self.db.commit()
        except mysql.connector.Error as err:
            self.delete_rowcount = self.cursor._rowcount
            print mysql.connector.Error, err
            return -1
        self.delete_rowcount = self.cursor._rowcount
        return 0        

    def delete_sql(self, delete_sql, param):
        full_delete_sql = fill_sql(delete_sql, param)
        try:
            str = self.cursor.execute(full_delete_sql)
            self.db.commit()
        except mysql.connector.Error as err:
            self.delete_rowcount = self.cursor._rowcount
            print mysql.connector.Error, err
            return -1
        self.delete_rowcount = self.cursor._rowcount
        return 0        

    def select_sql(self, select_sql, param):
        full_select_sql = fill_sql(select_sql, param)
        try:
            self.cursor.execute(full_select_sql)
        except mysql.connector.Error as err:
            print mysql.connector.Error, err
            return None
        self.select_rowcount = self.cursor._rowcount
        return self.cursor
        
    def disconnect(self):
        self.cursor.close()
        self.db.close()       
