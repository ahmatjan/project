last_file_time = 0
last_line_num = 0

def iconv(file_name, line_num, out_file):
    lines = open(file_name, 'rb').readlines()
    if line_num >= len(lines):
        return None
    out_writer = open(out_file, 'ab')
    for line in lines[line_num:]:
       out_writer.write(line.decode('gkb').encode('utf-8'))
    out_writer.close()
    return len(lines)

def parse_file_name(file_name):
    # outputflow.20120303-0015.log
    time_str = file_name.split('.')[1]
    return int(time_str.replace('-', ''))

def main(dir):
    files = os.listdir(dir)
    for i in range(len(files)):
        file = files[i]
        if parse_file_name(file) == last_file_time:
            line_num = iconv(file, last_line_num, )
            if line_num == None:
                if i < len(os.listdir(dir)):
                    last_line_num = 0
                    continue
        elif parse_file_name(file) > last_file_time:
            last_file_time = parse_file_name(file)
            line_num = iconv(file, last_line_num)
            if line_num is not None:
                last_line_num = line_num

     
