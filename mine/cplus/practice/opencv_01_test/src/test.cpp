#include "test.h"

#include <iostream> 

#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>


using namespace cv;
using namespace std;

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
    int inner_main(int argc, char *argv[]) {
#endif
    string imgname = "../data/1.jpg";
    //从文件中读入图像
    Mat img = imread(imgname);
    //如果读入图像失败
    if(img.empty()) {
        return -1;
    }
    //显示图像
    imshow("image", img);
    //此函数等待按键，按键盘任意键就返回
    waitKey();
    return 0;
}
