//
//  FunctionViewController.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/31.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "FunctionViewController.h"
#import "functionsCellModel.h"
#import "Method.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface FunctionViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FunctionViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [MethodDIY setNavigation:self withTitle:@"功能测试结果" withFontSize:19 withColor:[UIColor blackColor]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"xiong.jpg"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:imageView];
    
//    _functionArr = [NSMutableArray array];
    _caseArr = [NSMutableArray array];
//    if (_sourcesArr) {
//        [self handleSourceAr];
//    }
    
    if (_functionArr.count != 0) {
        [self createTableView];
    }
    
    
    
}

- (void)handleSourceAr{
    int j = 0;
    for (int i = 1; i < _sourcesArr.count; i++) {
        if ([_sourcesArr[i] isKindOfClass:[NSString class]]) {
                NSArray *array = [_sourcesArr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(j, i-j)]];
                j = i;
            
            if (array.count != 1) {
                [_functionArr addObject:array];
            }
        }
    }
    
    //处理结尾的字符串和模型关系
    if (j < _sourcesArr.count-1) {
        NSArray *arr = [_sourcesArr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(j, _sourcesArr.count - j)]];
        [_functionArr addObject:arr];
    }
    
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //tableView相关
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiong.jpg"]];
    //只显示有数据cell的分割线
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _functionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_functionArr[section]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _functionArr[section][0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor whiteColor];
    header.contentView.backgroundColor = [UIColor grayColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FunctionTableViewCell *cell = [FunctionTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        return cell;
    }
    functionsCellModel *model = _functionArr[indexPath.section][indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
