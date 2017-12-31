//
//  mainViewController.h
//  SDKTestDemo
//
//  Created by baidu on 2017/8/30.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AShiledLibrary/AShiledLibrary.h>


typedef enum : NSUInteger {
    CommonStatus,
    PoseStatus,
    occlusionStatus
} WarningStatus;

@interface mainViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;

//所有数据源
@property(nonatomic,strong)NSArray *functions;

//存储选中的三级目录
@property(nonatomic,strong)NSMutableArray *modelArr;



// 存储选中的数据源
@property(nonatomic,strong)NSMutableArray *sectionArr;
//把数据源按照二级一个单位存放一个数组
@property(nonatomic,strong)NSMutableArray *functionArr;

//显示界面的cell数组
@property (nonatomic, strong) NSMutableArray *showDataArr;
//所有数据转化为模型数组
@property (nonatomic, strong) NSMutableArray *totalArr;


@property (nonatomic, readwrite, retain) CircleView * circleView;//预留


@property(nonatomic,strong)LineChartViews *runCPUView;
@property(nonatomic,strong)LineChartViews *CPUView;
@property(nonatomic,strong)LineChartViews *runMEMView;
@property(nonatomic,strong)LineChartViews *MEMView;

//CPU数组
@property(nonatomic,strong)NSMutableArray *xRunCPUArr;
@property(nonatomic,strong)NSMutableArray *yRunCPUArr;
//空跑CPU数组
@property(nonatomic,strong)NSMutableArray *xCPUArr;
@property(nonatomic,strong)NSMutableArray *yCPUArr;
//内存数组
@property(nonatomic,strong)NSMutableArray *xRunMEMArr;
@property(nonatomic,strong)NSMutableArray *yRunMENArr;
//空跑内存数组
@property(nonatomic,strong)NSMutableArray *xMEMArr;
@property(nonatomic,strong)NSMutableArray *yMEMArr;

- (void)startTimer;
- (void)startVoidTimer;

- (void)stopTimer;
- (void)stopVoidTimer;

- (void)initLineChartViews;
- (void)initVoidLineChartViews;


- (void)dealTestWithButton:(UIButton *)button andIndexPath:(NSIndexPath *)indexPath;

@end
