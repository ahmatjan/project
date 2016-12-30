#!/home/work/local/python27/bin/python
#-*- coding: utf-8 -*-

import signal
import ConfigParser
import sys
import string
import time

import db_operator
from logger import initlog
import index_op
import input_op

g_signal_up = False
g_idx_param = index_op.idxfile_param()
g_input_param = input_op.input_param()
g_max_buffer_size = 0
g_update_interval = 0
g_db_base = db_operator.db_base()
g_base_table_op = db_operator.table_op()
g_cycle_table_op = db_operator.table_op()
g_key=[]
g_value = []

class msg_policy:
    def __init__(self):
        self.type_im = '0'
        self.type_bm = '1'
        self.option_map = {}

class control_msg_policy:
    def __init__(self):
        self.type = '0'
        self.option_map = {}
        self.begin = '0'
        self.end = '1'

g_msg_policy = msg_policy()
g_control_msg_policy = control_msg_policy()

def convert_str_to_dict(in_str):
    param_idx_items = in_str.split(",")
    param_idx_pairs = [item.split(":") for item in param_idx_items]
    odict = dict([(k,string.atoi(v)) for (k,v) in param_idx_pairs])
    return odict

def sig_handler(signum, frame):
    global g_signal_up
    g_signal_up = True

def register_signal():
    signal.signal(signal.SIGINT, sig_handler)
    signal.signal(signal.SIGTERM, sig_handler)

def load_conf():
    config = ConfigParser.ConfigParser()
    config.read('../conf/add.conf')
    try:
        global g_idx_param
        g_idx_param.idx_path = config.get("global", "IDX_PATH")
        g_idx_param.idx_bak_path = config.get("global", "IDX_BAK_PATH")
        g_idx_param.format_str = config.get("input", "TIME_FORMAT")

        global g_max_buffer_size
        g_max_buffer_size = config.getint("global", "MAX_SQL_BUFFER_SIZE")
        global g_update_interval
        g_update_interval = config.getint("global", "MAX_SQL_UPDATE_INTERVAL")
        
        #创建写日志的对象
        #g_loglis[0].info()写info信息；g_loglis[1].error() g_loglis[1].warning()写warning、fatal信息
        global g_loglis
        log_path = config.get("global", "LOG_PATH")
        log_bak_path = config.get("global", "LOG_BAK_PATH")
        g_loglis = initlog(log_path, log_bak_path)
        
        global g_db_base
        g_db_base.host = config.get("db", "DB_HOST")
        g_db_base.port = config.get("db", "DB_PORT")
        g_db_base.user = config.get("db", "DB_USER")
        g_db_base.passwd = config.get("db", "DB_PASSWD")
        g_db_base.database = config.get("db", "DB_DATABASE")
        g_loglis[0].info("[NOTICE]: [host:%s] [port:%s] [user:%s] [passwd:%s] [database:%s]" % (g_db_base.host, g_db_base.port, g_db_base.user, g_db_base.passwd, g_db_base.database))

        global g_base_table_op
        g_base_table_op.tablename = config.get("base_table", "SQL_TABLENAME")
        g_base_table_op.type = "base"
        g_base_table_op.build_sql = config.get("base_table", "SQL_BUILD_TABLE")
        g_base_table_op.insert_sql = config.get("base_table", "SQL_INSERT")
        g_base_table_op.update_sql = config.get("base_table", "SQL_UPDATE")
        g_base_table_op.delete_sql = config.get("base_table", "SQL_DELETE")
        g_base_table_op.select_sql = config.get("base_table", "SQL_SELECT")
        g_loglis[0].info("[NOTICE]: bm_data tablename: %s" % (g_base_table_op.tablename))

        global g_cycle_table_op
        g_cycle_table_op.tablename = config.get("cycle_table", "SQL_TABLENAME_PREFIX")
        g_cycle_table_op.type = "cycle"
        g_cycle_table_op.build_sql = config.get("cycle_table", "SQL_BUILD_TABLE")
        g_cycle_table_op.insert_sql = config.get("cycle_table", "SQL_INSERT")
        g_cycle_table_op.delete_sql = config.get("cycle_table", "SQL_DELETE")
        g_cycle_table_op.select_sql = config.get("cycle_table", "SQL_SELECT")
        g_loglis[0].info("[NOTICE]: im_data tablename prefix: %s" % (g_cycle_table_op.tablename))

        global g_msg_policy
        g_msg_policy.type_im = int(config.get("type", "TYPE_IM"))
        g_msg_policy.type_bm = int(config.get("type", "TYPE_BM"))
        g_msg_policy.option_map = convert_str_to_dict(config.get("type", "PARAM_IDX"))
        g_loglis[0].info("[NOTICE]: option map: %s" % (config.get("type", "PARAM_IDX")))
        
        global g_key
        key_str = config.get("type", "KEY")
        g_key = key_str.split(',')
        global g_value
        value_str = config.get("type", "VALUE")
        g_value.append(value_str)
        g_loglis[0].info("[NOTICE]: g_key: %s" % (g_key))
        g_loglis[0].info("[NOTICE]: g_value: %s" % (g_value))
        g_loglis[0].info("[NOTICE]: g_msg_policy.option_map: %s" % (g_msg_policy.option_map))

        global g_control_msg_policy
        g_control_msg_policy.type = config.get("controltype", "TYPE_CONTROL")
        g_control_msg_policy.option_map = convert_str_to_dict(config.get("controltype", "PARAM_IDX"))
        g_control_msg_policy.begin = config.get("controltype", "BM_BEGIN")
        g_control_msg_policy.end = config.get("controltype", "BM_END")
        g_loglis[0].info("[NOTICE]: g_control_msg_policy: %s" % (g_control_msg_policy.option_map))

        global g_input_param
        g_input_param.path = config.get("input", "INPUT_PATH")
        g_input_param.prefix = config.get("input", "INPUT_PREFIX")
        g_input_param.postfix = config.get("input", "INPUT_POSTFIX")
        g_input_param.format_str = config.get("input", "TIME_FORMAT")
        g_input_param.cycle_sec = config.getint("input", "INPUT_SEG_CYCLE")
        g_input_param.next_file_num = config.getint("input", "NEXT_NUM_FILE")
        g_loglis[0].info("[NOTICE]: g_input_param: path[%s], prefix[%s], postfix[%s], format_str[%s], cycle_sec[%s]" % (g_input_param.path, g_input_param.prefix, g_input_param.postfix, g_input_param.format_str, g_input_param.cycle_sec))

    except Exception, ex:
        g_loglis[1].error("[FATAL]: load_conf failed, lineno[%s], exception info[%s, %s]" % (sys._getframe().f_lineno, Exception, ex))
        return -1

    return 0
    
def init_connect():
    global g_db_connect
    g_db_connect = db_operator.db_operator(g_db_base)
    if g_db_connect.connect_to() < 0:
        g_loglis[1].error("[FATAL]: connect to database[%s] failed." % (g_db_base.databases))
        return -1
    create_param = {"table" : g_base_table_op.tablename}
    return g_db_connect.create_table(g_base_table_op.build_sql, create_param)

def uninit_connect():
    g_db_connect.disconnect()

class data_buffer:
    def __init__(self):
        self.data_day = ""
        self.info_buf = []

class data_bufs:
    def __init__(self):
        self.bufs = []

    def add(self, data_day, info):
        for buffer in self.bufs:
            if buffer.data_day == data_day:
                buffer.info_buf.append(info)
                return
        buffer = data_buffer()
        buffer.data_day = data_day
        buffer.info_buf.append(info)
        self.bufs.append(buffer)
        return

    def get_info_cnt(self):
        total_len = 0
        for buffer in self.bufs:
            total_len += len(buffer.info_buf)
        return total_len

class data_parser:
    def __init__(self):
        self.msg_policy = None
        self.control_msg_policy = None

    def init(self, msg_policy):
        self.msg_policy = msg_policy

    def parse(self, line, info):
        """
            0: 增量,基准
            1: 其他信息
        """
        line_values = line.strip("\n").split("\t")
        try:
            type_line = int(self.msg_policy.option_map["type"])
            #g_loglis[0].info("[NOTICE]: msgtype[%s]", line);
            msgtype = int(line_values[type_line])
            #g_loglis[0].info("[NOTICE]: msgtype[%d] type_im[%d] type_bm[%d]" % (msgtype, self.msg_policy.type_im, self.msg_policy.type_bm))
            if msgtype == self.msg_policy.type_im or msgtype == self.msg_policy.type_bm:
                for idx in sorted(self.msg_policy.option_map.values()):
                    info.append(int(line_values[idx]))
                return 0
            else:
                return 1

        except Exception, ex:
            g_loglis[1].error("[FATAL]: line_parse failed,lineno[%s], exception info[%s:%s]" % (sys._getframe().f_lineno, Exception, ex))
            return 1

def format_time(time_sec):
    m_struct_time = time.localtime(time_sec)
    try:
        return time.strftime("%Y-%m-%d %H:%M:%S", m_struct_time)
    except Exception, ex:
        g_loglis[1].error("[FATAL]: format_time failed, lineno[%s], exception info[%s:%s]" % (sys._getframe().f_lineno, Exception, ex))
        return ""

def main():
    #register signal
    register_signal()

    if load_conf() < 0:
        g_loglis[1].error("[FATAL]: load conf failed")
        return -1

    #init database
    if init_connect() < 0:
        g_loglis[1].error("[FATAL]: init connect failed")
        return -1

    #init idx file
    idxfile = index_op.idxfile(g_idx_param)
    input_offset = idxfile.get_idx()
    if input_offset == None:
        g_loglis[1].error("[FATAL]: read idx failed, idx_file_name[%s,%s]" % (g_idx_param.idx_path, g_idx_param.idx_bak_path))
        return -1
    g_loglis[0].info("[NOTICE]: input file timestamp[%s], offset[%s]" % (input_offset.timestamp, input_offset.offset))

    #open input data file
    inputfile = input_op.inputfile(g_input_param)
    if inputfile.open(input_offset) < 0:
        g_loglis[1].error("[FATAL]: input file open failed,filepath[%s], prefix[%s], postfix[%s], seg_cycle[%s]" % (g_input_param.path, g_input_param.prefix, g_input_param.postfix, g_input_param.cycle_sec))
        return -1

    is_start_up = True
    m_data_bufs = data_bufs()
    m_data_parser = data_parser()
    m_data_parser.init(g_msg_policy)
    start_time_sec = int(time.time())
    m_type_bm = int(g_msg_policy.type_bm)
    m_type_im = int(g_msg_policy.type_im)
    
    data_map = dict()
    select_param = {"table":g_base_table_op.tablename}
    cursor = g_db_connect.select_sql(g_base_table_op.select_sql, select_param)
    if cursor != None:
        for key_value in cursor:
            key_tuple=tuple(key_value[0:-1])
            data_map[key_tuple] = key_value[-1]
    
    while True:
        if g_signal_up:
            #waiting to finish the update
            #do database disconnect
            g_loglis[0].info("[NOTICE]: catch signal. quit")
            uninit_connect()
            return 0
        
        line = inputfile.readline()
        info = []
        if line != "":
            parse_ret = m_data_parser.parse(line, info)

            if parse_ret == 0:
                time_str=format_time(info[1])
                if time_str != "":
                    day_str=time_str[0:4] + time_str[5:7] + time_str[8:10]
                    m_data_bufs.add(day_str, info)
                else:
                    g_loglis[1].error("[FATAL]: add_buffer error")
            else:
                continue
        cur_time_sec = int(time.time())
        diff_time_sec = cur_time_sec - start_time_sec
        total_info = m_data_bufs.get_info_cnt()
        
        #g_loglis[0].info("[NOTICE]: diff_time_sec[%d] g_update_interval[%d] total_info[%d] g_max_buffer_size[%d]", g_update_interval, g_update_interval, total_info, g_max_buffer_size)
        if diff_time_sec >= g_update_interval or \
           total_info >= g_max_buffer_size:
            #Mysql ping 
            ret_value = g_db_connect.db_ping()
            if ret_value != 0:
                g_liglis[1].error("[FATAL]: mysql ping error! exit!")
                return 1
            for m_data_buffer in m_data_bufs.bufs:
               data_im_param = {"table":g_cycle_table_op.tablename + m_data_buffer.data_day}
               ret = g_db_connect.create_table(g_cycle_table_op.build_sql, data_im_param)
               if ret < 0:
                   g_loglis[1].error("[FATAL]: create_table error, exit. sql[%s] table[%s] day[%s]" % (g_cycle_table_op.build_sql, g_cycle_table_op.tablename, m_data_buffer.data_day))
                   return 1
               
               for buf_info in m_data_buffer.info_buf:
                   time_sec = buf_info[1]
                   data_value = buf_info[-1]
                   data_key=buf_info[2:-1]
               
                   #查找last_data_value值
                   last_data_value = -1
               
                   if tuple(data_key) in data_map:
                       last_data_value = data_map[tuple(data_key)]
                       if data_value != last_data_value:
                           #update bm_data_value_table and data_map
                           data_bm_pre_param =  {"table":g_base_table_op.tablename,\
                                                 "modtime":format_time(time_sec)}
                           data_key_param = dict(zip(g_key, data_key))
                           data_value_param = dict(zip(g_value, [data_value]))
                           data_bm_update_param = dict(data_bm_pre_param.items() + data_key_param.items() + data_value_param.items())
                           ret = g_db_connect.update_sql(g_base_table_op.update_sql, data_bm_update_param)
                           if ret < 0:
                               g_loglis[1].error("[FATAL]: update data_value_bm_table error, exit, sql[%s], param[%s]" % (g_base_table_op.update_sql, data_bm_update_param))
                           else:
                               data_map[tuple(data_key)] = data_value
                   
                   else:
                       #insert bm_data_value_table and data_map
                       data_bm_insert_param = {"table":g_base_table_op.tablename}
                   
                       m_bm_insert_value = tuple(data_key) + tuple([data_value, format_time(time_sec)])
                       data_bm_insert_values = []
                       data_bm_insert_values.append(m_bm_insert_value)
                       ret = g_db_connect.insert_sql(g_base_table_op.insert_sql, data_bm_insert_param, data_bm_insert_values)
                       if ret < 0:
                           g_loglis[1].error("[FATAL]: Insert data_value_bm_table error, exit. sql[%s], param[%s], value[%s]" % (g_base_table_op.insert_sql, data_bm_insert_param, data_bm_insert_values))
                       else:
                           data_map[tuple(data_key)] = data_value
                   #如果数据不同那么会产生增量信息。    
                   if data_value == last_data_value:
                       continue
                   #更新增量状态表
               
                   data_value_stat = ''
                   if last_data_value == -1:
                       data_value_stat = 'Insert'
                   elif last_data_value == 0 and data_value == 1:
                       data_value_stat = 'balance_offline'
                   elif last_data_value == 0 and data_value == 2:
                       data_value_stat = 'budget_offline'
                   elif last_data_value == 1 and data_value == 0:
                       data_value_stat = 'balance_online'
                   elif last_data_value == 1 and data_value == 3:
                       data_value_stat = 'budget_offline'
                   elif last_data_value == 2 and data_value == 0:
                       data_value_stat = 'budget_online'
                   elif last_data_value == 2 and data_value == 3:
                       data_value_stat = 'balance_offline'
                   elif last_data_value == 3 and data_value == 1:
                       data_value_stat = 'budget_online'
                   elif last_data_value == 3 and data_value == 2:
                       data_value_stat = 'balance_online'
                   else:
                       data_value_stat = 'unknown'
                       g_loglis[1].error("[FATAL]: status error, data_key[%s] last[%d], now[%d]" % (data_key, last_data_value, data_value))
                   
                   m_im_insert_value = tuple([format_time(time_sec)]) + tuple(data_key) + tuple([data_value,last_data_value,data_value_stat])
                   data_im_insert_values=[]
                   data_im_insert_values.append(m_im_insert_value)
                   #增量信息，插入增量表
                   ret = g_db_connect.insert_sql(g_cycle_table_op.insert_sql, data_im_param, data_im_insert_values)
                   if ret < 0:
                       g_loglis[1].error("[FATAL]: INSERT data_value_im_table error, exit. sql[%s], param[%s], values[%s]" % (g_cycle_table_op.insert_sql, data_im_param, data_im_insert_values))
                
            start_time_sec = int(time.time())
            m_data_bufs.bufs=[]
            idx_offset = inputfile.get_fileoffset()
            idxfile.write_idx(idx_offset)
            g_loglis[0].info("[NOTICE]: write index fille, timestamp[%s], offset[%s]." % (idx_offset.timestamp, idx_offset.offset))

if __name__ == "__main__":
    main()






        
                


