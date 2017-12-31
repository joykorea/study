//
//  extractImage.m
//  AShiledTest
//
//  Created by baidu on 2017/11/21.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "extractImage.h"
#import "FaceRecognize.h"

#import <GestureDebug/DetectClassifyInterface.h>


//计算性能数据

@implementation extractImage{
    NSMutableDictionary *performanceDic;
    NSDate *date;
    FaceRecognize *faceRecognize;
    int successCase;
    int falseCase;
    int totleCase;
    int blockCase;
    CGFloat minTime;
    CGFloat maxTime;
    CGFloat totleTime;
    UIImage *image;
    
    DetectClassifyInterface *_interface;
    
}


+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static extractImage * manager;
    dispatch_once(&once, ^{
        manager = [[extractImage alloc] init];
    });
    return manager;
}

- (void)initData{
    performanceDic = [NSMutableDictionary dictionary];
    date = [NSDate date];
    faceRecognize = [FaceRecognize sharedInstance];
    successCase = falseCase = blockCase = totleCase = 0;
    maxTime = totleTime = 0.0;
    minTime = 999.0;
}

- (NSDictionary *)detectImage_test{
    UIImage *image = [UIImage imageNamed:@"singleFace.jpg"];
    DetectClassifyInput *input = [[DetectClassifyInput alloc] init];
    unsigned char *bytes = [input pixelBRGA32BytesFromImage:image];
    input.imagePixels = bytes;
    input.imageWidth = image.size.width;
    input.imageHeight = image.size.height;
    DetectClassifyOutput *output = [[DetectClassifyOutput alloc] init];
    
    NSDate* tmpStartData = [NSDate date];
    
    
    [_interface process:input result:output];
    
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];totleTime += deltaTime;
    maxTime = maxTime > deltaTime ? maxTime : deltaTime;
    minTime = minTime < deltaTime ? minTime : deltaTime;
    successCase++;
    totleCase++;
    
    
    
    NSLog(@"photo cost time = %f", deltaTime*1000);
    
    NSMutableArray *outputArray = output.objects;
    int num = (int)outputArray.count;
    NSString *resultString;
    if (num > 0) {
        resultString = @"category: ";
        for (int i=0;i<num;i++){
            DetectClassifyObject *obj = outputArray[i];
            resultString = [NSString stringWithFormat:@"%@ %d", resultString,obj.category];
        }
    } else {
        resultString = @"category: 0";
    }
    [performanceDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
    [performanceDic setValue:[NSNumber numberWithDouble:totleTime]  forKey:totleTimeKey];
    [performanceDic setValue:[NSNumber numberWithDouble:minTime]  forKey:minTimeKey];
    [performanceDic setValue:[NSNumber numberWithDouble:maxTime]  forKey:maxTimeKey];
    [performanceDic setValue:[NSNumber numberWithInt:successCase] forKey:successPerformancePictureKey];
    [performanceDic setValue:[NSNumber numberWithInt:totleCase] forKey:totlesPerformancePictureKey];
    [performanceDic setValue:[NSNumber numberWithInt:falseCase] forKey:failPerformancePictureKey];
    [performanceDic setValue:[NSNumber numberWithInt:blockCase] forKey:blockPerformancePictureKey];
    
    return performanceDic;
    
}

//单人脸图片  1
- (NSDictionary *)extractFeature_S_test{
    NSNumber *num= [NSNumber numberWithDouble:3];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:num,@"interval", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeIntervalNotification" object:nil userInfo:dict];
    
    [performanceDic removeAllObjects];
    NSData *feature = [NSData data];
    for (int i = 1; i < 2; i++) {
        for (int j = 1; j < 10; j++) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"extract1.jpg"]];
            date = [NSDate date];
            NSInteger resoule = [faceRecognize extractFeatureWithImage:image andFeature:&feature andFaceShape:nil andNumberOfPoints:0 andDoAffineTransform:0];
            NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
            totleTime += useTime;
            maxTime = maxTime > useTime ? maxTime : useTime;
            minTime = minTime < useTime ? minTime : useTime;
            successCase++;
            totleCase++;
            NSLog(@"---testResoult:%ld   %d",resoule,totleCase);
        }
    }
    [performanceDic setValue:[NSString stringWithFormat:@"1"]  forKey:teResoultKey];
    [performanceDic setValue:[NSNumber numberWithDouble:totleTime]  forKey:totleTimeKey];
    [performanceDic setValue:[NSNumber numberWithDouble:minTime]  forKey:minTimeKey];
    [performanceDic setValue:[NSNumber numberWithDouble:maxTime]  forKey:maxTimeKey];
    [performanceDic setValue:[NSNumber numberWithInt:successCase] forKey:successPerformancePictureKey];
    [performanceDic setValue:[NSNumber numberWithInt:totleCase] forKey:totlesPerformancePictureKey];
    [performanceDic setValue:[NSNumber numberWithInt:falseCase] forKey:failPerformancePictureKey];
    [performanceDic setValue:[NSNumber numberWithInt:blockCase] forKey:blockPerformancePictureKey];
    
    return performanceDic;
}

@end
