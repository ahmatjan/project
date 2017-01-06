import sys
sys.path.append("/home/yangkai04/project/mine/cplus/third/caffe/python/")
sys.path.append("/home/yangkai04/project/mine/cplus/third/caffe/python/caffe")

import caffe
import caffe.draw
from caffe.proto import caffe_pb2
from google.protobuf import text_format

# Set the parameters
input_net_proto_file = 'test_net.prototxt' # net configuration file
output_image_file ='test_net.jpg' # the output image
# net arrange method: LR,TB,RL
rankdir ='LR' 

# Read the net
net = caffe_pb2.NetParameter()
text_format.Merge(open(input_net_proto_file).read(), net)

# Draw the net
print('Drawing net to %s' % output_image_file)
caffe.draw.draw_net_to_file(net, output_image_file, rankdir)
print('done...')
