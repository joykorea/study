//
//  FunctionTableViewCell.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/31.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "FunctionTableViewCell.h"
#import "ImageUtil.h"

@implementation FunctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    if (indexPath.row == 0) {
        identifier = @"Function";
    }else{
        identifier = @"FunctionCell";
        index = 1;
    }
    FunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AShiledLibrary.framework/FunctionTableViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *identifier = @"Function";
    //缓存中取
    FunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //创建
    if (cell == nil) {
        cell = [[FunctionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    return cell;
}

//构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化子视图
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//图片点击事件
- (IBAction)testImage:(UIButton *)sender {
    NSLog(@"点击了查看图片...");
    if (self.testImage) {
//        self.block(self.testImage);
        [ImageUtil scanBigImageWithImageView:self.testImage alpha:0.7];
    }
    
}

- (void)setCellWithModel:(functionsCellModel *)model{
    //case名称
    self.caseName.text = model.name;
    //耗时
    self.useTime.text = [NSString stringWithFormat:@"%.3f",model.useTime];
    //测试图片
    model.image = [UIImage imageNamed:model.testImage];
    if (model.image) {
        self.testImage.image = model.image;
    }
    //预期结果
    if (model.exResult) {
        self.expectedResult.text = model.exResult;
    }else{
        self.expectedResult.text = @"未给出";
    }
    
    //测试结果
    self.testResult.text = model.teResoult;
    //测试是否成功
    self.judgement.text = model.judgement;
    
    if ([self.expectedResult.text isEqualToString:self.testResult.text] && self.testResult.text.length != 0) {
        self.judgement.text = @"True";
        self.judgement.backgroundColor = [UIColor blueColor];
        self.judgement.textColor = [UIColor whiteColor];
    }else{
        self.judgement.text = @"False";
        self.judgement.backgroundColor = [UIColor redColor];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
