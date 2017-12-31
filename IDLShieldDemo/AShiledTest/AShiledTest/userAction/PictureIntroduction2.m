//
//  PictureIntroduction2.m
//  AShiledTest
//
//  Created by baidu on 2017/11/22.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "PictureIntroduction2.h"
#import "FaceRecognize.h"

//传入特征值

@implementation PictureIntroduction2{
    
    NSMutableDictionary *functionDic;
    NSDate *date;
    FaceRecognize *faceRecognize;
    UIImage *image1;
    UIImage *image2;
    CGFloat resoult;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static PictureIntroduction2 * manager;
    dispatch_once(&once, ^{
        manager = [[PictureIntroduction2 alloc] init];
    });
    return manager;
}

- (void)initData{
    if (!functionDic) {
        functionDic = [NSMutableDictionary dictionary];
    }
    functionDic = [NSMutableDictionary dictionary];
    date = [NSDate date];
    faceRecognize = [FaceRecognize sharedInstance];
}
//单人脸+单人脸图片  1
- (NSDictionary *)extractFeature_ZZ_test{
    [functionDic removeAllObjects];
    resoult = 0.0;
    NSData *feature1 = [NSData data];
    NSData *feature2 = [NSData data];
    image1 = [UIImage imageNamed:@"ss1.jpg"];
    image2 = [UIImage imageNamed:@"ss2.jpg"];
    
    [faceRecognize extractFeatureWithImage:image1 andFeature:&feature1 andDoAffineTransform:1];
    [faceRecognize extractFeatureWithImage:image2 andFeature:&feature2 andDoAffineTransform:1];
    date = [NSDate date];
    resoult = [faceRecognize getConsineDistanceWithFeature:feature1 anotherFeature:feature2];
    NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
    [functionDic setValue:[NSString stringWithFormat:@"%f",resoult]  forKey:teResoultKey];
    [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    NSLog(@"resoult : %f   -----正常特征值（相同人）",resoult);
    return functionDic;
}

//正常特征值+正常特征值  2
- (NSDictionary *)extractFeature_ZZT_test{
    [functionDic removeAllObjects];
    resoult = 0.0;
    NSData *feature1 = [NSData data];
    NSData *feature2 = [NSData data];
    image1 = [UIImage imageNamed:@"ss1.jpg"];
    image2 = [UIImage imageNamed:@"ss2.jpg"];
    
    CGFloat resoults = 0.0;
    NSData *feature3 = [NSData data];
    NSData *feature4 = [NSData data];
    
    [faceRecognize extractFeatureWithImage:image1 andFeature:&feature1 andDoAffineTransform:1];
    [faceRecognize extractFeatureWithImage:image2 andFeature:&feature2 andDoAffineTransform:1];
    
    [faceRecognize extractFeatureWithImage:image1 andFeature:&feature3 andDoAffineTransform:1];
    [faceRecognize extractFeatureWithImage:image2 andFeature:&feature4 andDoAffineTransform:1];
    resoult = [faceRecognize getConsineDistanceWithFeature:feature1 anotherFeature:feature2];
    date = [NSDate date];
    resoults = [faceRecognize getConsineDistanceWithFeature:feature3 anotherFeature:feature4];
    NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
    if ([feature1 isEqualToData:feature3] && [feature2 isEqualToData:feature4] && resoult == resoults) {
        [functionDic setValue:[NSString stringWithFormat:@"1"] forKey:teResoultKey];
        NSLog(@"传入特征值比对结果一致");
    }else{
        [functionDic setValue:[NSString stringWithFormat:@"%f",resoult]  forKey:teResoultKey];
        NSLog(@"传入特征值比对结果不一致");
    }
    
    [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    NSLog(@"---resoult :%f   resoults : %f     -----正常特征值（相同人）  ",resoult,resoults);
    return functionDic;
}

//正常特征值+假特征值  3
- (NSDictionary *)extractFeature_ZJ_test{
    [functionDic removeAllObjects];
    resoult = 0.0;
    NSData *feature1 = [NSData data];
    NSData *feature2 = [NSData data];
    image1 = [UIImage imageNamed:@"ss1.jpg"];
    image2 = [UIImage imageNamed:@"ss2.jpg"];
    
    [faceRecognize extractFeatureWithImage:image1 andFeature:&feature1 andDoAffineTransform:1];
    [faceRecognize extractFeatureWithImage:image2 andFeature:&feature2 andDoAffineTransform:1];
    NSString *string2 = [[NSString alloc] initWithData:feature2 encoding:NSUTF8StringEncoding];
    NSString *string3 = [[NSString alloc] initWithFormat:@"ab%@",string2];
    feature2 = [string3 dataUsingEncoding:NSUTF8StringEncoding];
    date = [NSDate date];
    resoult = [faceRecognize getConsineDistanceWithFeature:feature1 anotherFeature:feature2];
    NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
    [functionDic setValue:[NSString stringWithFormat:@"%f",resoult]  forKey:teResoultKey];
    [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    NSLog(@"resoult : %f    -----正常特征值+假特征值",resoult);
    return functionDic;
}

//假特征值+假特征值  4
- (NSDictionary *)extractFeature_JJ_test{
    [functionDic removeAllObjects];
    resoult = 0.0;
    NSData *feature1 = [NSData data];
    NSData *feature2 = [NSData data];
    image1 = [UIImage imageNamed:@"ss2.jpg"];
    image2 = [UIImage imageNamed:@"ss2.jpg"];
    
    [faceRecognize extractFeatureWithImage:image1 andFeature:&feature1 andDoAffineTransform:1];
    [faceRecognize extractFeatureWithImage:image2 andFeature:&feature2 andDoAffineTransform:1];
    NSLog(@"qwe");
    NSLog(@"---%ld",feature2.length);
    NSString *string1 = [[NSString alloc] initWithData:feature1 encoding:NSUTF16BigEndianStringEncoding];
    NSString *string2 = [[NSString alloc] initWithData:feature2 encoding:NSUTF16BigEndianStringEncoding];
    
    NSString *string3 = [[NSString alloc] initWithFormat:@"%@987654321",[string1 substringToIndex:string1.length-9]];
    NSString *string4 = [[NSString alloc] initWithFormat:@"%@123456789",[string2 substringToIndex:string2.length-9]];
    feature1 = [string3 dataUsingEncoding:NSUTF16BigEndianStringEncoding];
    feature2 = [string4 dataUsingEncoding:NSUTF16BigEndianStringEncoding];
//    NSMutableString *string5 = [NSMutableString string];
//    NSMutableString *string6 = [NSMutableString string];
//    for (int i = 0; i < 356; i++) {
//        [string5 appendString:@"12345678"];
//    }
//    for (int i = 0; i < 356; i++) {
//        [string6 appendString:@"00000000"];
//    }
//    NSLog(@" %ld   %ld",string5.length,string6.length);
//    feature1 = [string5 dataUsingEncoding:NSUTF16BigEndianStringEncoding];
//    feature2 = [string6 dataUsingEncoding:NSUTF16BigEndianStringEncoding];
//    
//    NSLog(@"+++%ld",feature2.length);
    
    date = [NSDate date];
    resoult = [faceRecognize getConsineDistanceWithFeature:feature1 anotherFeature:feature2];
    NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
    [functionDic setValue:[NSString stringWithFormat:@"%f",resoult]  forKey:teResoultKey];
    [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    NSLog(@"resoult : %f    -----假特征值+假特征值",resoult);
    return functionDic;
}

//空特征值+空特征值  5
- (NSDictionary *)extractFeature_KK_test{
    [functionDic removeAllObjects];
    resoult = 0.0;
    resoult = [faceRecognize getConsineDistanceWithFeature:nil anotherFeature:nil];
    NSTimeInterval useTime = [[NSDate date] timeIntervalSinceDate:date];
    [functionDic setValue:[NSString stringWithFormat:@"%f",resoult]  forKey:teResoultKey];
    [functionDic setValue:[NSNumber numberWithDouble:useTime]  forKey:useTimeKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:successFunctionPictureKey];
    [functionDic setValue:[NSNumber numberWithInt:1] forKey:totlesFunctionPictureKey];
    NSLog(@"resoult : %f    -----空特征值+空特征值",resoult);
    return functionDic;
}


@end
