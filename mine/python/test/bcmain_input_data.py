#-*- coding: GB18030 -*-
 
import re
import os
import json
import traceback
from frame.lib.commonlib.xtslog import xtslog
from frame.lib.commonlib.autosleep import *
from frame.lib.commonlib.xtssystem import *
from frame.lib.commonlib.utils import  kill_process
from frame.lib.commonlib.logreader import LogReader
from lib.controllib.fcshark_env_global import fcsharkEnvGlobal
from lib.commonlib.ubconf.configure import Configure
from lib.commonlib.termcolor import *


class bcmain_input_file(object):
    def __init__(self, path="", my_time="", prefix="inputflow."):
        self.name_prefix = prefix
        self.name_postfix = ".log"
        self.my_time = my_time
        timestamp = my_time.get_timestamps()
        self.file_name = self.name_prefix + timestamp + self.name_postfix
        self.file_path = path + timestamp.split("-")[0] + "/" + self.file_name
        self.data_time = my_time.get_seconds_str()
        #�����ļ�
        path_day = path + timestamp.split("-")[0]
        if os.path.exists(path_day) == False:
            os.makedirs(path_day)
        open(self.file_path,'a').close()
        self.line_num = 0
        
    def append_data(self,data):
        with open(self.file_path,'a') as _tf:
            if self.line_num == 0:
                    print colored("-----INPUT FLOW: ", 'cyan', attrs=['bold'])
            print colored(data.dump_to_str().encode("utf-8"), 'blue')
            _tf.write(data.dump_to_str().encode("utf-8") + "\n")
            self.line_num = self.line_num + 1
        
    def append_data_list(self, data_list):
        for data in data_list:
            self.append_data(data)


    '''
    ####################################################################################
    #                           function of bcmain with bin_type = 0 and 2             #   
    ####################################################################################
    '''

    def add_bd_finance_data(self, userid = "10", newbalance = "100", balancediff = "100", reason = "1", time = "", id="1"):
        if time == "":
            time = self.data_time
        self.append_data(finance_data(id = id, type = "9",time = time, userid = userid, newbalance = newbalance, balancediff = balancediff, reason = reason) )
 
    def add_bd_pool_config(self,id = "1",time = "",userid = "10",oldstatus = "0", newstatus = "128",reserve = "0"):
        if time == "":
            time = self.data_time
        self.append_data(bd_pool_config(id = id, time = time, userid = userid,newstatus = newstatus,oldstatus = oldstatus,reserve = reserve))

    def add_bdcharge_clk(self,flowtype = "6", route_id = "1.0.0.0.0.0.0", serial_num = "1", userid = "10", planid = "1001", dprice = "1.00",\
                          clktype = "1",clicktime="", chargetime = "", cmatch = "1", balance = "100",finance_pool_type = "0"):
        if chargetime == "":
            chargetime = self.my_time.get_charge_time()
        if clicktime == "":
            clicktime =  self.my_time.get_charge_time()
        self.append_data(bdcharge_click_data(flowtype = flowtype,route_id = route_id, serial_num = serial_num, clktype = clktype,clicktime = clicktime,\
                        chargetime = chargetime, cmatch = cmatch, dprice = dprice, userid = userid, planid = planid, balance = balance,\
                        finance_pool_type = finance_pool_type))

    '''
    ####################################################################################
    #                           function of bcmain with bin_type = 0                   #   
    ####################################################################################
    '''
    def add_finance_data(self, userid = "10", newbalance = "100", balancediff = "100", reason = "1", time = "", id="1", typeex = ""):
        #��������
        if time == "":
            time = self.data_time
        self.append_data( finance_data(id = id, time = time, userid = userid, newbalance = newbalance, balancediff = balancediff, reason = reason, typeex = typeex) )
        
    def add_mbudgetinfo_BM_BEGIN(self):
        #Fc_wordԤ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(tableid = "1", content = "0") )

    def add_mbudgetinfo_BM_END(self):
        self.append_data( fcword_data(tableid = "1", content = "1") )

    def add_wbudget_BM_BEGIN(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(tableid = "0", content = "0") )

    def add_wbudget_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(tableid = "0", content = "1") )

    def add_planinfo_BM_BEGIN(self):
        #Fc_word�ƻ�״̬��׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "8",tableid = "2", content = "0") )

    def add_planinfo_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "8",tableid = "2", content = "1") )

    def add_wbudget_BM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( wbudget_data(flowtype = "3",type = "1", time = time, userid = userid, planid = planid, budget = budget) )

    def add_wbudget_IM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��������type=0
        self.append_data( wbudget_data(flowtype = "3",type = "0", time = time, userid = userid, planid = planid, budget = budget) )
        
    def add_mbudget_BM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( mbudget_data(flowtype = "3",type = "1", time = time, userid = userid, planid = planid, budget = budget) )
        
    def add_mbudget_IM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��������type=0
        self.append_data( mbudget_data(flowtype = "3",type = "0", time = time, userid = userid, planid = planid, budget = budget) )
        
    def add_planinfo_BM_data(self, userid = "10", planid = "1001", is_del = "0", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( planinfo_data(flowtype = "8",type = "1", time = time, userid = userid, planid = planid, is_del = is_del) )
        
    def add_planinfo_IM_data(self, userid = "10", planid = "1001", is_del = "0", time = ""):
        if time == "":
            time = self.data_time
        #�ƻ�״̬������type=0; is_del=1��ʾ�ƻ���ɾ��,Ĭ����0��
        self.append_data( planinfo_data(flowtype = "8",type = "0", time = time, userid = userid, planid = planid, is_del = is_del) )

    def add_dfsimple_clk(self,flowtype = "0", route_id = "1.0.0.0.0.0.0", serial_num = "1", userid = "10", planid = "1001", 
                         believe = "10000", price = "100", clicktime = "", cmatch = "1"):
        if clicktime == "":
            clicktime = self.data_time
        self.append_data( dfsimple_click_data(route_id = route_id, serial_num = serial_num, believe = believe, clicktime = clicktime, 
                                              cmatch = cmatch, price = price, userid = userid, planid = planid) )

    def add_dsfcharge_clk(self,flowtype = "1", route_id = "1.0.0.0.0.0.0", serial_num = "1", userid = "10", planid = "1001", dprice = "1.00", 
                          couponrate = "0.00000000", clktype = "1",clicktime="", chargetime = "", cmatch = "1", balance = "100"):
        if chargetime == "":
            chargetime = self.my_time.get_charge_time()
        if clicktime == "":
            clicktime =  self.my_time.get_charge_time()
        self.append_data( dsfcharge_click_data(flowtype = flowtype,route_id = route_id, serial_num = serial_num, clktype = clktype,clicktime = clicktime,\
			chargetime = chargetime, cmatch = cmatch, dprice = dprice, userid = userid, planid = planid, couponrate = couponrate, balance = balance) )

    '''
    ####################################################################################
    #                           function of bcmain with bin_type = 1                   #   
    ####################################################################################
    '''
    def add_push_mbudget_BM_BEGIN(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "7",tableid = "1", content = "0") )

    def add_push_mbudget_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "7",tableid = "1", content = "1") )

    def add_push_wbudget_BM_BEGIN(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "5",tableid = "0", content = "0") )

    def add_push_wbudget_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "5",tableid = "0", content = "1") )

    def add_push_wbudget_BM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( wbudget_data(flowtype = "5",type = "1", time = time, userid = userid, planid = planid, budget = budget) )

    def add_push_wbudget_IM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��������type=0
        self.append_data( wbudget_data(flowtype = "5",type = "0", time = time, userid = userid, planid = planid, budget = budget) )        

    def add_push_mbudget_BM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( mbudget_data(flowtype = "7",type = "1", time = time, userid = userid, planid = planid, budget = budget) )

    def add_push_mbudget_IM_data(self, userid = "10", planid = "1001", budget = "11", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��������type=0
        self.append_data( mbudget_data(flowtype = "7",type = "0", time = time, userid = userid, planid = planid, budget = budget) )

    def add_push_dsfcharge_clk(self,flowtype = "4", route_id = "1.0.0.0.0.0.0", serial_num = "1", userid = "10", planid = "1001", dprice = "1.00", 
                          couponrate = "0.00000000", clktype = "1",clicktime="", chargetime = "", cmatch = "1", balance = "100"):
        if chargetime == "":
            chargetime = self.my_time.get_charge_time()
        if clicktime == "":
            clicktime =  self.my_time.get_charge_time()
        self.append_data( dsfcharge_click_data(flowtype = flowtype,route_id = route_id, serial_num = serial_num, clktype = clktype,clicktime = clicktime,\
			chargetime = chargetime, cmatch = cmatch, dprice = dprice, userid = userid, planid = planid, couponrate = couponrate, balance = balance) )

    '''
    ####################################################################################
    #                           function of bcmain with bin_type = 2                   #   
    ####################################################################################
    '''
    def add_msg_dsfcharge_clk(self,flowtype = "21", route_id = "1.0.0.0.0.0.0", serial_num = "1", userid = "10", planid = "1001", dprice = "1.00", 
                          couponrate = "0.00000000", clktype = "1",clicktime="", chargetime = "", cmatch = "1", balance = "100"):
        if chargetime == "":
            chargetime = self.my_time.get_charge_time()
        if clicktime == "":
            clicktime =  self.my_time.get_charge_time()
        self.append_data( dsfcharge_click_data(flowtype = flowtype,route_id = route_id, serial_num = serial_num, clktype = clktype,clicktime = clicktime,\
			chargetime = chargetime, cmatch = cmatch, dprice = dprice, userid = userid, planid = planid, couponrate = couponrate, balance = balance) )

    def add_msg_bdcharge_clk(self,flowtype = "22", route_id = "1.0.0.0.0.0.0", serial_num = "1", userid = "10", planid = "1001", dprice = "1.00",\
                          clktype = "1",clicktime="", chargetime = "", cmatch = "1", balance = "100",finance_pool_type = "0"):
        if chargetime == "":
            chargetime = self.my_time.get_charge_time()
        if clicktime == "":
            clicktime =  self.my_time.get_charge_time()
        self.append_data(bdcharge_click_data(flowtype = flowtype,route_id = route_id, serial_num = serial_num, clktype = clktype,clicktime = clicktime,\
                        chargetime = chargetime, cmatch = cmatch, dprice = dprice, userid = userid, planid = planid, balance = balance,\
                        finance_pool_type = finance_pool_type))

    def add_msg_planinfo_BM_BEGIN(self):
        #Fc_word�ƻ�״̬��׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "23",tableid = "2", content = "0") )

    def add_msg_planinfo_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "23",tableid = "2", content = "1") )

    def add_msg_planinfo_BM_data(self, userid = "10", planid = "1001", is_del = "0", time = "", planname = "flowers"):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( planinfo_data(flowtype = "23",type = "1", time = time, userid = userid, planid = planid, is_del = is_del, planname = planname) )
        
    def add_msg_planinfo_IM_data(self, userid = "10", planid = "1001", is_del = "0", time = "", planname = "flowers"):
        if time == "":
            time = self.data_time
        #�ƻ�״̬������type=0; is_del=1��ʾ�ƻ���ɾ��,Ĭ����0��
        self.append_data( planinfo_data(flowtype = "23",type = "0", time = time, userid = userid, planid = planid, is_del = is_del, planname = planname) )

    def add_msg_wbudget_BM_BEGIN(self):
        #Fc_wordԤ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "24",tableid = "0", content = "0") )

    def add_msg_wbudget_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "24",tableid = "0", content = "1") )

    def add_msg_wbudget_BM_data(self, userid = "10", planid = "1001", budget = "100", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data( wbudget_data(flowtype = "24",type = "1", time = time, userid = userid, planid = planid, budget = budget) )

    def add_msg_wbudget_IM_data(self, userid = "10", planid = "1001", budget = "100", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��������type=0
        self.append_data( wbudget_data(flowtype = "24",type = "0", time = time, userid = userid, planid = planid, budget = budget) )

    def add_msgcustom_BM_BEGIN(self):
        #Fc_wordԤ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "25",tableid = "3", content = "0") )

    def add_msgcustom_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "25",tableid = "3", content = "1") )

    def add_msgcustom_BM_data(self,userid = "10", typeid = "3", value = "100", time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data (msgcustom_data(flowtype = "25",type = "1", time = time, userid = userid, typeid = typeid, value = value))

    def add_msgcustom_IM_data(self,userid = "10", typeid = "3", value = "100", time = "",is_del = "0"):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data (msgcustom_data(flowtype = "25",type = "0", time = time, userid = userid, typeid = typeid, value = value,is_del = is_del))

    def add_msg_userinfo_BM_BEGIN(self):
        #Fc_wordԤ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "26",tableid = "4", content = "0") )

    def add_msg_userinfo_BM_END(self):
        #Fc_word����Ԥ���׼,{WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid; contentȡֵ={BM_BEGIN=0, BM_END=1}
        self.append_data( fcword_data(flowtype = "26",tableid = "4", content = "1") )

    def add_msg_userinfo_BM_data(self, userid = "10", username = "fc_shark",time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data(userinfo_data(userid = userid, username = username, time = time, type = "1"))            

    def add_msg_userinfo_IM_data(self, userid = "10", username = "fc_shark",time = ""):
        if time == "":
            time = self.data_time
        #Ԥ��&״̬��׼���ݣ�Enum{IM=0,BM=1,CONTROL=2} Type;
        self.append_data(userinfo_data(userid = userid, username = username, time = time, type = "0"))      
        
    def add_stock_api(self, merchantId = 277, merchantName = u"�����̳�", price = "99.9", stock = "100", 
                      product_innerId = 12345, ucId = 111, timeMillis = 1367897133719, offers = []):
        self.append_data(stock_data(merchantId = merchantId, merchantName = merchantName, source_from = "api", price = price, stock = stock, 
                      product_innerId = product_innerId, ucId = ucId, timeMillis = timeMillis, offers = offers))
    def add_stock_feed(self, merchantId = 277, merchantName = u"�����̳�", price = "99.9", stock = "100", 
                      product_innerId = 12345, ucId = 111, timeMillis = 1367897133719, offers = []):
        self.append_data(stock_data(merchantId = merchantId, merchantName = merchantName, source_from = "feed", price = price, stock = stock, 
                      product_innerId = product_innerId, ucId = ucId, timeMillis = timeMillis, offers = offers))
        
    def add_stock_data(self, json_str):
        self.append_data(stock_data_str(json_str=json_str))
        

class bcmain_data(object):
    """
    bcmain�����������ݸ�ʽ��
        Format: ID: uint64    flowtype:uint32    Msgcontent
        flowtypeȡֵ����:
            0    ԭʼ���
            1    �Ʒѵ��(�������˵��)
            2    ����ת��
            3    �ƻ�&Ԥ����Ϣ

    """
    def __init__(self, 
                 data_len = 3, 
                 id="1", 
                 flowtype="0", 
                 msg_content="test"):
        
        self.data = []
        self.data_len = data_len
        for i in range(0,self.data_len):
            self.data.append("")
        if data_len >= 3:
            self.data[0] = id
            self.data[1] = flowtype
            self.data[2] = msg_content
        
    def __cmp__(self, other):
        if self.data == other.data:
            return 0
        return 1
        
    def dump_to_str(self):
        return_str = self.data[0]
        for i in range(1, self.data_len):
            return_str = return_str + "\t" + self.data[i]
        return return_str
    
    def check_data(self, index, cmp_data):
        for i in range(0,self.data_len):
            if self.data[i] != cmp_data.data[i]:
                xtslog.fatal("Dump data(index=%d) not equal: ", index)
                xtslog.fatal("----> Expect Data: [%s]", self.data)
                xtslog.fatal("----> Actual Data: [%s]", self.cmp_data.data)
                return false
        return True
    
class bd_pool_config(bcmain_data):
    """
    ����/ȡ������ר���ʽ��״̬�ӿ�
    Id	���	Uint64, �����������ֵ
    Time	�¼�����ʱ�䣬���䶯��ʱ��,��	uint32_t
    userid	�û�id	uint32_t
    Oldstatus	��״̬	Uint32_t
    Newstatus	��״̬	Uint32_t
    Reserve	����	Default: 0
    """
    def __init__(self, 
                 data_len = 8, 
                 id = "1", 
                 finance_id = "1", 
                 time = "", 
                 userid = "10", 
                 oldstatus = "0", 
                 newstatus = "128",
                 reserve = "0",
                 type = "40"
                 ):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = type
        self.data[2] = finance_id
        self.data[3] = time
        self.data[4] = userid
        self.data[5] = oldstatus
        self.data[6] = newstatus
        self.data[7] = reserve
    

class finance_data(bcmain_data):
    """
    1    id    ���    Uint64, ������ �����ֵ
    2    time    �¼�����ʱ�䣬���䶯��ʱ��,��    uint32_t
    3    userid    �û�id    uint32_t
    4    newbalance    �����    uint64_t
    5    balancediff    ���仯    ������ int64_t
    6    Reason    ԭ��    Default: 0    1��    ���ֽ�    2��    ת��    3��    ת��  4��    ����
    """
    def __init__(self, 
                 data_len = 8, 
                 id = "1", 
                 type = "2",
                 finance_id = "1", 
                 time = "", 
                 userid = "10", 
                 newbalance = "100", 
                 balancediff = "0", 
                 reason = "0", 
                 typeex = ""
                 ):
        if typeex != "":
            data_len = 9
            type = "12"
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = type
        self.data[2] = finance_id
        self.data[3] = time
        self.data[4] = userid
        self.data[5] = newbalance
        self.data[6] = balancediff
        self.data[7] = reason
        if typeex != "":
            self.data[8] = typeex


class msgcustom_data(bcmain_data):
    """
    ��ֵ����
    Tableid    Type     msgcustom_id	time	userid	typeid	value
    Enum {WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid;
    Enum{IM=0,BM=1,CONTROL=2}Type; IM��ʾ������BM��ʾ��׼�� CONTROL��ʾ�����źţ�����׼��ʼ���߻�׼������
    type == CONTROL ʱ��contentȡֵ={BM_BEGIN=0, BM_END=1}��
    typeid=1��ʾ�����ֵ���ݣ�type=3��ʾ�˻�����������ֵ����
    ��������鲻�����û���typeid=1�����ݣ���˵�����û������ֵʹ��Ĭ��ֵ500��
    ��������鲻�����û���typeid=3�����ݣ���˵�����û�������������ֵ
    """
    def __init__(self, 
                 data_len = 10, 
                 id = "1", 
                 flowtype = "25",
                 tableid = "3", 
                 type = "0",
                 msgcustom_id = "1",
                 time = "",
                 userid = "10",
                 typeid = "1",
                 value = "",
                 is_del = ""
                 ):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = tableid
        self.data[3] = type
        self.data[4] = msgcustom_id
        self.data[5] = time
        self.data[6] = userid
        self.data[7] = typeid
        self.data[8] = value
        self.data[9] = is_del

class userinfo_data(bcmain_data):
    """
    ��ֵ����
    Tableid    Type     Content
    Enum {WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid;
    Enum{IM=0,BM=1,CONTROL=2}Type; IM��ʾ������BM��ʾ��׼�� CONTROL��ʾ�����źţ�����׼��ʼ���߻�׼������
    type == CONTROL ʱ��contentȡֵ={BM_BEGIN=0, BM_END=1}��
    """
    def __init__(self, 
                 data_len = 8, 
                 id = "1", 
                 flowtype = "26",
                 tableid = "4", 
                 type = "0",
                 username_id = "1",
                 userid = "10",
                 time = "",
                 username = "fc_shark"):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = tableid
        self.data[3] = type
        self.data[4] = username_id
        self.data[5] = time
        self.data[6] = userid
        self.data[7] = username
        

class fcword_data(bcmain_data):
    """
    ��ֵ����
    Tableid    Type     Content
    Enum {WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid;
    Enum{IM=0,BM=1,CONTROL=2}Type; IM��ʾ������BM��ʾ��׼�� CONTROL��ʾ�����źţ�����׼��ʼ���߻�׼������
    type == CONTROL ʱ��contentȡֵ={BM_BEGIN=0, BM_END=1}��
    """
    def __init__(self, 
                 data_len = 5, 
                 id = "1", 
		 flowtype = "3",
                 type = "2", 
                 tableid = "0", 
                 content = ""):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = tableid
        self.data[3] = type
        self.data[4] = content
        
class wbudget_data(bcmain_data):
    """
    Tableid    Type     Content
    Enum {WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid;
    Enum{IM=0,BM=1,CONTROL=2}Type; IM��ʾ������BM��ʾ��׼�� CONTROL��ʾ�����źţ�����׼��ʼ���߻�׼������
    type == CONTROL ʱ��contentȡֵ={BM_BEGIN=0, BM_END=1}��
    ---------------------
    ID:uint64_t    Time:uint32_t    Userid:uint32_t     Planid:uint32_t    Budget:uint64_t
    budget==MAX_UINT64_T, ��ʾwbudget��ɾ��һ����¼�����û�������Ԥ�㡣
    """
    def __init__(self, 
                 data_len = 9, 
                 id = "1", 
		 flowtype="3",
                 type = "", 
                 wbudget_id = "1", 
                 time = "", 
                 userid = "10", 
                 planid = "1001", 
                 budget = "10"):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = "0"
        self.data[3] = type
        self.data[4] = wbudget_id
        self.data[5] = time
        self.data[6] = userid
        self.data[7] = planid
        self.data[8] = budget


class mbudget_data(bcmain_data):
    """
    Tableid    Type     Content
    Enum {WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid;
    Enum{IM=0,BM=1,CONTROL=2}Type; IM��ʾ������BM��ʾ��׼�� CONTROL��ʾ�����źţ�����׼��ʼ���߻�׼������
    type == CONTROL ʱ��contentȡֵ={BM_BEGIN=0, BM_END=1}��
    ---------------------
    ID:uint64_t    Time:uint32_t    Userid:uint32_t     Planid:uint32_t    Budget:uint64_t
    budget==MAX_UINT64_T, ��ʾwbudget��ɾ��һ����¼�����û�������Ԥ�㡣
    """
    def __init__(self,
                 data_len = 9,
                 id = "1",
		 flowtype = "3",
                 type = "",
                 wbudget_id = "1",
                 time = "",
                 userid = "10",
                 planid = "1001",
                 budget = "10"):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = "1"
        self.data[3] = type
        self.data[4] = wbudget_id
        self.data[5] = time
        self.data[6] = userid
        self.data[7] = planid
        self.data[8] = budget
        
class planinfo_data(bcmain_data):
    """
    Tableid    Type     Content
    Enum {WBUDGET =0, MBUDGETINOF=1, PLANINFO=2,MSGCUSTOM=3,USERACCT=4} Tableid;
    Enum{IM=0,BM=1,CONTROL=2}Type; IM��ʾ������BM��ʾ��׼�� CONTROL��ʾ�����źţ�����׼��ʼ���߻�׼������
    type == CONTROL ʱ��contentȡֵ={BM_BEGIN=0, BM_END=1}��
    ----------------------
    ID:uint64_t    Time:uint32_t    Userid:uint32_t     Planid:uint32_t    Is_del:uint32_t
    is_del=1��ʾ�ƻ���ɾ��,Ĭ����0��
    """
    def __init__(self, 
                 data_len = 10, 
                 id = "1", 
		 flowtype = "3",
                 type = "", 
                 planinfo_id = "1", 
                 time = "", 
                 userid = "10", 
                 planid = "1001", 
                 is_del = "0",
                 planname = "flowers"):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = "2"
        self.data[3] = type
        self.data[4] = planinfo_id
        self.data[5] = time
        self.data[6] = userid
        self.data[7] = planid
        self.data[8] = is_del
        self.data[9] = planname
        
class dfsimple_click_data(bcmain_data):    
    """
        STRNCPY(__clickid.route_id, line[3 + __base], strlen(line[3 + __base]) + 1);
        READ_FIELD_TO_UINT64(line[4 + __base], __clickid.serial_num, 0, ULLONG_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[6 + __base], __believe, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[9 + __base], __clicktime, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[11 + __base], __cmatch, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT64(line[14 + __base], __price, 0, ULLONG_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[16 + __base], __userid, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[19 + __base], __planid, 0, UINT_MAX, RET_FAIL);
        ----------------------
            1       crc             hex8    DEF
            2       version         uint32  DEF
        3       route           route7  DEF
        4       serial          uint32  DEF
            5       clktype         uint32  DEF
        6       believe         uint32  10000
            7       winfoid         uint32  DEF
            8       unitid          uint32  DEF
        9       clicktime         uint32  DEF
            10      disptime        uint32  DEF
        11      cmatch          uint32  DEF
            12      wmatch          uint32  DEF
            13      rank            uint32  DEF
        14      price           uint32  DEF
            15      bid             uint32  DEF
        16      userid          uint32  DEF
            17      drate           uint32  DEF
            18      wordid          uint32  DEF
        19      planid          uint32  DEF
    """
    def __init__(self, 
                 data_len = 22, 
                 id = "1", 
		 flowtype = "0",
                 route_id = "1.0.0.0.0.0.0", 
                 serial_num = "1", 
                 believe = "10000", 
                 clicktime = "", 
                 cmatch = "1", 
                 price = "100", 
                 userid = "10", 
                 planid = "1001"
                 ):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[4] = route_id
        self.data[5] = serial_num
        self.data[7] = believe
        self.data[10] = clicktime
        self.data[12] = cmatch
        #ԭʼ�����priceΪ��������λΪ��
        self.data[15] = price
        self.data[17] = userid
        self.data[20] = planid
        
        #===================�޹��ֶ�Ĭ��ֵ========================
        self.data[2] = "008f9bc2"
        self.data[3] = "5"
        self.data[6] = "1"
        self.data[8] = "100102003"
        self.data[9] = "100102"
        self.data[11] = "131"
        self.data[13] = "31"
        self.data[14] = "1"
        self.data[16] = "999"
        self.data[18] = "1"
        self.data[19] = "30001"
        self.data[21] = "columns_20\tcolumns_21\tEND"
        
        
class dsfcharge_click_data(bcmain_data):
    """
        STRNCPY(__clickid.route_id, line[3 + __base], strlen(line[3 + __base]) + 1);
        READ_FIELD_TO_UINT64(line[4 + __base], __clickid.serial_num, 0, ULLONG_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[7 + __base], __clktype, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[31 + __base], __chgtime, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[19 + __base], __cmatch, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_DOUBLE(line[16 + __base], __dprice, 0, RET_FAIL);
        READ_FIELD_TO_UINT32(line[8 + __base], __userid, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[9 + __base], __planid, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_DOUBLE(line[34 + __base], __couponrate, 0, RET_FAIL);
        ---------------------------
            1       crc                     hex8    DEF
            2       version         uint32  DEF
        3       route           route7  DEF
        4       serial          uint32  DEF
            5       srchid          hex16   DEF
            6       baiduid         hex32   DEF
        7       clktype_t       uint32  DEF
        8       userid          uint32  DEF
        9       planid          uint32  DEF
            10      unitid          uint32  DEF
            11      winfoid         uint32  DEF
            12      query           str             DEF
            13      wordid          uint32  DEF
            14      descid          uint32  DEF
            15      bid_d           double2 DEF
        16      price_d         double2 DEF
        17      balance         double2 DEF
            18      rrate           double8 DEF
        19      cmatch          uint32  DEF
            20      wmatch          uint32  DEF
            21      cntid           uint32  DEF
            22      refer           str             DEF
            23      rank            uint32  DEF
            24      drate           uint32  DEF
            25      dispip          ip              DEF
            26      clkip           ip              DEF
            27      provid          uint32  DEF
            28      cityid          uint32  DEF
            29      disptime_t      time    DEF
        30      clicktime_t       time    DEF
        31      chgtime_t       time    DEF
            32      k                       str             DEF
            33      orderrow        uint32  DEF
        34      couponrate      double8 DEF
        
    """
    
    def __init__(self, 
                 data_len = 36, 
                 id = "1", 
		 flowtype = "1",
                 route_id = "1.0.0.0.0.0.0", 
                 serial_num = "1", 
                 clktype = "1", 
	         clicktime = "",
                 chargetime = "", 
                 cmatch = "1", 
                 dprice = "1.00", 
                 userid = "10", 
                 planid = "1001", 
                 couponrate = "0.00000000", 
                 balance = "100"
                 ):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[4] = route_id
        self.data[5] = serial_num
        #ign�����clktypeΪ888888
        self.data[8] = clktype
        self.data[9] = userid
        self.data[10] = planid
        #�����Ӳ����п۳���price
        self.data[17] = dprice
        self.data[18] = balance
        self.data[20] = cmatch
        self.data[31] = clicktime
        self.data[32] = chargetime
        self.data[35] = couponrate
        
        #===================�޹��ֶ�Ĭ��ֵ========================
        self.data[2] = "008f9bc2"
        self.data[3] = "5"
        self.data[6] = "886b259806abc849"
        self.data[7] = "725bf648728b1688108c918a23deae91"
        self.data[11] = "13"
        self.data[12] = "7"
        self.data[13] = ""
        self.data[14] = "0"
        self.data[15] = "20"
        self.data[16] = "999.99"
        self.data[19] = "0.00000000"
        self.data[21] = "12"
        self.data[22] = "21"
        self.data[23] = "query"
        self.data[24] = "13"
        self.data[25] = "17"
        self.data[26] = "0.0.0.20"
        self.data[27] = "0.0.0.10"
        self.data[28] = "22"
        self.data[29] = "23"
        self.data[30] = "2009-08-08 08:00:00"
        self.data[33] = "strAttachTHvSkogJ8nM5VnMC_U60T1Yk0Z0qn0KW5H00UHYs0j"
        self.data[34] = "0"
        #self.col_after_34 = "col_35_not_used"


class bdcharge_click_data(bcmain_data):
    """
        STRNCPY(__clickid.route_id, line[3 + __base], strlen(line[3 + __base]) + 1);
        READ_FIELD_TO_UINT64(line[4 + __base], __clickid.serial_num, 0, ULLONG_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[7 + __base], __clktype, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[31 + __base], __chgtime, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[19 + __base], __cmatch, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_DOUBLE(line[16 + __base], __dprice, 0, RET_FAIL);
        READ_FIELD_TO_UINT32(line[8 + __base], __userid, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_UINT32(line[9 + __base], __planid, 0, UINT_MAX, RET_FAIL);
        READ_FIELD_TO_DOUBLE(line[34 + __base], __couponrate, 0, RET_FAIL);
        ---------------------------
        1       crc             hex8    DEF
        2       version         uint32  DEF
        3       route           route7  DEF
        4       serial          uint32  DEF
        5       srchid          hex16   DEF
        6       baiduid         hex32   DEF
        7       clktype         uint32  DEF
        8       userid          uint32  DEF
        9       planid          uint32  DEF
        10      unitid          uint32  DEF
        11      winfoid         uint32  DEF
        12      query           str     DEF
        13      wordid          uint32  DEF
        14      descid          uint32  DEF
        15      bid_d           double2 DEF
        16      price_d         double2 DEF
        17      balance         double2 DEF
        18      rrate           double8 DEF
        19      cmatch          uint32  DEF
        20      wmatch          uint32  DEF
        21      cntid           uint32  DEF
        22      refer           str     DEF
        23      rank            uint32  DEF
        24      drate           uint32  DEF
        25      dispip          ip      DEF
        26      clkip           ip      DEF
        27      provid          uint32  DEF
        28      cityid          uint32  DEF
        29      disptime_t      time    DEF
        30      clktime_t       time    DEF
        31      chgtime_t       time    DEF
        32      k               str     DEF
        33      orderrow        uint32  DEF 
        34	finance_pool_type
            """
    def __init__(self,
                 data_len = 36,
                 id = "1",
                 flowtype = "6",
                 route_id = "1.0.0.0.0.0.0",
                 serial_num = "1",
                 clktype = "1",
                 clicktime = "",
                 chargetime = "",
                 cmatch = "1",
                 dprice = "1.00",
                 userid = "30",
                 planid = "3001",
                 balance = "100",
                 finance_pool_type = "0"
                 ):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[4] = route_id
        self.data[5] = serial_num
        self.data[8] = clktype
        self.data[9] = userid
        self.data[10] = planid
       #�����Ӳ���۳�������
        self.data[17] = dprice
        self.data[18] = balance
        self.data[20] = cmatch
        self.data[31] = clicktime
        self.data[32] = chargetime
        self.data[35] = finance_pool_type

        #===================�޹��ֶ�Ĭ��===
        self.data[2] = "008f9bc2"
        self.data[3] = "2"
        self.data[6] = "886b259806abc849"
        self.data[7] = "725bf648728b1688108c918a23deae91"
        self.data[11] = "13"
        self.data[12] = "7"
        self.data[13] = "bdcharge"
        self.data[14] = "0"
        self.data[15] = "20"
        self.data[16] = "999.99"
        self.data[19] = "0.00000000"
        self.data[21] = "63"
        self.data[22] = "21"
        self.data[23] = "query"
        self.data[24] = "13"
        self.data[25] = "17"
        self.data[26] = "0.0.0.20"
        self.data[27] = "0.0.0.10"
        self.data[28] = "22"
        self.data[29] = "23"
        self.data[30] = "2009-08-08 08:00:00"
        self.data[33] = "strAttachTHvSkogJ8nM5VnMC_U60T1Yk0Z0qn0KW5H00UHYs0j"
        self.data[34] = "0"

class stock_data(bcmain_data):
    """
    bcmain��ע��һ���ֶ��У�from, price, stock, product_innerId, timeMillis�����������ֶζ���ʹ��
    json��ʽ:
    {
        "merchantId": 277,
        "merchantName":"�����̳�"
        "from":"api",
        "product_id": "9999120778",
        "price": "989.50",
        "stock": "989",
        "product_innerId": 22222,   //��Ʒ���Ʒ�ڲ�id
        "ucId": 6024963,
        "timeMillis": 1367897133719, 
        "offers": [
            {
                "address": "�Ϻ�",
                "price": "120.50",
                "stock": "1",
                "timeMillis": 1367897133718
            },
            {
                "address": "����",
                "price": "120.50",
                "stock": "1",
                "timeMillis": 1367897133718
            },
            ......
        ]
    },

    """
    def __init__(self, 
                 data_len = 3, 
                 id = "0",
                 flowtype = "60",
                 merchantId = 277, 
                 merchantName = u"�����̳�", 
                 source_from = "api", 
                 price = "99.9", 
                 stock = "100", 
                 product_innerId = 12345, 
                 ucId = 111, 
                 timeMillis = 1367897133719, 
                 offers = []):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        json_dict = {"merchantId":merchantId, "merchantName":merchantName, "from":source_from, "price":price, 
                     "stock":stock, "product_innerId":product_innerId, "ucId":ucId, "timeMillis":timeMillis, "offers":offers}
        #print colored("-----INPUT FLOW: \n"+str(json_dict), 'blue', attrs=['bold'])
        #json_dict["merchantName"].decode('GB18030').encode('UTF-8')
        #for cityinfo in json_dict["offers"]:
        #    cityinfo["address"].decode('GB18030').encode('UTF-8')
<<<<<<< .mine
        u8_json_dict = {}
        for k in json_dict:
            if type(json_dict[k]) is list:
                u8_list = []
                for item in json_dict[k]:
                    item_dict = {}
                    for item_key in item:
                        print type(item[item_key])
                        if type(item[item_key]) is unicode:
                            item_dict[item_key] = item[item_key].encode('utf-8')
                        else:
                            item_dict[item_key] = item[item_key]
                    for i in item_dict:
                        print type(item_dict[i])
                    u8_list.append(item_dict)
                u8_json_dict[k] = u8_list
            elif type(json_dict[k]) is unicode:
                u8_json_dict[k] = json_dict[k].encode('utf-8')
            else:
                u8_json_dict[k] = json_dict[k]
        self.data[2] = json.dumps(u8_json_dict, encoding='utf-8')
=======
        #self.data[2] = json.dumps(json_dict, encoding='utf8')
        self.data[2] = json.dumps(json_dict, ensure_ascii=False, encoding='utf8')
>>>>>>> .r70828

class stock_data_str(bcmain_data):
    """
    bcmain��ע��һ���ֶ��У�from, price, stock, product_innerId, timeMillis�����������ֶζ���ʹ��
    json��ʽ: ���಻��װjson��ֱ�����������ַ���
    """
    def __init__(self, 
                 data_len = 3, 
                 id = "0",
                 flowtype = "60",
                 json_str = u"{}"):
        bcmain_data.__init__(self, data_len = data_len)
        self.data[0] = id
        self.data[1] = flowtype
        self.data[2] = json_str.encode("UTF-8")

if __name__=='__main__':
    pass

