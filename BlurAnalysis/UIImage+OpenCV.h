//
//  UIImage+OpenCV.h
//  BlurAnalysis
//
//  Created by Chao Li on 10/4/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <opencv2/opencv.hpp>

@interface UIImage (OpenCV)

#pragma mark Generate UIImage from cv::Mat
+ (UIImage*)fromCVMat:(const cv::Mat&)cvMat;

#pragma mark Generate cv::Mat from UIImage
+ (cv::Mat)toCVMat:(UIImage *)image;
- (cv::Mat)toCVMat;

@end
