//
//  performanceVCViewController.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/5.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "performanceVCViewController.h"

@interface performanceVCViewController ()<UIScrollViewDelegate,PYEchartsViewDelegate>


@end

@implementation performanceVCViewController


-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [MethodDIY setNavigation:self withTitle:@"性能测试结果" withFontSize:19 withColor:[UIColor blackColor]];
    self.caseNumber.text = [NSString stringWithFormat:@"  T: %d",self.resoultModel.totlesPerformancePicture];
    self.sucessCase.text = [NSString stringWithFormat:@"  P: %d",self.resoultModel.successPerformancePicture];
    self.failCase.text = [NSString stringWithFormat:@"  F: %d",self.resoultModel.failPerformancePicture];
    self.blockCase.text = [NSString stringWithFormat:@"  B: %d",self.resoultModel.blockPerformancePicture];
    
    
    self.averageTime.text = [NSString stringWithFormat:@"%.3f",self.resoultModel.perTime];
    self.maxTime.text = [NSString stringWithFormat:@"%.3f",self.resoultModel.maxTime];
    self.minTime.text = [NSString stringWithFormat:@"%.3f",self.resoultModel.minTime];
    
    [self initAll];
    
}

- (void)viewDidLayoutSubviews{
    [self loadData];
}

- (void)initAll {
    _runCPUEchartView = [[PYZoomEchartsView alloc]initWithFrame:CGRectMake(0, 0, _runCPUView.frame.size.width, _runCPUView.frame.size.height)];
    _runCPUEchartView.eDelegate = self;
    _runCPUEchartView.tag = 150;
    [self.runCPUView addSubview:_runCPUEchartView];
    
    
    _runMEMEchartView = [[PYZoomEchartsView alloc]initWithFrame:CGRectMake(0, 0, _runMEMView.frame.size.width, _runMEMView.frame.size.height)];
    _runMEMEchartView.eDelegate = self;
    _runMEMEchartView.tag = 151;
    [self.runMEMView addSubview:_runMEMEchartView];
}

- (void)loadData{
    NSLog(@"CPU size: %lu size :%ld",sizeof(_xRunCPUArr),_xRunCPUArr.count);
    NSLog(@"CPU size: %lu size :%ld",sizeof(_yRunCPUArr),_yRunCPUArr.count);
    NSLog(@"CPU size: %lu size :%ld",sizeof(_xRunMEMArr),_xRunMEMArr.count);
    NSLog(@"CPU size: %lu size :%ld",sizeof(_yRunMENArr),_yRunMENArr.count);
    PYOption *option1, *option3;
    option1 =[PYLineDemoOptions standardLineOptionWithXArray:_xRunCPUArr andYArray:_yRunCPUArr andVoidYArray:_yCPUArr];
    option3 =[PYLineDemoOptions standardLineOptionWithXArray:_xRunMEMArr andYArray:_yRunMENArr andVoidYArray:_yMEMArr];
    
    if (option1 != nil) {
        [_runCPUEchartView setOption:option1];
    }
    if (option3 != nil) {
        [_runMEMEchartView setOption:option3];
    }
    [_runCPUEchartView loadEcharts];
    [_runMEMEchartView loadEcharts];
    
    
}

- (void)echartsViewDidFinishLoad:(PYEchartsView *)echartsView{
    NSLog(@"--- 123 ---");
    if (echartsView.tag == 150) {
        [self performSelector:@selector(download:) withObject:@[@"iOS_runCPUView",echartsView] afterDelay:1];
    }
    if (echartsView.tag == 151) {
        [self performSelector:@selector(download:) withObject:@[@"iOS_runMEMView",echartsView] afterDelay:1];
    }
}

- (void)download:(NSArray *)arr{
    
    if (!arr || arr.count != 2) {
        return;
    }
    PYEchartsView *chartsView = arr[1];
    NSString *imageKey = arr[0];
    [NSThread sleepForTimeInterval:1];
    [netWork postImage:[MethodDIY getImageFromLineChartsView:chartsView] withImageKey:imageKey];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
