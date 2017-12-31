//
//  FunctionTableViewCell.h
//  SDKTestDemo
//
//  Created by baidu on 2017/8/31.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "functionsCellModel.h"

@interface FunctionTableViewCell : UITableViewCell


typedef  void (^Gest)(UIImageView *);

@property(nonatomic,strong)Gest block;




@property (weak, nonatomic) IBOutlet UILabel *caseName;

@property (weak, nonatomic) IBOutlet UIImageView *testImage;

@property (weak, nonatomic) IBOutlet UILabel *expectedResult;

@property (weak, nonatomic) IBOutlet UILabel *testResult;

@property (weak, nonatomic) IBOutlet UILabel *useTime;

@property (weak, nonatomic) IBOutlet UILabel *judgement;



@property (weak, nonatomic) IBOutlet UIButton *imageButton;




+ (instancetype)cellWithTableView:(UITableView *)tableView;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath ;


- (void)setCellWithModel:(functionsCellModel *)model;


@end
