//
//  performanceVCViewController.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/5.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineChartViews.h"
#import "PYLineDemoOptions.h"
#import "AShiledLibrary.h"
#import "Method.h"
#import "netWork.h"

@interface performanceVCViewController : UIViewController

//视图
@property(nonatomic,strong)PYEchartsView *runCPUEchartView;
@property(nonatomic,strong)PYEchartsView *runMEMEchartView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//case总数
@property (weak, nonatomic) IBOutlet UILabel *caseNumber;
//成功调用个数
@property (weak, nonatomic) IBOutlet UILabel *sucessCase;
@property (weak, nonatomic) IBOutlet UILabel *failCase;
@property (weak, nonatomic) IBOutlet UILabel *blockCase;



//平均时间
@property (weak, nonatomic) IBOutlet UILabel *averageTime;
//最大时间
@property (weak, nonatomic) IBOutlet UILabel *maxTime;
//最小时间
@property (weak, nonatomic) IBOutlet UILabel *minTime;


//背景view
@property (weak, nonatomic) IBOutlet UIView *backView;


@property (weak, nonatomic) IBOutlet UIView *runCPUView;

@property (weak, nonatomic) IBOutlet UIView *runMEMView;

@property(nonatomic,strong)testResoultModel *resoultModel;

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

@end
