//
//  testResoultModel.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "testResoultModel.h"
#import "functionsCellModel.h"


@implementation testResoultModel


- (void)initdataFromArray{
    [self.conclusionArr removeAllObjects];
    [self.functionDetailsArr removeAllObjects];
#pragma mark--------功能数据源-----------------
    NSMutableArray *function = [NSMutableArray array];
    [function addObject:@"功能"];
    [function addObject:[NSString stringWithFormat:@"%d张",self.totlesFunctionPicture]];
    [function addObject:[NSString stringWithFormat:@"%d",self.blockPerformancePicture]];
    [function addObject:[NSString stringWithFormat:@"%d",self.successFunctionPicture]];
    [function addObject:[NSString stringWithFormat:@"%d",self.failFunctionPicture]];
    //    CGFloat rate = (int)self.successFunctionPicture/(CGFloat)self.totlesFunctionPicture*100;//成功率
    
    //    if (rate == 100) {
    //        [function addObject:@"通过"];
    //    }else{
    //        [function addObject:@"不通过"];
    //    }
    [self.conclusionArr addObject:function];
    
#pragma mark----------性能数据源------------------
    NSMutableArray *performanceArray = [NSMutableArray array];
    [performanceArray addObject:@"性能"];
    [performanceArray addObject:[NSString stringWithFormat:@"%d张",self.totlesPerformancePicture]];
    [performanceArray addObject:[NSString stringWithFormat:@"%d",self.blockPerformancePicture]];
    [performanceArray addObject:[NSString stringWithFormat:@"%d",self.successPerformancePicture]];
    [performanceArray addObject:[NSString stringWithFormat:@"%d",self.failPerformancePicture]];
    [self.conclusionArr addObject:performanceArray];
    NSLog(@"--conclusionArr: %ld",_conclusionArr.count);
#pragma mark--------功能详情数据源-----------------
    for (int i = 0; i < self.functionModelArr.count; i++) {
        functionsCellModel *model = self.functionModelArr[i];
        NSMutableArray *muArr = [NSMutableArray array];
        //caseName
            [muArr addObject:[NSString stringWithFormat:@"%@-%@",[model.fatherName substringToIndex:3],model.name]];
            //预期结果
            [muArr addObject:model.exResult];
            //测试结果
            [muArr addObject:model.teResoult];
            //耗时
            [muArr addObject:[NSString stringWithFormat:@"%.3f",model.useTime]];
            //是否通过
            [muArr addObject:model.judgement];
            [self.functionDetailsArr addObject:muArr];
        
//        else if(self.functionDetailsArr.count == 0 && i == (self.functionModelArr.count-1)){
//            [muArr addObject:@"NA"];
//            [muArr addObject:@"NA"];
//            [muArr addObject:@"NA"];
//            [muArr addObject:@"NA"];
//            [muArr addObject:@"NA"];
//            [self.functionDetailsArr addObject:muArr];
        
    }
    
#pragma mark----------性能详情数据源------------------
    NSMutableArray *perArr = [NSMutableArray array];
    self.perTime = self.totleTime / (self.totlesPerformancePicture-self.blockPerformancePicture);
    NSLog(@"totle:%f",self.totleTime);
    [perArr addObject:[NSString stringWithFormat:@"%d",self.totlesPerformancePicture]];
    [perArr addObject:[NSString stringWithFormat:@"%.2f%%",(float)self.successPerformancePicture/(self.totlesPerformancePicture-self.blockPerformancePicture)*100]];
    [perArr addObject:[NSString stringWithFormat:@"%f",self.perTime]];
    [perArr addObject:[NSString stringWithFormat:@"%f",_maxTime]];
    [perArr addObject:[NSString stringWithFormat:@"%f",_minTime]];
    
    [self.performanceDetailsArr addObject:perArr];
    NSLog(@"--performanceDetailsArr: %ld",_performanceDetailsArr.count);
}

#pragma mark-------数组懒加载---------

- (NSMutableArray *)functionModelArr{
    if (!_functionModelArr) {
        _functionModelArr = [NSMutableArray array];
    }
    return _functionModelArr;
}

- (NSMutableArray *)conclusionArr{
    if (!_conclusionArr) {
        _conclusionArr = [NSMutableArray array];
    }
    return _conclusionArr;
}

- (NSMutableArray *)functionDetailsArr{
    if (!_functionDetailsArr) {
        _functionDetailsArr = [NSMutableArray array];
    }
    return _functionDetailsArr;
}

- (NSMutableArray *)performanceDetailsArr{
    if (!_performanceDetailsArr) {
        _performanceDetailsArr = [NSMutableArray array];
    }
    return _performanceDetailsArr;
}

@end
