//
//  FaceAction.m
//  AShiledTest
//
//  Created by baidu on 2017/11/14.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "FaceAction.h"

//设置参数

@implementation FaceAction{
    NSMutableDictionary *functionDic;
    NSDate *date;
    FaceVerifier *faceV;
    

}
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static FaceAction * manager;
    dispatch_once(&once, ^{
        manager = [[FaceAction alloc] init];
    });
    return manager;
}

- (void)initData{
    functionDic = [NSMutableDictionary dictionary];
    date = [NSDate date];
    faceV = [FaceVerifier sharedInstance];
}



//设置最小检测人脸
- (NSDictionary *)setMinFase_test{
    NSInteger size = 150;
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setMinFaceSize:)]) {
        date = [NSDate date];
        [faceV setMinFaceSize:size];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}
//设置采集人脸图片张数
- (NSDictionary *)setMaxRegImgNum_test{
    NSInteger imageNum = 3;
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setMaxRegImgNum:)]) {
        date = [NSDate date];
        [faceV setMaxRegImgNum:imageNum];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setMaxRegImgNum_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}
//人脸检测头部姿态角度
- (NSDictionary *)setEulurAngleThrPitch_test{
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setEulurAngleThrPitch:yaw:roll:)]) {
        date = [NSDate date];
        [faceV setEulurAngleThrPitch:10 yaw:10 roll:10];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setMaxRegImgNum_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    
    return functionDic;
}
//设置采集图片的尺寸
- (NSDictionary *)setCropFaceSizeWithWidth_test{
    CGFloat faceWidth = 400.0;
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setCropFaceSizeWithWidth:)]) {
        date = [NSDate date];
        [faceV setCropFaceSizeWithWidth:faceWidth];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setMaxRegImgNum_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}
//最小检测光照亮度
- (NSDictionary *)setIllumThr_test{
    CGFloat thr = 40;
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setIllumThr:)]) {
        date = [NSDate date];
        [faceV setIllumThr:thr];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setNotFaceThr_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}

//设置采集人脸图片比例
- (NSDictionary *)setCropFaceEnlargeRatio_test{
    CGFloat thr = 3;
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setCropFaceEnlargeRatio:)]) {
        date = [NSDate date];
        [faceV setCropFaceEnlargeRatio:thr];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
        
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setCropFaceEnlargeRatio_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}

//设置有人脸时质量检测时间间隔
- (NSDictionary *)setDetectionInterval_test{
    NSTimeInterval interval = 500;
    [functionDic removeAllObjects];
    if ([faceV respondsToSelector:@selector(setDetectInVideoInterval:)]) {
        date = [NSDate date];
        [faceV setDetectInVideoInterval:interval];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
        
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setDetectionInterval_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}
//设置无人脸时质量检测时间间隔
- (NSDictionary *)setNoFaceDetectionInterval_test{
    NSTimeInterval interval = 500;
    [functionDic removeAllObjects];

    if ([faceV respondsToSelector:@selector(setTrackByDetectionInterval:)]) {
        date = [NSDate date];
        [faceV setTrackByDetectionInterval:interval];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
        
    }else{
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
        NSLog(@"----- setNoFaceDetectionInterval_test -----");
    }
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    return functionDic;
}
//进行人脸追踪
- (NSDictionary *)perpareData_test{
    
    UIImage *image = [UIImage imageNamed:@"image1.JPG"];
    FaceVerifierActionType actionType = FaceVerifierActionTypeRecognition;
    [functionDic removeAllObjects];
    date = [NSDate date];
    while (1) {
        NSDate *beginDate = [NSDate date];
        FaceVerifierErrorCode errorCode =[[FaceVerifier sharedInstance] prepareDataWithImage:image andActionType:actionType];
        NSTimeInterval endTime = [[NSDate date] timeIntervalSinceDate:beginDate];
        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
        if(errorCode == 0){
            [functionDic setValue:[NSString stringWithFormat:@"%u",errorCode]  forKey:teResoultKey];
            [functionDic setValue:[NSNumber numberWithDouble:endTime]  forKey:useTimeKey];
            [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
            NSLog(@"FaceVerifierErrorCode : %u",errorCode);
            break;
        }else{
            if (useTime > 2.0) {
                if(errorCode){
                    [functionDic setValue:[NSString stringWithFormat:@"%u",errorCode]  forKey:teResoultKey];
                    [functionDic setValue:[NSNumber numberWithDouble:endTime]  forKey:useTimeKey];
                    [functionDic setValue:[NSNumber numberWithInt:1] forKey:failFunctionPictureKey];
                }else{
                    
                    [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
                    [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
                }
                break;
            }
        }
        [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    }
    return functionDic;
}

//设置精度阙值
//- (NSDictionary *)setNotFaceThr_test{
//    CGFloat thr = 0;
//    NSArray *noFaceThrArr = [NSArray arrayWithObjects:@0,@-500,@10000, nil];
//    [functionDic removeAllObjects];
//    date = [NSDate date];
//    if ([faceV respondsToSelector:@selector(setNotFaceThr:)]) {
//        for(int i = 0;i < noFaceThrArr.count;i++){
//             [faceV setNotFaceThr:[noFaceThrArr[i] floatValue]];
//        }
//        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
//        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
//        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
//        [faceV setNotFaceThr:thr];
//    }else{
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
//        NSLog(@"----- setNotFaceThr_test -----");
//    }
//    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
//    return functionDic;
//}



//设置获取人脸大小
//- (NSDictionary *)getCropFaceSize_test{
//
//    [functionDic removeAllObjects];
//    if ([faceV respondsToSelector:@selector(getCropFaceSize)]) {
//        date = [NSDate date];
//        NSInteger cropFace = [[FaceVerifier sharedInstance] getCropFaceSize];
//        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
//        [functionDic removeAllObjects];
//        if (cropFace) {
//            [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
//            [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
//        }else{
//            [functionDic setValue:[NSString stringWithFormat:@"0"]  forKey:teResoultKey];
//            [functionDic setValue:[NSNumber numberWithInt:1] forKey:failFunctionPictureKey];
//
//        }
//        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
//    }else{
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
//        NSLog(@"----- getCropFaceSize_test -----");
//    }
//    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
//    return functionDic;
//}

//清除人脸信息数组
//- (NSDictionary *)clearTrackedFaces_test{
//    UIImage *image = [UIImage imageNamed:@"mengjiao_image1.jpg"];
//    NSInteger count = 3;
//    [[FaceVerifier sharedInstance] trackWithImage:image andMaxFaceCount:count];
//    [functionDic removeAllObjects];
//    if ([faceV respondsToSelector:@selector(clearTrackedFaces)]) {
//        NSArray *trackedFaceInfoB = [[FaceVerifier sharedInstance] trackedFaceInfos];
//        date = [NSDate date];
//        [[FaceVerifier sharedInstance] clearTrackedFaces];
//        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
//        NSArray *trackedFaceInfoF = [[FaceVerifier sharedInstance] trackedFaceInfos];
//
//        if (trackedFaceInfoB.count > 0 && trackedFaceInfoF.count == 0) {
//            [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
//            [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
//            [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
//        }else{
//            [functionDic setValue:[NSString stringWithFormat:@"0"]  forKey:teResoultKey];
//            [functionDic setValue:[NSNumber numberWithInt:1] forKey:failFunctionPictureKey];
//        }
//
//    }else{
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
//        NSLog(@"----- clearTrackedFaces_test -----");
//    }
//    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
//    return functionDic;
//}
//进行人脸追踪
//- (NSDictionary *)trackWithImage_test{
//    UIImage *image = [UIImage imageNamed:@"mengjiao_image1.jpg"];
//    NSInteger count = 3;
//    [[FaceVerifier sharedInstance] trackWithImage:image andMaxFaceCount:count];
//    [functionDic removeAllObjects];
//    if ([faceV respondsToSelector:@selector(trackWithImage:andMaxFaceCount:)]) {
//        date = [NSDate date];
//        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
//        [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
//        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
//    }else{
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
//        NSLog(@"----- trackWithImage_test -----");
//    }
//    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
//    return functionDic;
//
//}

//追踪的人脸信息数组
//- (NSDictionary *)getTrackedFaceInfos_test{
//    UIImage *image = [UIImage imageNamed:@"mengjiao_image1.jpg"];
//    NSInteger count = 3;
//    [[FaceVerifier sharedInstance] trackWithImage:image andMaxFaceCount:count];
//    date = [NSDate date];
//    [functionDic removeAllObjects];
//    if ([faceV respondsToSelector:@selector(trackedFaceInfos)]) {
//        date = [NSDate date];
//        NSArray *trackedFaceInfo = [[FaceVerifier sharedInstance] trackedFaceInfos];
//        if (trackedFaceInfo.count > 0) {
//            [functionDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
//            [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
//        }else{
//            [functionDic setValue:[NSString stringWithFormat:@"0"]  forKey:teResoultKey];
//            [functionDic setValue:[NSNumber numberWithInt:1] forKey:failFunctionPictureKey];
//        }
//        NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
//
//        [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
//    }else{
//        [functionDic setValue:[NSNumber numberWithInt:1] forKey:blockFunctionPictureKey];
//        NSLog(@"----- getTrackedFaceInfos_test -----");
//    }
//
//    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
//    return functionDic;
//}


//- (void)cropFaceImage_test{
//
//    UIImage *image = [UIImage imageNamed:@""];
//    FaceSDKImageType imageType = FaceSDKImgTypeRGB;
//    //    NSArray *faceShape = [NSArray array];
//    NSInteger numOfPoints = 0;
//    NSInteger imageWidth = 0;
//    NSInteger imageHeight = 0;
//    //    UIImage *cropImage = [UIImage imageNamed:@"mengjiao_image1.jpg"];
//    //    NSArray *cropShap = [NSArray array];
//    [[FaceVerifier sharedInstance] cropFaceImageWith:image imageType:imageType FaceShape:nil numOfPoints:numOfPoints faceImageWidth:imageWidth faceImageHeight:imageHeight cropImage:nil cropShaps:nil];
//}

@end
