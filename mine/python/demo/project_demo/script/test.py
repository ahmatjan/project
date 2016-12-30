#!/usr/bin/env python

#dict={}
#baseconfidence = float(dict.get('confidence'))

#import os
#if os.path.exists("test.py"):
#    print "exist"

with open("outputfile", "ab") as outfp:
    with open("inputfile", "rb") as infp:
        while True:
            buf = infp.read(1024)
            if len(buf) > 0:
                outfp.write(buf)
            else:
                break

