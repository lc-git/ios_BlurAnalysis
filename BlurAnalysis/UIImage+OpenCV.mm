//
//  UIImage+OpenCV.m
//  BlurAnalysis
//
//  Created by Chao Li on 10/4/14.
//  Copyright (c) 2014 Columbia. All rights reserved.
//

#import "UIImage+OpenCV.h"

@implementation UIImage (OpenCV)

+(cv::Mat)toCVMat:(UIImage *)image{
    
    CGFloat cols = image.size.height;
    CGFloat rows = image.size.width;
    
    cv::Mat cvMat(rows,cols,CV_8UC4);
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data, cols, rows, 8, cvMat.step[0], CGImageGetColorSpace(image.CGImage), kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    
    float m_scaleFactor = 2.0;
    float h = cvMat.rows / m_scaleFactor;
    float w = cvMat.cols / m_scaleFactor;
    NSLog(@"h&w: %f,%f",h,w);
    
    cv::Mat imageScaled;
    cv::resize(cvMat, imageScaled, cv::Size(w,h));
    NSLog(@"cvmat channel: %i",imageScaled.channels());
    return imageScaled;
}

-(cv::Mat)toCVMat{
    return [UIImage toCVMat:self];
}

+(UIImage *)fromCVMat:(const cv::Mat &)cvMat{
    // (1) Construct the correct color space
    CGColorSpaceRef colorSpace;
    NSLog(@"function fromCVMat: %i",cvMat.channels());
    if ( cvMat.channels() == 1 ) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    // (2) Create image data reference
    CFDataRef data = CFDataCreate(kCFAllocatorDefault, cvMat.data, (cvMat.elemSize() * cvMat.total()));
    
    // (3) Create CGImage from cv::Mat container
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGImageRef imageRef = CGImageCreate(cvMat.cols,
                                        cvMat.rows,
                                        8,
                                        8 * cvMat.elemSize(),
                                        cvMat.step[0],
                                        colorSpace,
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,
                                        provider,
                                        NULL,
                                        false,
                                        kCGRenderingIntentDefault);
    
    // (4) Create UIImage from CGImage
    //UIImage * finalImage = [UIImage imageWithCGImage:imageRef];
    UIImage *finalImage = [[UIImage alloc]initWithCGImage:imageRef scale:1 orientation:UIImageOrientationRight];
    // (5) Release the references
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CFRelease(data);
    CGColorSpaceRelease(colorSpace);
    
    // (6) Return the UIImage instance
    return finalImage;
}


@end
