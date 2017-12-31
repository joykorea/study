//
//  testReportViewController.h
//  SDKTestDemo
//
//  Created by baidu on 2017/8/29.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testResoultModel.h"

@interface testReportViewController : UIViewController

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)NSMutableArray *headArr;
@property(nonatomic,strong)NSMutableArray *rowArr;
@property(nonatomic,strong)NSMutableArray *styleArr;

@property(nonatomic,strong)testResoultModel *resoultModel;


- (void)createHtml;

@end
