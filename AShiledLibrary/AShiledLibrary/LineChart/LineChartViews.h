//
//  LineChartViews.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/22.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LineChartViews : NSObject


/**
 isMemory
 */
@property(nonatomic,assign)BOOL isMemory;

/**
 The time interval
 */
@property(nonatomic,assign)NSTimeInterval myInterval;//定时时间间隔

/**
 Start GCD Timer
 */
- (void)startTimer;

/**
 Stop GCD Timer
 */
- (void)stopTimer;
/**
 Close GCD Timer
 */
- (void)closeTimer;
/**
 Set the X and Y axis Date
 
 @param xArray X Date
 @param yArray Y Date
 */
- (void)setDataWithxArray:(NSMutableArray *)xArray andYArray:(NSMutableArray *)yArray;

/**
 Transforming the lineChart into image
 
 @param view lineChart
 @return image
 */
- (UIImage *)getImageFromLineChartView:(UIView *)view;


@end
