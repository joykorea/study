//
//  mainViewAction.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/15.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "mainViewAction.h"
#import "Method.h"

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

@implementation mainViewAction

+ (UIView *)createCustomViewWithSEL:(SEL)section andVC:(UIViewController *)vc{
    UIView *bView = [[UIView alloc]init];;
    bView.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60);
    bView.backgroundColor = [UIColor blackColor];
    
    float width = (SCREEN_WIDTH - 15 - 5) / 3;
    
    UIButton *button1 = [MethodDIY createCustomButtonWithTitle:@"开始测试"];
    button1.frame = CGRectMake(5, 5, width, 50);
    [button1 addTarget:vc action:section forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor grayColor];
    button1.tag = 110;
    
    UIButton *button2 = [MethodDIY createCustomButtonWithTitle:@"测试报告"];
    button2.frame = CGRectMake(width + 5*2, 5, width, 50);
    [button2 addTarget:vc action:section forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 111;
    
    UIButton *button3 = [MethodDIY createCustomButtonWithTitle:@"开始空跑"];
    button3.frame = CGRectMake(width*2 + 5*3, 5, width, 50);
    [button3 addTarget:vc action:section forControlEvents:UIControlEventTouchUpInside];
    button3.backgroundColor = [UIColor grayColor];
    button3.tag = 112;
    
    [bView addSubview:button1];
    [bView addSubview:button2];
    [bView addSubview:button3];
    
    return bView;
}

+ (NSMutableArray *)clickCheckResultBtnInCellWithIndexPath:(NSIndexPath *)indexPath andArray:(NSMutableArray *)array isAllTest:(BOOL)isAllTest{
    NSMutableArray *soucesArr = [NSMutableArray array];
    NSMutableArray *showDataArr = [array mutableCopy];
    for (NSInteger i = indexPath.row + 1; i < showDataArr.count; i++) {
        functionsCellModel *model = showDataArr[i];
        if (model.level == 0) {
            if(isAllTest){
                if (i+1 < showDataArr.count) {
                    continue;
                }else{
                    break;
                }
            }else{
                break;
            }
            
        }else{
            if (model.level == 1) {
                [soucesArr addObject:model.name];
            }else if (model.level == 2 && model.isSelected){
                
                [soucesArr addObject:model];
            }
        }
    }
    return soucesArr;
}



+ (void)clickSelectBtnInCellWithIndexPath:(NSIndexPath *)indexpath andArray:(NSMutableArray *)showDataArr andSaveArr:(NSMutableArray *)saveArr{
    
    functionsCellModel *model = showDataArr[indexpath.row];
    
    model.isSelected = !model.isSelected;
    if (model.isSelected) {
        model.color = SELECT_COLOR;//选中cell的颜色
    }else{
        model.color = DEFAUT_COLOR;//默认透明颜色
    }
    
    if ([model modelIsHasChild]) {
        
        for (NSInteger i= indexpath.row+1; i<showDataArr.count; i++) {
            
            functionsCellModel *comModel = showDataArr[i];
            
            
            if (comModel.level>model.level) {
                comModel.isSelected = model.isSelected;
            }
            if (comModel.isSelected) {
                comModel.color = SELECT_COLOR;//选中cell的颜色
            }else{
                comModel.color = DEFAUT_COLOR;//默认透明颜色
            }
            
            if (comModel.level == 2 ) {
                
                [self loadModelWithFunctionCellModel:comModel withArray:saveArr];
            }
            
            if (comModel.level == model.level) {
                break;
            }
            
        }
    }
    
    [self changeUpperModelWithIndexPath:indexpath.row andArray:showDataArr andSaveArray:saveArr];
}

+ (void)changeUpperModelWithIndexPath:(NSInteger)index andArray:(NSMutableArray *)showDataArr andSaveArray:(NSMutableArray *)saveArray{
    
    functionsCellModel *model = showDataArr[index];
    
    BOOL isChange = YES;
    
    for (NSInteger i = index; i<showDataArr.count; i++) {
        functionsCellModel *nextModel = showDataArr[i];
        if (nextModel.level == 2 ) {
            [self loadModelWithFunctionCellModel:nextModel withArray:saveArray];
        }
        if (nextModel.level < model.level) {
            break;
        }
        if (nextModel.isSelected == NO) {
            isChange = NO;
        }
    }
    
    
    for (NSInteger i = index; i>=0; i--) {
        functionsCellModel *beforeModel = showDataArr[i];
        if (beforeModel.level < model.level) {
            beforeModel.isSelected = isChange;
            if (isChange) {
                beforeModel.color = SELECT_COLOR;
            }else{
                beforeModel.color = DEFAUT_COLOR;
            }
            if (beforeModel.level == 2 ) {
                [self loadModelWithFunctionCellModel:beforeModel withArray:saveArray];
            }
            
            [self changeUpperModelWithIndexPath:i andArray:showDataArr andSaveArray:saveArray];
            break;
        }
        
        if (beforeModel.isSelected ==NO) {
            isChange = NO;
        }
    }
    
    if (model.level == 0) {
        return;
    }
}

//随时保存功能选择数组
+ (void)loadModelWithFunctionCellModel:(functionsCellModel *)model withArray:(NSMutableArray *)modelArr{
    if (![modelArr containsObject:model]) {
        //不包含
        if (model.isSelected) {
            [modelArr addObject:model];
        }
    }else{
        //包含
        if (!model.isSelected) {
            [modelArr removeObject:model];
        }
    }
}


+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withArray:(NSMutableArray *)showDataArr andSaveArr:(NSMutableArray *)modelArr{
    
    functionsCellModel *model = showDataArr[indexPath.row];
    if ([model modelIsHasChild]) {
        if (model.isOpen == NO) {
            model.isOpen = YES;
            NSArray *childArr = model.childModel[0];
            NSInteger i = 1;
            NSMutableArray *insertArr = [NSMutableArray array];
            for (functionsCellModel *childModel in childArr) {
                if (model.isSelected) {
                    childModel.color = SELECT_COLOR;//选中状态颜色
                }else{
                    childModel.color = [UIColor clearColor];//默认颜色
                }
                
                childModel.isSelected = model.isSelected;
                //    实现数组中对象的深拷贝
                [showDataArr insertObject:[childModel copy] atIndex:indexPath.row + i];
                
                [insertArr addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:0]];
                i++;
                if (childModel.level == 2 ) {
                    [self loadModelWithFunctionCellModel:childModel withArray:modelArr];
                }
            }
            [tableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationLeft];
        }else {
            
            NSMutableArray *waitRemove = [[NSMutableArray alloc] init];
            
            model.isOpen = NO;
            NSMutableArray *deleArr = [NSMutableArray array];
            for (NSInteger i = indexPath.row+1; i<showDataArr.count;i++) {
                
                functionsCellModel *subModel = showDataArr[i];
                if (subModel.level > model.level) {
                    
                    [waitRemove addObject:subModel];
                    [deleArr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                    if (subModel.level == 2 ) {
                        [mainViewAction loadModelWithFunctionCellModel:subModel withArray:modelArr];
                    }
                }
                if (subModel.level == model.level) {
                    break;
                }
            }
            [showDataArr removeObjectsInArray:waitRemove];
            [tableView deleteRowsAtIndexPaths:deleArr
                             withRowAnimation:UITableViewRowAnimationRight];
        }
        
    }
}

+ (NSMutableArray *)settingMarkArrWithArr:(NSArray *)arr {
    
    NSMutableArray *totalArr = [[NSMutableArray alloc] init];
    
    if (arr != nil && arr.count >0) {
        
        for (NSDictionary *dict in arr) {
            
            NSMutableArray *markArr = [[NSMutableArray alloc] init];
            
            functionsCellModel *model = [[functionsCellModel alloc] init];
            model.name = dict[@"name"];
            model.isTest = NO;
            
//            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//                [model setValue:obj forKey:key];
//                NSLog(@"have no ket : %@",key);
//            }];
            
            if(dict[@"beginName"])   model.beginName = dict[@"beginName"];
            if(dict[@"endName"])     model.endName = dict[@"endName"];
            if(dict[@"livingAction"])model.livingAction = dict[@"livingAction"];
            
            if (dict[@"userID"]) {
                model.userID = dict[@"userID"];
            }
            
            if (model.beginName) {
                model.name = model.beginName;
            }
            
            model.level = [dict[@"level"] integerValue];
            if (dict[@"exResult"]) {
                model.exResult = dict[@"exResult"];
            }else{
                model.exResult = @"-2";
            }
//            if (model.exResult.length < 1) {
//                model.exResult = @"-2";
//            }
            
            model.childModel = markArr;
//            model.image = [UIImage imageNamed:model.name];
            model.teResoult = @"-2";//默认结果为-2
            model.color = [UIColor clearColor];//初始色透明
            
            [totalArr addObject:model];
            __block typeof(self) weakSelf = self;
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                
                if ([obj isKindOfClass:[NSArray class]]) {
                    
                    NSArray *subArr = [weakSelf settingMarkArrWithArr:obj];
                    
                    [markArr addObject:subArr];
                }
            }];
        }
        return totalArr;
    }else {
        
        return  totalArr;
    }
}

+ (void)createTableViewWithTableView:(UITableView *)tableView withViewController:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)viewController{
    
    tableView.delegate = viewController;
    tableView.dataSource = viewController;
    //tableView相关
    tableView.separatorStyle = NO;
    tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiong.jpg"]];
    //注册nib的cell
    [tableView registerNib:[UINib nibWithNibName:@"mainTableViewCell" bundle:nil] forCellReuseIdentifier:@"status"];
    //只显示有数据cell的分割线
    tableView.tableFooterView = [UIView new];
    
    [viewController.view addSubview:tableView];
}

+ (void)handleSectionArr:(NSMutableArray *)sectionArr toFunctionArr:(NSMutableArray *)functionArr{
    
    int j = 0;
    if (sectionArr.count < 1) {
        return;
    }
    for (int i = 1; i < sectionArr.count; i++) {
        if ([sectionArr[i] isKindOfClass:[NSString class]]) {
            NSArray *array = [NSArray arrayWithArray:[sectionArr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(j, i-j)]]];
            j = i;
            
            if (array.count != 1) {
                [functionArr addObject:array.copy];
            }
        }
    }
    //处理结尾的字符串和模型关系
    if (j < sectionArr.count-1) {
        NSArray *arr = [sectionArr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(j, sectionArr.count - j)]];
        [functionArr addObject:arr];
    }
}

//设置导航栏右侧按钮
+ (void)setNavigationBarRightItemWithAction:(SEL)action andViewController:(UIViewController *)viewController{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"设置邮件接收人" forState:UIControlStateNormal];
//    rightBtn.backgroundColor = [UIColor oNSTextAlignmentRightrangeColor];
    rightBtn.frame = CGRectMake(0, 0, 120, 30);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    rightBtn.backgroundColor = [UIColor blackColor];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    [viewController.navigationItem setRightBarButtonItem:rightBtnItem];
}

@end
