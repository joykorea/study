//
//  MethodDIY.h
//  SDKTestDemo
//
//  Created by baidu on 2017/8/29.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMLWriter.h"

@interface MethodDIY : NSObject

+(UIImage *_Nullable)getImageFromLineChartsView:(UIView *_Nullable)view;

//向沙盒中写plist文件
+(void)writeFileToplistwithDictionary:(NSDictionary *_Nullable)dic;

//获取遮罩图片
+ (UIImage *_Nullable)getImageResourceForName:(NSString *_Nullable)name;
+ (CGRect)convertRectFrom:(CGRect)imageRect imageSize:(CGSize)imageSize detectRect:(CGRect)detectRect;

//获取plist文件
+ (NSMutableArray *_Nullable)getPlistWithName:(NSString *_Nullable)name;

+ (void)setNavigation:(UIViewController *_Nullable)vc withTitle:(NSString *_Nullable)title withFontSize:(CGFloat)size withColor:(UIColor *_Nullable)color;

//创建button
+ (UIView *_Nullable)createCustomButtonwithNumber:(int)num andTitles:(NSArray *_Nullable)title action:(nonnull SEL)action fromVC:(UIViewController *_Nullable)firstVC;

+ (UIButton *_Nullable)createCustomButtonWithTitle:(NSString *_Nullable)title;

@end
