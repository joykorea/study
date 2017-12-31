//
//  testResoultModel.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "functionsCellModel.h"

@interface testResoultModel : NSObject

@property(nonatomic,assign)int totlesFunctionPicture;
@property(nonatomic,assign)int totlesPerformancePicture;
@property(nonatomic,assign)int blockFunctionPicture;
@property(nonatomic,assign)int blockPerformancePicture;
@property(nonatomic,assign)int successFunctionPicture;
@property(nonatomic,assign)int successPerformancePicture;
@property(nonatomic,assign)int failFunctionPicture;
@property(nonatomic,assign)int failPerformancePicture;

@property(nonatomic,assign)float minTime;
@property(nonatomic,assign)float maxTime;
@property(nonatomic,assign)float perTime;
@property(nonatomic,assign)float totleTime;

//@property(nonatomic,strong)NSString *conclusion;
@property(nonatomic,strong)NSMutableArray *functionModelArr;
//结论数组
@property(nonatomic,strong)NSMutableArray *conclusionArr;
//功能详情数组
@property(nonatomic,strong)NSMutableArray *functionDetailsArr;
//性能详情数组
@property(nonatomic,strong)NSMutableArray *performanceDetailsArr;


- (void)initdataFromArray;

@end
