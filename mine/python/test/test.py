#!/home/yangkai/local/python27/bin/python
import os,time

print time.time()
timestr = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
#timearray=timestr.replace("-"," ").replace(":"," ").split(" ").append("0").append("0")
#print timearray
print time.mktime(time.strptime(timestr, "%Y-%m-%d %H:%M:%S"))
