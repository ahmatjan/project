#encoding:utf-8

import binascii
import os
import os.path
import sys
import random
import base64

#�����׼���Ͱٶ����
baidu_base64_alphabet = "0KajD7AZcF2QnPr5fwiHRNygmupUTIXx69BWb-hMCGJo_V8Eskz1YdvL34letqSO"
standard_base64_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

# ����k�����ĺ���
# ps: �ر�ע�� ����str�е� ��ͬ�� kv  ��ҪԤ������� \0 �ָ�
# @param ��������ַ���
# @return �ɹ� ���ر���ɹ����ַ���  ʧ�� ����None
def encode_k(str):
    ret = None
    
    # ������������ӳ���ֵ�
    related_dict = {} 
    for i in range(len(baidu_base64_alphabet)):
        related_dict[standard_base64_alphabet[i]] = baidu_base64_alphabet[i]
    
    # ����k��ı������
    encode_str_1 = base64.b64encode(str)
    encode_str_1 = encode_str_1.replace("=", "")
    encode_str_2 = ""
    for element in encode_str_1:
        encode_str_2 += related_dict[element]
    
    ret = encode_str_2
    return ret       

# ����k�����ĺ���
# @param ��������ַ���
# @return �ɹ� ���ؽ���ɹ����ַ��� ʧ�� ����None
def decode_k(str):
    ret = None

    # ������������ӳ���ֵ�
    related_dict ={}
    for i in range(len(baidu_base64_alphabet)):
        related_dict[baidu_base64_alphabet[i]] = standard_base64_alphabet[i]
        
    # ����k��Ľ������
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

# steaming ����
for line in sys.stdin:
	line_list = line.strip('\n').split('\t')
	k_str=decode_k(line_list[0].replace("%D", ""))
	if k_str.find("zt=wb") == -1:
		print k_str
