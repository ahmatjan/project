#include <cuda_runtime.h>
#include <fstream>
#include <iostream>
#include <cstring>
#include <cstdlib>
#include <algorithm>
#include <vector>
#include <utility>
#include "caffe/proto/caffe.pb.h"
#include "caffe/caffe.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/highgui/highgui_c.h>
#include <opencv2/imgproc/imgproc.hpp>

using std::make_pair;
using std::pair;
using namespace caffe;  // NOLINT(build/namespaces)
using namespace std;

vector<string> fileNames;
char * filelist;

/*
 * 读入的文件的内容格式类似这样子的：全局id 类名_所在类的id.jpg
0 一步裙_0.jpg
1 一步裙_1.jpg
2 一步裙_10.jpg
 */
void readFile()
{
	if(fileNames.empty())
	{
		ifstream read(filelist);
		//"/home/linger/linger/testfile/test_attachment/image_filename"
		// "/home/linger/imdata/test_files_collar.txt"
		//  "/home/linger/linger/testfile/testfilename"
		if(read.is_open())
		{
			while(!read.eof())
			{
				string name;
				int id;
				read>>id>>name;
				fileNames.push_back(name);
			}
		}
	}
}

/*
 * 根据图片id获取类名
 */
string getClassNameById(int id)
{
	readFile();
	int index = fileNames[id].find_last_of('_') ;
	return fileNames[id].substr(0, index);
}



void writeBatch(const float* data,int num,int channels,int width,int height,int startID,const char*dir)
{
	for(int id = 0;id<num;id++)
	{
		for(int channel=0;channel<channels;channel++)
		{
			cv::Mat mat(height,width, CV_8UC1);//高宽
			vector<vector<float> > vec;
			vec.resize(height);
			float max = -1;
			float min = 999999;
			for(int row=0;row<height;row++)
			{
				vec[row].resize(width);
				for(int col=0;col<width;col++)
				{
					vec[row][col] =
							data[id*channels*width*height+channel*width*height+row*width+col];
					if(max<vec[row][col])
					{
						max = vec[row][col];
					}
					if(min>vec[row][col])
					{
						min = vec[row][col];
					}


				}
			}

			for(int row=0;row<height;row++)
			{
			  	for(int col=0;col<width;col++)
				{
					vec[row][col] = 255*((float)(vec[row][col]-min))/(max-min);
					uchar& img = mat.at<uchar>(row,col);
					img= vec[row][col];

				}
			}
			char filename[100];
			string label = getClassNameById(startID+id);
			string file_reg =dir;
			file_reg+="%s%05d_%05d.png";
			snprintf(filename, 100, file_reg.c_str(), label.c_str(),startID+id,channel);
			//printf("%s\n",filename);
			cv::imwrite(filename, mat);
		}

	}
}

int main(int argc, char** argv)
{
  if (argc < 4)
  {
    LOG(ERROR) << "visualize_features.bin net_proto pretrained_net_proto iterations "
        << "[CPU/GPU] img_list_file dstdir laydepth";
    return 0;
  }
  /*

  ./visualize_features.bin /home/linger/linger/caffe-action/caffee-ext/Caffe_MM/prototxt/triplet/triplet_test_simple.prototxt /home/linger/linger/caffe-action/caffee-ext/Caffe_MM/snapshorts/_iter_100000 8 GPU /home/linger/linger/testfile/test_attachment/image_filename /home/linger/linger/testfile/innerproduct/ 6

  */

  filelist = argv[5];
  cudaSetDevice(0);
  //caffe::set_phase(caffe::TEST);

  if (argc == 5 && strcmp(argv[4], "GPU") == 0)
  {
    LOG(ERROR) << "Using GPU";
    Caffe::set_mode(Caffe::GPU);
  }
  else
  {
    LOG(ERROR) << "Using CPU";
    Caffe::set_mode(Caffe::CPU);
  }

  NetParameter test_net_param;
  ReadProtoFromTextFile(argv[1], &test_net_param);
  Net<float> caffe_test_net(test_net_param);
  NetParameter trained_net_param;
  ReadProtoFromBinaryFile(argv[2], &trained_net_param);
  caffe_test_net.CopyTrainedLayersFrom(trained_net_param);

  int total_iter = atoi(argv[3]);
  LOG(ERROR) << "Running " << total_iter << " Iterations.";

  double test_accuracy = 0;
  vector<Blob<float>*> dummy_blob_input_vec;

  int startID = 0;
  int nums;
  int dims;
  int batchsize = test_net_param.layers(0).layer().batchsize();

  int laynum = caffe_test_net.bottom_vecs().size();
  printf("num of layers:%d\n",laynum);

  for (int i = 0; i < total_iter; ++i)
  {
    const vector<Blob<float>*>& result =
        caffe_test_net.Forward(dummy_blob_input_vec);

    int laydepth = atoi(argv[7]);

    Blob<float>* features = (*(caffe_test_net.bottom_vecs().begin()+laydepth))[0];//调整第几层即可

    nums = features->num();
    dims= features->count()/features->num();

    int num = features->num();
    int channels = features->channels();
    int width = features->width();
    int height = features->height();
    printf("channels:%d,width:%d,height:%d\n",channels,width,height);
    writeBatch(features->cpu_data(),num,channels,width,height,startID,argv[6]);
    startID += nums;

  }

  return 0;
}
