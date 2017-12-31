//
//  PYLineDemoOptions.h
//  iOS-Echarts
//
//  Created by Pluto Y on 9/1/16.
//  Copyright © 2016 pluto-y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AShiledLibrary.h"

@interface PYLineDemoOptions : NSObject

+ (PYOption *)standardLineOptionWithXArray:(NSMutableArray *)xArray andYArray:(NSMutableArray *)yArray andVoidYArray:(NSMutableArray *)voidYArray;

+ (PYOption *)standardLineOption;

@end
