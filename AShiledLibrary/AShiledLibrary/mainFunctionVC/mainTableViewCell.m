//
//  mainTableViewCell.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/29.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "mainTableViewCell.h"
#import <AShiledLibrary/AShiledLibrary.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define DEFAUT_COLOR [UIColor clearColor]

#define SELECT_COLOR [UIColor colorWithRed:0.7 green:1 blue:1 alpha:1]
//翠绿色
#define SUCESS_COLOR [UIColor colorWithRed:0.0 green:201/255.0 blue:87/255.0 alpha:1]
//番茄红
#define FALSE_COLOR [UIColor colorWithRed:1 green:99/255.0 blue:71/255.0 alpha:1]
//其他结果
#define OTHER_COLOR [UIColor colorWithRed:1 green:215/255.0 blue:0.0 alpha:1]

@implementation mainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(functionsCellModel *)model{
    self.name.text = model.name;
    self.name.backgroundColor = model.color;
    [self.selectAllButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",model.isSelected == YES ? @"green":@"blank"]] forState:UIControlStateNormal];
    self.indentationLevel = model.level;
    //设置全选按钮和查看结果按钮的显示隐藏
    if (self.indentationLevel != 0) {
        self.checkResultButton.hidden = YES;
        self.beginTest.hidden = YES;
    }else{
        self.checkResultButton.hidden = NO;
        self.beginTest.hidden = YES;
        if (model.isTest) {
            [self.beginTest setTitle:@"结束测试" forState:UIControlStateNormal];
            self.beginTest.backgroundColor = FALSE_COLOR;
        }else{
            [self.beginTest setTitle:@"开始测试" forState:UIControlStateNormal];
            self.beginTest.backgroundColor = [UIColor lightGrayColor];
        }
        if([model.name isEqualToString:@"1-功能"]){
            [self.checkResultButton setTitle:@"查看结果" forState:UIControlStateNormal];
        }else if ([model.name isEqualToString:@"2- 性能"]){
            [self.checkResultButton setTitle:@"查看性能" forState:UIControlStateNormal];
        }
    }
    self.model = model;
}


- (IBAction)selectAll:(UIButton *)sender {
    if (self.clickSelectBtnBlock) {
        NSIndexPath *path = [self.tableView indexPathForCell:self];
        self.clickSelectBtnBlock(path);
    }
}



//查看结果
- (IBAction)checkResults:(UIButton *)sender {
    self.clickResultBtnBlock(self.model);
}

//开始测试
- (IBAction)startTest:(UIButton *)sender {
    self.clickTestBtnBlock(sender);
}


//重新布局控件
- (void)layoutSubviews{
    [super layoutSubviews];
    self.indentationWidth = 20.0;
    float indentPoints = self.indentationLevel * self.indentationWidth;
    self.contentView.frame = CGRectMake(
                                        indentPoints,
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width - indentPoints,
                                        self.contentView.frame.size.height
                                        );
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
