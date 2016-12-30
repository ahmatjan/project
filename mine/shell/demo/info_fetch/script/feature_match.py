#!/home/work/local/python27/bin/python
# -*- coding:utf-8 -*-
################################################################################
#
# Copyright (c) 2014 Baidu.com, Inc. All Rights Reserved
#
################################################################################
"""
This module match the options and spam features.

Authors: Kai Yang(yangkai04@baidu.com)
Date: 2015/10/16 12:23:06
"""

import re
import sys
import time
import getopt
import signal
import logging
import optparse
import ConfigParser
import multiprocessing

import common


class FeatureMatch(object):
    """
        match the spam feature and user options.
    """
    def __init__(self, spam_feature, opt_feature, rate, match_result):
        super(FeatureMatch, self).__init__()
        self.spam_feature = spam_feature
        self.opt_feature = opt_feature
        self.match_result = match_result
        self.rate = float(rate)
        self.term_map = {}

    def load_rules(self):
        """
            load rules from conf.
        """
        try: 
            config = ConfigParser.ConfigParser()
            config.read(common.get_confpath())
        except Exception as ex: 
            logging.error('read conf error, %s: %s' % (Exception, ex))
            return False
        return True

    def run(self):
        """
            run feature match.
        """
        try:
            with open(self.spam_feature, 'r') as ifile:
                for idx, line in enumerate(ifile):
                    fields = line.strip().split("\t")
                    if len(fields) < 4:
                        logging.error('file[%s] line[%d][%s] format error.' 
                                      % (self.ifile, idx, line))
                        continue
                    userid = fields[0]
                    term = fields[1]
                    termcnt = fields[2]
                    totalcnt = fields[3]
                    if not term in self.term_map:
                        temp_dict = {}
                        temp_dict[userid] = [termcnt, totalcnt]
                        self.term_map[term] = temp_dict
                    else:
                        if not userid in self.term_map[term]:
                            self.term_map[term][userid] = [termcnt, totalcnt]
                        else:
                            logging.error('term[%s] already has relation with userid[%s] error.' 
                                          % (term, userid))
            last_userid = "0"
            match_result = []
            with open(self.match_result, 'w') as ofile:
                with open(self.opt_feature, 'r') as ifile:
                    for idx, line in enumerate(ifile):
                        fields = line.strip().split("\t")
                        if len(fields) < 4:
                            logging.error('file[%s] line[%d][%s] format error.' 
                                          % (self.ifile, idx, line))
                            continue
                        userid = fields[0]
                        if userid != last_userid:
                            if last_userid != 0:
                                result = self.get_match_rate(match_result)
                                if result != "":
                                    newline = ("%s\t%s\n") % (last_userid, result)
                                    ofile.write("%s" % newline)
                            match_result = []
                            last_userid = userid
                        term = fields[1]
                        termcnt = fields[2]
                        totalcnt = fields[3]
                        if term in self.term_map:
                            match_result.append([term, termcnt, totalcnt, self.term_map[term]])
                result = self.get_match_rate(match_result)
                if result != "":
                    newline = ("%s\t%s\n") % (last_userid, result)
                    ofile.write("%s" % newline)
        except Exception as ex:
            logging.error('read or write file error, %s: %s' % (Exception, ex))
            return False
        return True

    def get_match_rate(self, match_result):
        """
            get match rate.
        """
        dict_rate = {}
        for [term, termcnt, totalcnt, userdict] in match_result:
            rate = float(termcnt) / float(totalcnt)
            for userid, [tmcnt, talcnt] in userdict.items():
                if userid in dict_rate:
                    dict_rate[userid] += rate
                else:
                    dict_rate[userid] = rate
        ret_list = []
        for userid, rate in dict_rate.items():
            if rate < self.rate:
                continue
            ret_list.append("%s|%0.2f" % (userid, rate))
        return ",".join(ret_list)


def main(options): 
    """the main function of this module."""
    if not common.init_log(options.conf_file): 
        logging.error("init_log error.")
        return 1
    logging.info("PROCESS BEGIN.")
    signal.signal(signal.SIGINT, common.sigint_handler)
    signal.signal(signal.SIGTERM, common.sigint_handler)
    feature_match = FeatureMatch(options.spam_feature_file, 
            options.opt_feature_file, options.rate, options.match_result_file)
    if not feature_match.load_rules():
        logging.error("load rules error.")
        return 1
    if not feature_match.run():
        logging.error("run error.")
        return 1
    logging.info("PROCESS FINISH.")
    return 0

if __name__ == '__main__': 
    usage = "usage: %prog [options] args"
    parser = optparse.OptionParser(usage=usage, version="%prog 1.0.0.0")
    parser.add_option("-s", "--spam_feature_file", action="store",
            dest="spam_feature_file",
            default="../data/spam/11.feature_filtered",
            help="userid\tword\tcnt\ttotalcnt\trate")
    parser.add_option("-i", "--opt_feature_file", action="store",
            dest="opt_feature_file",
            default="../data/opt/09.optlog_feature",
            help="userid\tword\tcnt\ttotalcnt\trate")
    parser.add_option("-o", "--match_result_file", action="store",
            dest="match_result_file",
            default="../data/opt/12.feature_matched",
            help="userid\tmatch_rate")
    parser.add_option("-c", "--config", action="store",
            dest="conf_file",
            default="../conf/conf_feature_match.conf",
            help="app configuration file")
    parser.add_option("-r", "--rate", action="store",
            dest="rate",
            default=0.9,
            help="similar rate")
    (options, args) = parser.parse_args()
    ret = main(options)
    exit(ret)


