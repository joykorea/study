//
//  FunctionViewController.h
//  SDKTestDemo
//
//  Created by baidu on 2017/8/31.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionTableViewCell.h"

@interface FunctionViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *functionArr;
@property(nonatomic,strong)NSMutableArray *caseArr;

@property(nonatomic,strong)NSMutableArray *sourcesArr;

//耗时
@property(nonatomic,strong)NSDate *useTime;


@end
