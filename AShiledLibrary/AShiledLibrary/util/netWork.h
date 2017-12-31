//
//  netWork.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface netWork : NSObject

+ (NSString *)postImage:(UIImage *)image withImageKey:(NSString *)imageKey;

+ (NSString *)postWithEMailString:(NSString *)string;

+ (NSString *)postWithNsstring:(NSString *)string andEMailString:(NSString *)eMailStrong;

+ (void)postSessionWithImage:(UIImage *)image;

+ (void)postSessionWithHtml:(NSString *)string;

@end
