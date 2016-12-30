#!/usr/bin/env python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module provide the process class including producer and consumer.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2014/11/11 12:23:06
"""

import time
import signal
import logging
import ConfigParser
import multiprocessing

import common
import segfile

class ProcessBase(multiprocessing.Process): 
    """base data process class, base on multiprocessing.Process.
       
    base class for data processing. the class provide the signal and log function.
    the class put the process in to three parts: pre -> proc -> post

    Attributes:
        isalive: A boolean means the process if continue to proc. True: continue, False: break.
        inited: A boolean means the process if inited. True: inited, False: not inited.
    """
 
    def __init__(self): 
        super(ProcessBase, self).__init__()
        self.isalive = True
        self.inited = False

    def init(self):
        """before run. this func will prepare for process. eg: read conf, open file
        
        Args:
            None

        Returns:
            True: init succ.
            False: init fail.

        Raises:
            None
        """
        self.inited = True
        return True

    def handler(self, signum, frame): 
        """handle the sigint signal for the process class."""
        self.isalive = False

    def run(self): 
        """the main function of the process. include three parts: pre->proc->post"""
        logging.info(
            "class[%s] process start." 
            % (self.__class__.__name__))
        signal.signal(signal.SIGINT, self.handler) 
        signal.signal(signal.SIGTERM, self.handler)
        if not self.pre(): 
            logging.error(
                "class[%s] process pre fail." 
                % (self.__class__.__name__))
            return 1
        if not self.inited:
            logging.error(
                "class[%s] process not inited will not run." 
                % (self.__class__.__name__))
            return 1
        while self.isalive: 
            if not self.proc(): 
                logging.info(
                    "class[%s] process proc fail." 
                    % (self.__class__.__name__))
        if not self.post(): 
            logging.error(
                "class[%s] process post fail." 
                % (self.__class__.__name__))
            return 1
        logging.info(
            "class[%s] process finish." 
            % (self.__class__.__name__))
        return 0

    def pre(self): 
        """the first function in the run function. run once"""
        return True

    def proc(self): 
        """the main function in the run function. run circle"""
        return True

    def post(self): 
        """the last function in the run function. run once"""
        return True


class ProducerProcess(ProcessBase): 
    """producer process class base on ProcessBase.

    process to product data and write to output segment file.
       
    Attributes:
        osegfile: A handle to an output segment file.
    """
    def __init__(self): 
        super(ProducerProcess, self).__init__()
        self.osegfile = None

    def init(self): 
        """
        the function called before run. initialise.

        Args:
            None

        Returns:
            True: init succ.
            False: init fail.

        Raises:
            None
        """
        try: 
            config = ConfigParser.ConfigParser()
            config.read(common.get_confpath())
            path = config.get("datachange", "path")
            prefix = config.get("datachange", "prefix")
            postfix = config.get("datachange", "postfix")
            cycle = config.getint("datachange", "cycle")
        except Exception as ex: 
            logging.error('read conf to get datachange section error, %s: %s' % (Exception, ex))
            return False
        try: 
            self.osegfile = segfile.OSegfile(path, prefix, postfix, cycle)
            if not self.osegfile.open(): 
                logging.error("open osegfile[%s] error." % self.osegfile.get_filename())
                return False
        except Exception as ex: 
            logging.error('open osegfile error, %s: %s' % (Exception, ex))
            return False
        self.inited = True
        return True

    def proc(self): 
        """the main func in run."""
        line = self.produce()
        if not self.osegfile.writeline(line): 
            logging.error("osegfile writeline error.")
            return False
        return True

    def produce(self): 
        """function to produce data. this func only an example."""
        # TODO: implement a real producer. $yangkai$2014-12-05$
        time.sleep(1)
        line = "test ouput and input"
        print("class[%s] process write line: [%s]" 
            % (self.__class__.__name__, line))
        return line

    def post(self):
        if self.osegfile is not None:
            self.osegfile.close()
        return True


class ConsumerProcess(ProcessBase): 
    """consumer process class base on ProcessBase.

    process to consume data from input segment file.
       
    Attributes:
        process_no: The process number.
        idxdict: A share dict between ctrl process and Consumer process, to load and dump index.
        isegfile: A handle to an input segment file.
    """
    def __init__(self, process_no, idxdict): 
        super(ConsumerProcess, self).__init__()
        self.process_no = process_no
        self.idxdict = idxdict
        self.isegfile = None

    def init(self, ftimestamp, fpos): 
        """
        the function called before run.

        Args:
            ftimestamp: A string means time stamp for file to be opened. eg: 20141111-0000
            fpos: An integer means the pos from file to begin to read. eg: 0 means from begin

        Returns:
            True: init succ.
            False: init fail.

        Raises:
            None
        """
        try: 
            config = ConfigParser.ConfigParser()
            config.read(common.get_confpath())
            path = config.get("datachange", "path")
            prefix = config.get("datachange", "prefix")
            postfix = config.get("datachange", "postfix")
            cycle = config.getint("datachange", "cycle")
        except Exception as ex: 
            logging.error('read conf to get datachange section error, %s: %s' % (Exception, ex))
            return False
        try: 
            self.isegfile = segfile.ISegfile(path, prefix, postfix, cycle)
            if not self.isegfile.open(ftimestamp, fpos): 
                logging.error("open isegfile[%s] error." % self.isegfile.get_filename())
                return False
        except Exception as ex: 
            logging.error('open isegfile error, %s: %s' % (Exception, ex))
            return False
        self.inited = True
        return True

    def proc(self): 
        """the main func in run."""
        try: 
            line = self.isegfile.readline()
            self.consume(line)
            self.idxdict[self.process_no] = self.isegfile.getidxstr()
        except Exception as ex: 
            logging.error('read line error, %s: %s' % (Exception, ex))
            return False
        time.sleep(1)
        return True

    def consume(self, line): 
        """function to consume data. this func only an example."""
        # TODO: implement a real consumer. $yangkai$2014-12-05$
        if line.strip(): 
            print(
                "class[%s] process[%d] read line: [%s]" 
                % (self.__class__.__name__, self.process_no, line))

    def post(self):
        if self.isegfile is not None:
            self.isegfile.close()
        return True


class CentralCtrl(ProcessBase): 
    """central control process class base on ProcessBase.

    process to control producer and consumer processes.
       
    Attributes:
        producerprocess: means the producer process.
        consumerprocessmap: means the group of consumer process.
        idx_path: means the idx file path. 
                  the consumer process map init isegfile from idx file.
                  and the central control dump idx file every period.
        idxstr_dict: means all the file pos of consumer processes. 
                     the multiprocessing.Manager help to share between processes.
    """
    def __init__(self): 
        super(CentralCtrl, self).__init__()
        self.producerprocess = None
        self.consumerprocessmap = {} 
        self.consumerprocess_num = 0
        self.idx_path = ""
        mgr = multiprocessing.Manager()
        self.idxstr_dict = mgr.dict()

    def pre(self): 
        """
            function to init all the process(a producer and N consumer) to be ready 
            and start them all.
        """
        if not self.init():
            return False
        self.producerprocess = ProducerProcess()
        if not self.producerprocess.init(): 
            return False
        try: 
            config = ConfigParser.ConfigParser()
            config.read(common.get_confpath())
            self.consumerprocess_num = config.getint("consumerprocess", "process_num")
            self.idx_path = config.get("idx", "idx_path")
        except Exception as ex: 
            logging.error(
                'read conf to get consumerprocess section error, %s: %s' 
                % (Exception, ex))
            return False
        try: 
            with open(self.idx_path) as idx_file: 
                for line in idx_file: 
                    linevalues = line.strip().split("\t")
                    if len(linevalues) < 3: 
                        logging.error(
                            "the line[%s] of idxfile[%s] error." 
                            % (line, self.idx_path))
                        return False
                    process_no = (int)(linevalues[0])
                    ftimestamp = linevalues[1]
                    fpos = (int)(linevalues[2])
                    self.idxstr_dict[process_no] = "%s\t%d" % (ftimestamp, fpos)
                    if process_no in self.consumerprocessmap: 
                        logging.error("process[%d] repeat error." % process_no)
                        return False
                    self.consumerprocessmap[process_no] = ConsumerProcess(process_no, 
                        self.idxstr_dict)
                    if not self.consumerprocessmap[process_no].init(ftimestamp, fpos): 
                        logging.error("consumer process[%d] init error." % process_no)
                        return False
        except Exception as ex: 
            logging.error('read idx file error, %s: %s' % (Exception, ex))
            return False
        if len(self.consumerprocessmap) != self.consumerprocess_num: 
            logging.error(
                "process number[%d] in idx != process number[%d] in conf." 
                % (len(self.consumerprocessmap), self.consumerprocess_num))
            return False
        for process_no in range(self.consumerprocess_num): 
            if process_no not in self.consumerprocessmap: 
                logging.error(
                    "process_no[%d] not in idx_file != process number[%d] in conf." 
                    % (process_no, self.consumerprocess_num))
                return False
        try: 
            # start sub process
            self.producerprocess.start()
            for process_no, process_handle in self.consumerprocessmap.iteritems(): 
                process_handle.start()
        except Exception as ex: 
            logging.error('sub process start error, %s: %s' % (Exception, ex))
            return False
        return True

    def proc(self): 
        """the main func in run."""
        time.sleep(1)
        return self.dumpidx()

    def dumpidx(self): 
        """function to dump all the consumerprocess timestamp and file pos to idx file."""
        try: 
            with open(self.idx_path, 'w') as idx_file:
                for process_no, process_idxstr in self.idxstr_dict.items(): 
                    idx_file.write("%s\t%s\n" % (process_no, process_idxstr))
        except Exception as ex: 
            logging.error('open idx file[%s] error, %s: %s' % (self.idx_path, Exception, ex))
            return False
        return True

    def post(self): 
        """function to wait all the sub process to be finished."""
        if not self.dumpidx():
            return False
        try: 
            self.producerprocess.join()
            for process_no, process_handle in self.consumerprocessmap.iteritems(): 
                process_handle.join()
        except Exception as ex: 
            logging.error('sub process join error, %s: %s' % (Exception, ex))
            return False
        return True

