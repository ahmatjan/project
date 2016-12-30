#encoding:utf-8

import binascii
import os
import os.path
import sys
import random
import base64

#定义标准码表和百度码表
baidu_base64_alphabet = "0KajD7AZcF2QnPr5fwiHRNygmupUTIXx69BWb-hMCGJo_V8Eskz1YdvL34letqSO"
standard_base64_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

# 定义k域编码的函数
# ps: 特别注意 传入str中的 不同的 kv  需要预处理采用 \0 分割
# @param 待编码的字符串
# @return 成功 返回编码成功的字符串  失败 返回None
def encode_k(str):
    ret = None
    
    # 建立两个码表的映射字典
    related_dict = {} 
    for i in range(len(baidu_base64_alphabet)):
        related_dict[standard_base64_alphabet[i]] = baidu_base64_alphabet[i]
    
    # 进行k域的编码操作
    encode_str_1 = base64.b64encode(str)
    encode_str_1 = encode_str_1.replace("=", "")
    encode_str_2 = ""
    for element in encode_str_1:
        encode_str_2 += related_dict[element]
    
    ret = encode_str_2
    return ret       

# 定义k域解码的函数
# @param 待编码的字符串
# @return 成功 返回解码成功的字符串 失败 返回None
def decode_k(str):
    ret = None

    # 建立两个码表的映射字典
    related_dict ={}
    for i in range(len(baidu_base64_alphabet)):
        related_dict[baidu_base64_alphabet[i]] = standard_base64_alphabet[i]
        
    # 进行k域的解码操作
    decode_str_1 = ""
    decode_str_2 = ""
    for element in str:
        decode_str_1 += related_dict[element]
    fill_num = len(str)%4
    for i in range(4 - fill_num):
        decode_str_1 += '='
        
    decode_str_2 = base64.b64decode(decode_str_1)
    ret =  decode_str_2
    return ret

# steaming 处理
for line in sys.stdin:
	line_list = line.strip('\n').split('\t')
	k_str=decode_k(line_list[0].replace("%D", ""))
	if k_str.find("zt=wb") == -1:
		print k_str
