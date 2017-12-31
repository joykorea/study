//
//  mainTableViewCell.h
//  SDKTestDemo
//
//  Created by baidu on 2017/8/29.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "functionsCellModel.h"

@interface mainTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;

@property (weak, nonatomic) IBOutlet UIButton *checkResultButton;

@property (weak, nonatomic) IBOutlet UIButton *beginTest;


//使用弱引用 不然会造成循环引用
@property(nonatomic,assign)UITableView *tableView;

@property (nonatomic, copy) void(^clickSelectBtnBlock)(NSIndexPath *indexP);

@property (nonatomic, copy) void(^clickResultBtnBlock)(functionsCellModel *cellModel);

@property (nonatomic, copy) void(^clickTestBtnBlock)(UIButton *button);

@property(nonatomic,strong)functionsCellModel *model;


//接收数据源
@property(nonatomic,strong)NSMutableArray *choseArr;

- (void)setCellWithModel:(functionsCellModel *)model;


@end
