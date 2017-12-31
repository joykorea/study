//
//  functionCellModel.h
//  SDKTestDemo
//
//  Created by LDS on 2017/8/31.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface functionsCellModel : NSObject<NSCopying, NSMutableCopying>

@property(nonatomic,strong)NSString *fatherName;//父节点名字
@property (nonatomic, strong) NSString *name;//级别名称或图片名称(framework处理)

@property (nonatomic, strong)NSString *testImage;//新增（图片名称，name改为只表示三级名称）

@property(nonatomic,strong)NSString *beginName;//活体检测起始图片(framework处理)
@property(nonatomic,strong)NSString *endName;//活体检测结束图片(framework处理)
@property(nonatomic,strong)NSNumber *livingAction;//活体检测动作类型(framework处理)

@property (nonatomic, assign) NSInteger level;//级别
@property (nonatomic ,assign)BOOL isTest;//是否在测试(framework处理)
@property (nonatomic, assign) BOOL isSelected;//是否被选中
@property (nonatomic, strong) NSMutableArray *childModel;//子节点
@property (nonatomic, assign) BOOL isOpen;//是否展开


@property(nonatomic,assign)NSTimeInterval useTime;//消耗时间
@property(nonatomic,strong)UIImage *image;//调用图片

@property(nonatomic,strong)NSString *exResult;//预期结果
@property(nonatomic,assign)NSString *teResoult;//测试结果(未测试为-2，无返回值为-1)
@property(nonatomic,strong)NSString *judgement;//是否通过

@property(nonatomic,strong)UIColor *color;//执行完cell应该显示的颜色


@property(nonatomic,strong)NSString *userID;//用户将要执行方法命的后缀



- (BOOL)modelIsHasChild;

@end
