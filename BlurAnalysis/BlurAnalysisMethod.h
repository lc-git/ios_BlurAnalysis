//
//  BlurAnalysisMethod.h
//  BlurAnalysis
//
//  Created by Chao Li on 10/4/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <opencv2/opencv.hpp>

double blurAnalysis(UIImage *image);
double detectBlur(const cv::Mat& grayMat);
cv::Mat toGrayImage(const cv::Mat& cvMat);