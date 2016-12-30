import sys;

def iconv(inputfilename, linenum, outputfilename):
	writter = open(outputfilename, "ab");
	reader = open(inputfilename, "r");
	lineno = 0;
	for line in reader:
		lineno = lineno+1;
		if (lineno > int(linenum)):
			writter.write(line.decode('gbk').encode('utf-8'));

print sys.argv;
if (4 != len(sys.argv)):
	print "param num error!";
	exit(1);

iconv(sys.argv[1], sys.argv[2], sys.argv[3]);
