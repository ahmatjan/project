#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module provide input segment file and output segment file.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import os
import sys
import time
import signal
import logging
import threading

class Segfile(object): 
    """base file operation class.
       
    base class for writing and reading segment file. the file segment by time cycle. 
    file path name eg: /home/work/var/clkdata/20141111/clk.20141111-0000.log

    Attributes:
        path: A string means file path. eg: /home/work/var/clkdata
        prefix: A string means file name prefix. eg: clk.
        postfix: A string means file name postfix. eg: .log
        cycle: An integer means file segment cycle. eg: 900 means 15mins
        ftimestamp: A string means file timestamp. eg: 20141111-0000
        fpos: An integer means the pos from file to begin to read. eg: 0 means from begin
        file_fp: An handle to the open file.
        filename: The filename of the open file.
    """
    def __init__(self, path, prefix, postfix, cycle): 
        super(Segfile, self).__init__()
        self.path = path
        self.prefix = prefix
        self.postfix = postfix
        self.cycle = cycle
        self.ftimestamp = ""
        self.fpos = 0
        self.file_fp = None
        self.filename = ""

    def nextfileexist(self): 
        """function to return nextfile if exist."""
        return os.path.isfile(self.get_nextfilename())

    def close(self): 
        """
        function to close the file opened.

        Args:
            None

        Returns:
            None

        Raises:
            None
        """
        if self.file_fp is not None and not self.file_fp.closed: 
            self.file_fp.close()

    def desc(self): 
        """function to describe the main property."""
        return "path[%s] prefix[%s] postfix[%s] cycle[%d] ftimestamp[%s] fpos[%d]" \
            % (self.path, self.prefix, self.postfix, self.cycle, self.ftimestamp, self.fpos)

    def set_filename(self): 
        """function to set filename."""
        day = self.ftimestamp[0: 8]
        fname = "%s%s%s" % (self.prefix, self.ftimestamp, self.postfix)
        self.filename = "%s/%s/%s" % (self.path, day, fname)
        return

    def get_filename(self): 
        """function to get file name."""
        return self.filename

    def get_nextfilename(self): 
        """function the get next file name."""
        nexttimesec = int(self.gettimesecs(self.ftimestamp) + self.cycle)
        nexttimestamp = self.gettimestamp(nexttimesec, "%Y%m%d-%H%M")
        day = nexttimestamp[0: 8]
        fname = "%s%s%s" % (self.prefix, nexttimestamp, self.postfix)
        filename = "%s/%s/%s" % (self.path, day, fname)
        return filename

    def gettimesecs(self, timestamp): 
        """function to get the UTC seconds of timestamp."""
        year = int(timestamp[0: 4])
        month = int(timestamp[4: 6])
        day = int(timestamp[6: 8])
        hour = int(timestamp[9: 11])
        minutes = int(timestamp[11: 13])
        timelist = [year, month, day, hour, minutes, 0, 0, 0, 0]
        return time.mktime(timelist)

    def gettimestamp(self, timesecs, formatstr): 
        """function to get the timestamp of the UTC seconds."""
        return time.strftime(formatstr, time.localtime(timesecs))

    def getidxstr(self): 
        """function to get the idx tring."""
        return "%s\t%d" % (self.ftimestamp, self.fpos)

    def getnowtimestamp(self): 
        """function to get now timestamp."""
        timesec = int(time.time() / self.cycle) * self.cycle
        return self.gettimestamp(timesec, "%Y%m%d-%H%M")


class ISegfile(Segfile): 
    """reading file operation class, base on Segfile.
       
    class for reading segment file. the file segment by time cycle. 
    file path name eg: /home/work/var/clkdata/20141111/clk.20141111-0000.log

    Attributes:
        retrylimit: An integer means try how many times when the current file
                    reach end and next file exists to turn to next file
        retrytimes: An integer means already try how many times when the current file
                    reach end and next file exists.
    """
    def __init__(self, path, prefix, postfix, cycle): 
        super(ISegfile, self).__init__(path, prefix, postfix, cycle)
        self.retrylimit = 5
        self.retrytimes = 0

    def open(self, ftimestamp, fpos): 
        """
        function to open file for reading.

        Args:
            ftimestamp: A string means time stamp for file to be opened. eg: 20141111-0000
            fpos: An integer means the pos from file to begin to read. eg: 0 means from begin

        Returns:
            False: open failed.
            True: open successfully.

        Raises:
            None
        """
        if self.cycle <= 60:
            logging.error(
                'file cycle[%d] <= 60 error, file: [%s], %s: %s'
                % (self.cycle, self.filename, Exception, ex))
            return False
        self.ftimestamp = ftimestamp
        self.fpos = fpos
        self.set_filename()
        self.close()
        if not os.path.isfile(self.filename): 
            logging.error("file[%s] not exist!" % self.filename)
            return False
        try: 
            self.file_fp = open(self.filename)
        except Exception as ex: 
            logging.error(
                'open file error, file: [%s], %s: %s'
                % (self.filename, Exception, ex))
            return False
        try: 
            self.file_fp.seek(self.fpos)
        except Exception as ex: 
            logging.error(
                'seek file error, file: [%s], %s: %s'
                % (self.filename, Exception, ex))
            return False
        self.retrytimes = 0
        logging.info("isegfile file[%s] open succ. pos[%d]" % (self.filename, self.fpos))
        return True

    def readline(self): 
        """
        function to read a line from reading file.

        Args:
            None

        Returns:
            The line from the input file.

        Raises:
            None
        """
        line = ""
        try: 
            line = self.file_fp.readline()
        except Exception as ex: 
            logging.error(
                'readline error, file: [%s], %s: %s'
                % (self.filename, Exception, ex))
            raise Exception('file[%s] not open' % self.get_filename())
            return ""
        if line != "": 
            self.retrytimes = 0
            self.fpos = self.file_fp.tell()
            return line.strip()
        if self.nextfileexist(): 
            if self.retrytimes > self.retrylimit: 
                nexttimesec = int(self.gettimesecs(self.ftimestamp) + self.cycle)
                nexttimestamp = self.gettimestamp(nexttimesec, "%Y%m%d-%H%M")
                if not self.open(nexttimestamp, 0): 
                    logging.error(
                        'open file error, file: [%s], %s: %s'
                        % (self.filename, Exception, ex))
            self.retrytimes += 1
        time.sleep(1)
        return ""


class OSegfile(Segfile): 
    """writing file operation class, base on Segfile.
       
    class for writing segment file. the file segment by time cycle. 
    file path name eg: /home/work/var/clkdata/20141111/clk.20141111-0000.log

    """
    def __init__(self, path, prefix, postfix, cycle): 
        super(OSegfile, self).__init__(path, prefix, postfix, cycle)
        self.ftimestamp = self.getnowtimestamp()

    def open(self): 
        """
        function to open the file for writing.

        Args:
            None

        Returns:
            False: open failed.
            True: open successfully.

        Raises:
            None
        """
 
        if self.cycle <= 60:
            logging.error(
                'file cycle[%d] <= 60 error, file: [%s], %s: %s'
                % (self.cycle, self.filename, Exception, ex))
            return False
        self.set_filename()
        self.close()
        dirname = os.path.dirname(self.filename)
        try:
            if os.path.isfile(dirname):
                logging.error('dirname[%s] be file error!' % dirname)
                return False
            if not os.path.isdir(dirname): 
                os.mkdir(dirname)
        except Exception as ex: 
            logging.error(
                'create dir error, dir: [%s], %s: %s'
                % (dirname, Exception, ex))
            return False
        try: 
            self.file_fp = open(self.filename, 'a+')
        except Exception as ex: 
            logging.error(
                'open file error, file: [%s], %s: %s'
                % (self.filename, Exception, ex))
            return False
        self.file_fp.seek(0, os.SEEK_END)
        self.fpos = self.file_fp.tell()
        logging.info("osegfile file[%s] open succ. pos[%d]" % (self.filename, self.fpos))
        return True

    def writeline(self, line): 
        """
        function to write a line to the file.

        Args:
            line: A string to be written to the current file.

        Returns:
            False: open failed.
            True: open successfully.

        Raises:
            None
        """
        ftimestamp = self.getnowtimestamp()
        while self.ftimestamp != ftimestamp: 
            ftimesecs = self.gettimesecs(self.ftimestamp)
            curtimesecs = self.gettimesecs(ftimestamp)
            if ftimesecs > curtimesecs:
                logging.error(
                    "ftime[%s] bigger than curtime[%s] error." 
                    % (self.ftimestamp, ftimestamp))
                return False
            nexttimesec = int(ftimesecs + self.cycle)
            nexttimestamp = self.gettimestamp(nexttimesec, "%Y%m%d-%H%M")
            if nexttimestamp == self.ftimestamp:
                logging.error(
                    "nexttimestamp[%s] == ftimestamp[%s] error." 
                    % (nexttimestamp, self.ftimestamp))
                return False
            self.ftimestamp = nexttimestamp
            if not self.open(): 
                logging.error("file[%s] open fail." % self.filename)
                return False
        try:
            self.file_fp.write("%s\n" % line)
            self.file_fp.flush()
        except Exception as ex: 
            logging.error(
                'write line[%s] to file[%s] error: %s: %s'
                % (line, self.filename, Exception, ex))
            return False
        return True


