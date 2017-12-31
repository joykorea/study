//
//  mainViewAction.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/15.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "functionsCellModel.h"

@interface mainViewAction : NSObject

+ (UIView *)createCustomViewWithSEL:(SEL)section andVC:(UIViewController *)vc;

//点击查看结果后获取选中的二级名字和三级mode
+ (NSMutableArray *)clickCheckResultBtnInCellWithIndexPath:(NSIndexPath *)indexPath andArray:(NSMutableArray *)array isAllTest:(BOOL)isAllTest;


+ (void)clickSelectBtnInCellWithIndexPath:(NSIndexPath *)indexpath andArray:(NSMutableArray *)showDataArr andSaveArr:(NSMutableArray *)saveArr;

+ (void)loadModelWithFunctionCellModel:(functionsCellModel *)model withArray:(NSMutableArray *)modelArr;


+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withArray:(NSMutableArray *)showDataArr andSaveArr:(NSMutableArray *)modelArr;

+ (NSMutableArray *)settingMarkArrWithArr:(NSArray *)arr;

+ (void)createTableViewWithTableView:(UITableView *)tableView withViewController:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)viewController;

+ (void)handleSectionArr:(NSMutableArray *)sectionArr toFunctionArr:(NSMutableArray *)functionArr;

+ (void)setNavigationBarRightItemWithAction:(SEL)action andViewController:(UIViewController *)viewController;

@end
