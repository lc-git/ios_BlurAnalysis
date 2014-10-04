//
//  BlurAnalysisMethod.m
//  BlurAnalysis
//
//  Created by Chao Li on 10/4/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import "BlurAnalysisMethod.h"
#import "UIImage+OpenCV.h"

using namespace cv;

double blurAnalysis(UIImage *image){
    cv::Mat imageMat = [UIImage toCVMat:image];
    cv::Mat imageGray = toGrayImage(imageMat);
    
    double blur = detectBlur(imageGray);
    //UIImage *newImage = [UIImage fromCVMat:imageGray];
    //self.selectedImage = newImage;
    
    return blur;
}

double detectBlur(const cv::Mat& grayMat){
    //    //FFT
    //    //    int m = grayMat.rows;
    //    //    int n = grayMat.cols;
    //    Mat smallCentreMat;
    //    //    CvRect smallCentreRect = cvRect(n/6,m/6,2*n/3,2*m/3);
    //    //    smallCentreMat = grayMat(smallCentreRect);
    //    smallCentreMat = grayMat;
    //    NSLog(@"small r&c,%i,%i",smallCentreMat.rows,smallCentreMat.cols);
    //    NSLog(@"%i",smallCentreMat.channels());
    //    Mat planes[] = {Mat_<float>(smallCentreMat),Mat::zeros(smallCentreMat.size(), CV_32F)};
    //    Mat complexI;
    //    merge(planes, 2, complexI);
    //    dft(complexI, complexI);
    //    split(complexI, planes);
    //    magnitude(planes[0], planes[1], planes[0]);
    //    Mat magI = planes[0];
    //    Scalar tmpVal = mean(magI);
    //    float averageFreq = tmpVal.val[0];
    //    NSLog(@"Mean: %f",averageFreq);
    
    
    //laplace
    Mat lapMat,GaussianMat;
    double minVal;
    double maxVal;
    cv::Point minLoc;
    cv::Point maxLoc;
    GaussianBlur(grayMat, GaussianMat, cv::Size(3,3),0.0);
    Laplacian(GaussianMat, lapMat, CV_16S,1);
    minMaxLoc(lapMat, &minVal, &maxVal, &minLoc, &maxLoc );
    NSLog(@"laplace: %f",maxVal);
    
    return maxVal;
}

cv::Mat toGrayImage(const cv::Mat& cvMat){
    cv::Mat image = cvMat;
    cv::Mat imageGray;
    cv::Mat imageGrayScaled;
    
    switch (cvMat.channels()) {
        case 4:
            cv::cvtColor(image, imageGray, CV_BGRA2GRAY);
            break;
        case 3:
            cv::cvtColor(image, imageGray, CV_BGR2GRAY);
            break;
        case 1:
            imageGray = image;
            break;
    }
    return imageGray;
    
}
