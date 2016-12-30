#coding=utf8
import os

partname_array=["省","县","市","区","矿区","自治","回族","地区","林区","山区","新区","畲族","满族","蒙古","朝鲜族","斡尔族","土家族","苗族","瑶族","侗族","壮族","各族","仫佬族","毛南族","群岛","黎族","羌族","彝族","藏族","仡佬族","布依族","水族","哈尼族","傣族","拉祜族","佤族","白族","傈僳族","独龙族","怒族","普米族","固族","哈萨克族","保安族","东乡族","撒拉族","土族","特别行政区","维吾尔"]

with open("city_code","r") as reader:
	for line in reader.readlines():
		line_array=line.replace("\n","").split("\t")
		cityid=line_array[0]
		cityname=line_array[1]
		if (len(line_array)!=2):
			print "error line[%s]" % line
			continue
		print "%s\t%s" %(cityname, cityid)
		for partname in partname_array:
			pos = cityname.find(partname)
			if 0 < pos:
				print "%s\t%s" %( cityname[:pos], cityid)
