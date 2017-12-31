//
//  LineChartViews.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/22.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "LineChartViews.h"
#import "MonitorIOS.h"

@interface LineChartViews ()

@property(nonatomic,strong)NSMutableArray *xArray;
@property(nonatomic,strong)NSMutableArray *yArray;
@property (nonatomic, strong)dispatch_source_t tTimer;  //GCD计时器一定要设置为成员变量， 否则会立即释放

@end

@implementation LineChartViews{
    MonitorIOS *mom;//获取CPU和内存消耗的类
    //    ChartYAxis *leftAxisTwo;//左边Y轴
    //    ChartXAxis *xAxisTwo;//X轴
    CFTimeInterval xValue;
    float maxCPUValue;//记录cpu的使用最大值
    float maxMemoryValue;//记录memory的使用最大值
    
}

- (void)stopTimer{
    
    //暂停timer对象
    if (self.tTimer) {
        dispatch_suspend(self.tTimer);
    }
}

- (void)closeTimer{
    //销毁timer, 注意暂停的timer资源不能直接销毁， 需要先resume再cancel， 否则会造成内存泄漏
    if(self.tTimer){
        [self stopTimer];//不执行会影响二次(进入性能界面两次返回)释放
        dispatch_resume(self.tTimer);
        dispatch_source_cancel(self.tTimer);
    }
}

- (void)startTimer{
    mom = [[MonitorIOS alloc]init];
    if (!_myInterval) {
        _myInterval = 0.03;
    }
    
    //创建GCD timer资源， 第一个参数为源类型， 第二个参数是资源要加入的队列
//    if (!self.tTimer) {
    self.tTimer = nil;
    self.tTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        //设置timer信息， 第一个参数是我们的timer对象， 第二个是timer首次触发延迟时间， 第三个参数是触发时间间隔， 最后一个是是timer触发允许的延迟值， 建议值是十分之一
    dispatch_source_set_timer(self.tTimer,
                                  dispatch_walltime(NULL, 0 * NSEC_PER_SEC),
                                  _myInterval * NSEC_PER_SEC,
                                  0);
        
        //设置timer的触发事件
    dispatch_source_set_event_handler(self.tTimer, ^{
            
        [self playLink:nil];
    });
//    }
    
    
    //激活timer对象
    dispatch_resume(self.tTimer);
    
    
}

#pragma mark---------获取数据源-----------
- (void)playLink:(NSTimer *)timer{
    if (!_xArray) {
        _xArray = [NSMutableArray array];
    }
    if (!_yArray) {
        _yArray = [NSMutableArray array];
    }
    float cpu = [mom systemStats];
    double memory = [mom usedMemory];
    if (cpu > maxCPUValue) {
        maxCPUValue = cpu;
    }
    if (memory > maxMemoryValue) {
        maxMemoryValue = memory;
    }
    
    if (_isMemory) {
        
        [_yArray addObject:[NSNumber numberWithFloat:(floor(memory*100))/100.0]];
        xValue = xValue + _myInterval;
        [_xArray addObject:[NSNumber numberWithDouble:(floor(xValue*100))/100.0]];
    }else{
        [_yArray addObject:[NSNumber numberWithFloat:cpu]];
        xValue = xValue + _myInterval;
        [_xArray addObject:[NSNumber numberWithDouble:(floor(xValue*100))/100.0]];
    }
}

#pragma mark--------设置数据源-------
- (void)setDataWithxArray:(NSMutableArray *)xArray andYArray:(NSMutableArray *)yArray{
    self.xArray = xArray;
    self.yArray = yArray;
}


-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)getImageFromLineChartView:(UIView *)view{
    return [self getImageFromView:view];
}


@end
