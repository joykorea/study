//
//  setViewController.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setViewController : UIViewController

typedef NS_ENUM(NSUInteger, SetCode) {
    ResultCodeMinFaceSize = 0,  //最小检测人脸阈值
    ResultCodeCropFaceSizeWidth = 1,  //截取人脸图片大小
    ResultCodeOccluThreshold = 2,   //人脸遮挡阀值
    ResultCodeIllumThreshold = 3,     //亮度阀值
    ResultCodeBlurThreshold = 4,     //图像模糊阀值
    ResultCodePitch = 5,      //头部姿态角度
    ResultCodEyaw = 6,    //头部姿态角度
    ResultCodeRoll = 7,     //头部姿态角度
    ResultCodeIscheckQuality = 8,  //是否进行人脸图片质量检测
    ResultCodeConditionTimeout = 9, //超时时间
    ResultCodeNotFaceThreshold = 10,     //人脸检测精度阀值
    ResultCodeCropFaceEnlargeRatio = 11
};

// 设置最小检测人脸阈值
@property (weak, nonatomic) IBOutlet UITextField *minFaceSize;

// 设置截取人脸图片大小
@property (weak, nonatomic) IBOutlet UITextField *cropFaceSizeWidth;

// 设置人脸遮挡阀值
@property (weak, nonatomic) IBOutlet UITextField *occluThreshold;

// 设置亮度阀值
@property (weak, nonatomic) IBOutlet UITextField *illumThreshold;

// 设置图像模糊阀值
@property (weak, nonatomic) IBOutlet UITextField *blurThreshold;

// 设置头部姿态角度
@property (weak, nonatomic) IBOutlet UITextField *pitch;
@property (weak, nonatomic) IBOutlet UITextField *yaw;
@property (weak, nonatomic) IBOutlet UITextField *roll;

// 设置是否进行人脸图片质量检测
@property (weak, nonatomic) IBOutlet UISegmentedControl *ischeckQuality;

// 设置超时时间
@property (weak, nonatomic) IBOutlet UITextField *conditionTimeout;

// 设置人脸检测精度阀值
@property (weak, nonatomic) IBOutlet UITextField *notFaceThreshold;


@property (weak, nonatomic) IBOutlet UITextField *cropFaceEnlargeRatio;



@end
