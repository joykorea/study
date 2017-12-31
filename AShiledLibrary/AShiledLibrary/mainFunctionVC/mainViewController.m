//
//  mainViewController.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/30.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "mainViewController.h"

#import "setViewController.h"
#import "mainTableViewCell.h"
//#import "functionsCellModel+proper.h"
//#import "DIYFaceSDKAction.h"

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

@interface mainViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,strong) functionsCellModel *isTestModel;//正在进行测试的cell数据
//@property (nonatomic, assign) BOOL isVoidRun;//是否是空跑(获取数据用)

@end




@implementation mainViewController{
//    UIAlertView *WXinstall;
    CGRect previewRect;
    testResoultModel *testModel;//测试结果model
    UIAlertController *alert;//弹出正在执行事务
    BOOL isContinue;//是否继续执行并行队列中事务
    BOOL allTest;//是否全部开始测试
    BOOL isVoidRun;
    
    
    int successFunctionPicture;
    int failFunctionPicture;
    int blockFunctionPicture;
    int totlesFunctionPicture;
    
    int successPerformancePicture;
    int failPerformancePicture;
    int blockPerformancePicture;
    int totlesPerformancePicture;
    float minTime;
    float maxTime;
    float totleTime;
    
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:self];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cleanValueNotification" object:self];
}


#pragma mark - 右侧按钮点击事件
- (void)clickRightSetButton:(UIButton *)button{
    setViewController *setVC = [[setViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}
//收到通知
- (void)changeIntervalValue:(NSNotification *)noti{
    self.runCPUView.myInterval = [noti.userInfo[@"interval"] doubleValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIntervalValue:) name:@"changeIntervalNotification" object:nil];
    
    allTest = YES;
    //设置导航栏信息
    [MethodDIY setNavigation:self withTitle:@"MainActivity" withFontSize:19 withColor:nil];
    //设置点击右侧按钮事件
    [mainViewAction setNavigationBarRightItemWithAction:@selector(clickRightSetButton:) andViewController:self];
    
    self.modelArr = [NSMutableArray array];
    [self initData];
    //创建底部视图
    [self createCustomView];
    //创建tableView
    [self createTableView];
    self.tableView.userInteractionEnabled = YES;
    //初始化定时器相关对象和数据
    [self initLineChartViews];
    [self initVoidLineChartViews];
    
}

- (void)initData{
    //做初始化处理
    self.view.userInteractionEnabled = YES;
    isVoidRun = NO;
    self.functions = [MethodDIY getPlistWithName:@"DuFacePicture"];
    _totalArr = [self settingMarkArrWithArr:_functions];
    _showDataArr = [NSMutableArray arrayWithArray:_totalArr];
}

//测试数据初始化
- (void)initTestData{
    successFunctionPicture = failFunctionPicture = blockFunctionPicture = totlesFunctionPicture =0;
    successPerformancePicture = failPerformancePicture = blockPerformancePicture = totlesPerformancePicture = 0;
    maxTime = totleTime = 0.0;
    minTime = 99.0;
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //tableView相关
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiong.jpg"]];
    //注册nib的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AShiledLibrary.framework/mainTableViewCell" bundle:nil] forCellReuseIdentifier:@"status"];
    //只显示有数据cell的分割线
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}

//创建底部视图
- (void)createCustomView{
    UIView *bView = [mainViewAction createCustomViewWithSEL:@selector(buttonClick:) andVC:self];
    [self.view addSubview:bView];
    [self.view bringSubviewToFront:bView];
}

- (void)handleSectionArrToFunctionArr{
    if (!_functionArr) {
        _functionArr = [NSMutableArray array];
    }else{
        [_functionArr removeAllObjects];
    }
    [mainViewAction handleSectionArr:_sectionArr toFunctionArr:_functionArr];
}

//初始化testResoultModel
- (void)initTestModel{
    testModel = nil;
    testModel = [[testResoultModel alloc] init];
    testModel.totlesFunctionPicture = 0;
    testModel.totlesPerformancePicture = 0;
    testModel.minTime = 999;
    testModel.maxTime = testModel.perTime = testModel.totleTime = 0.0;
    [testModel.functionModelArr removeAllObjects];
    testModel.successFunctionPicture = 0;
    testModel.successPerformancePicture = 0;
    testModel.blockFunctionPicture = testModel.blockPerformancePicture = 0;
    testModel.failFunctionPicture = testModel.failPerformancePicture = 0;
}

#pragma mark-----------处理测试接口----------------

- (void)dealTestWithButton:(UIButton *)button andIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了开始测试...");
//    if (!testModel) {
//        testModel = [[testResoultModel alloc]init];
//    }
    
    
    if ([button.titleLabel.text isEqualToString:@"开始测试"] ||
        [button.titleLabel.text isEqualToString:@"开始空跑"]) {
        [self initTestData];
        if ( [button.titleLabel.text isEqualToString:@"开始空跑"]){
            [button setTitle:@"结束空跑" forState:UIControlStateNormal];
        }else{
            [button setTitle:@"结束测试" forState:UIControlStateNormal];
            [self initTestModel];
            _sectionArr = [self clickCheckResultBtnInCellWithIndexPath:indexPath andIsAllTest:allTest];
            [self handleSectionArrToFunctionArr];//存储到_functionArr中
        }
        button.backgroundColor = FALSE_COLOR;
        isContinue = YES;
    }else{
        if ([button.titleLabel.text isEqualToString:@"结束测试"]) {
            [button setTitle:@"开始测试" forState:UIControlStateNormal];
        }else{
            [button setTitle:@"开始空跑" forState:UIControlStateNormal];
        }
        button.backgroundColor = [UIColor grayColor];
        isContinue = NO;
    }
    
    
    [self dealUserActionWithButton:button];
    
}


- (void)dealUserActionWithButton:(UIButton *)button{
    //创建GCD
    // 并行队列的创建方法
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    if (isContinue == YES) {
        // 异步执行任务创建方法
        dispatch_async(queue, ^{
            if (isVoidRun) {
                button.enabled = NO;
                [_xCPUArr removeAllObjects];
                [self startVoidTimer];
                while (self.xRunCPUArr && (self.xRunCPUArr.count > self.xCPUArr.count)) {
//                while (self.xCPUArr.count <= 10000) {
                    [NSThread sleepForTimeInterval:self.runCPUView.myInterval];
                    NSLog(@"----- %ld ----- %ld ------",self.xRunCPUArr.count,self.xCPUArr.count);
                }
//                for (int i = 0; i < self.xCPUArr.count; i++) {
//                    [self.xRunCPUArr addObject:self.xCPUArr[i]];
//                    [self.yRunCPUArr addObject:self.xCPUArr[0]];
//
//                    [self.xRunMEMArr addObject:self.xRunMEMArr[i]];
//                    [self.yRunMENArr addObject:self.yMEMArr[0]];
//                }
                [self stopVoidTimer];
                isVoidRun = NO;
                //回到主线程，设置button
                dispatch_async(dispatch_get_main_queue(), ^{
                    button.enabled = YES;
                    [button setTitle:@"开始空跑" forState:UIControlStateNormal];
                    button.backgroundColor = [UIColor grayColor];
                });
                return ;
            }else{
                [_xCPUArr removeAllObjects];
                [_yCPUArr removeAllObjects];
                [_xMEMArr removeAllObjects];
                [_yMEMArr removeAllObjects];
                [_xRunCPUArr removeAllObjects];
                [_yRunCPUArr removeAllObjects];
                [_xRunMEMArr removeAllObjects];
                [_yRunMENArr removeAllObjects];
                
            }
            NSString *functionName;
            for (int i = 0 ; i < _functionArr.count ;   i++){
                NSMutableArray *arr = _functionArr[i];
                for (int j = 0; j < arr.count; j++) {
                    if (isContinue == NO) {
                        self.isTestModel.isTest = NO;
                        return ;
                    }
                    if ([arr[j] isKindOfClass:[NSString class]]) {
                        functionName = arr[j];
//                        NSLog(@"name: %@ ",functionName);
                    }else if ([arr[j] isKindOfClass:[functionsCellModel class]]) {
                        functionsCellModel *cellModel = arr[j];
                        cellModel.teResoult = @"-1";
                        cellModel.fatherName = functionName;
                        //调用用户创建的方法类
                        Class cl = NSClassFromString(cellModel.fatherName);
                        NSObject *object;
                        if ([cl respondsToSelector:NSSelectorFromString(@"sharedInstance")]) {
                            object = [cl sharedInstance];
                            if ([object respondsToSelector:NSSelectorFromString(@"initData")]){
                                [object performSelector:NSSelectorFromString(@"initData") withObjects:nil];
                            }
                        }else{
                            object = [[cl alloc] init];
                            if ([object respondsToSelector:NSSelectorFromString(@"initData")]){
                                [object performSelector:NSSelectorFromString(@"initData") withObjects:nil];
                            }
                        }
                        NSString *action = [NSString stringWithFormat:@"%@_test",cellModel.userID];
                        if ([object respondsToSelector:NSSelectorFromString(action)]) {
                            [self startTimer];
                            NSDictionary *dic = [object performSelector:NSSelectorFromString(action) withObjects:nil];
                            [self stopTimer];
                            [self setResoultModelWithCellModel:cellModel andTestModel:testModel andDictionary:dic];
                            //回到主线程,刷新tableView
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView reloadData];
                            });
                        }else{
                            NSLog(@"自定义类中未定义方法....");
                        }
                    }
                }
            }
            
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                self.isTestModel.isTest = NO;
                [self.tableView reloadData];
                [button setTitle:@"开始测试" forState:UIControlStateNormal];
                button.backgroundColor = [UIColor grayColor];
            });
            
        });
    }
}

- (NSMutableArray *)settingMarkArrWithArr:(NSArray *)arr {
    
    NSMutableArray *totalArr = [[NSMutableArray alloc] init];
    
    if (arr != nil && arr.count >0) {
        
        for (NSDictionary *dict in arr) {
            
            NSMutableArray *markArr = [[NSMutableArray alloc] init];
            
            functionsCellModel *model = [[functionsCellModel alloc] init];
            model.name = dict[@"name"];
            model.isTest = NO;
            if(dict[@"beginName"])   model.beginName = dict[@"beginName"];
            if(dict[@"endName"])     model.endName = dict[@"endName"];
            if(dict[@"livingAction"])model.livingAction = dict[@"livingAction"];
            if(dict[@"testImage"])   model.testImage = dict[@"testImage"];
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
            
            model.childModel = markArr;
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

//设置调用结束后的model参数
- (void)setResoultModelWithCellModel:(functionsCellModel *)cellModel andTestModel:(testResoultModel *)testRModel andDictionary:(NSDictionary *)dic{
    if (dic[@"teResoult"]) {
        cellModel.teResoult = dic[@"teResoult"];
        if ([cellModel.exResult isEqualToString:cellModel.teResoult]) {
            cellModel.judgement = @"True";
            cellModel.color = SUCESS_COLOR;
        }else if([cellModel.teResoult isEqualToString:@"-1"]){
            cellModel.judgement = @"False";
            cellModel.color = OTHER_COLOR;
        }else{
            cellModel.judgement = @"False";
            cellModel.color = FALSE_COLOR;
        }
    }
    if (dic[@"useTime"]) {
        cellModel.useTime = [dic[@"useTime"] doubleValue];
    }
    
    if (dic[@"minTime"]) {
        minTime = minTime < [dic[@"minTime"] floatValue] ? minTime : [dic[@"minTime"] floatValue];
        testRModel.minTime = minTime;
    }
    if (dic[@"maxTime"]) {
        maxTime = maxTime > [dic[@"maxTime"] floatValue] ? maxTime : [dic[@"maxTime"] floatValue];
        testRModel.maxTime = maxTime;
    }
    if (dic[@"totleTime"]) {
        totleTime += [dic[@"totleTime"] floatValue];
        testRModel.totleTime = totleTime;
    }
    if (dic[@"successFunctionPicture"]) {
        successFunctionPicture += [dic[@"successFunctionPicture"] intValue];
        testRModel.successFunctionPicture = successFunctionPicture;
    }
    if (dic[@"successPerformancePicture"]) {
        successPerformancePicture += [dic[@"successPerformancePicture"] intValue];
        testRModel.successPerformancePicture = successPerformancePicture;
    }
    if (dic[@"failFunctionPicture"]) {
        failFunctionPicture += [dic[@"failFunctionPicture"] intValue];
        testRModel.failFunctionPicture = failFunctionPicture;
    }
    if (dic[@"failPerformancePicture"]) {
        failPerformancePicture += [dic[@"failPerformancePicture"] intValue];
        testRModel.failPerformancePicture = failPerformancePicture;
    }
    if (dic[@"blockFunctionPicture"]) {
        blockFunctionPicture += [dic[@"blockFunctionPicture"] intValue];
        testRModel.blockFunctionPicture = blockFunctionPicture;
    }
    if (dic[@"blockPerformancePicture"]) {
        blockPerformancePicture += [dic[@"blockPerformancePicture"] intValue];
        testRModel.blockPerformancePicture = blockPerformancePicture;
    }
    if (dic[@"totlesFunctionPicture"]) {
        totlesFunctionPicture += [dic[@"totlesFunctionPicture"] intValue];
        testRModel.totlesFunctionPicture = totlesFunctionPicture;
    }
    if (dic[@"totlesPerformancePicture"]) {
        totlesPerformancePicture += [dic[@"totlesPerformancePicture"] intValue];
        testRModel.totlesPerformancePicture = totlesPerformancePicture;
    }
    //记录获取到结果的图片测试model
    if (![testRModel.functionModelArr containsObject:cellModel]) {
        [testRModel.functionModelArr addObject:cellModel];
    }
    
}

#pragma mark----------- 底部按钮点击处理事件 ------------
- (void)buttonClick:(UIButton *)button{
    
    if (button.tag == 110) {
        allTest = YES;
        isVoidRun = NO;
        [self dealTestWithButton:button andIndexPath:0];
        
    }else if (button.tag == 111){
        NSLog(@"点击了测试报告...");
        testReportViewController *vc = [[testReportViewController alloc]init];
        if (testModel) {
            NSLog(@"-----%d",testModel.functionModelArr.count);
            [testModel initdataFromArray];
            vc.resoultModel = testModel;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"点击了开始空跑...");
        isVoidRun = YES;
        [self dealTestWithButton:button andIndexPath:0];
    }
}

- (void)initLineChartViews{
    self.runCPUView = [[LineChartViews alloc]init];
    self.runCPUView.myInterval = 30;
    self.runCPUView.isMemory = NO;
    self.runMEMView = [[LineChartViews alloc]init];
    self.runMEMView.myInterval = 30;
    self.runMEMView.isMemory = YES;

    _xRunCPUArr = [NSMutableArray array];
    _yRunCPUArr = [NSMutableArray array];
    _xRunMEMArr = [NSMutableArray array];
    _yRunMENArr = [NSMutableArray array];
    //把数据保存在数组中
    [self.runCPUView setDataWithxArray:_xRunCPUArr andYArray:_yRunCPUArr];
    [self.runMEMView setDataWithxArray:_xRunMEMArr andYArray:_yRunMENArr];
}

- (void)startTimer{
    [self.runCPUView startTimer];
    [self.runMEMView startTimer];
}

- (void)startVoidTimer{
    [self.CPUView startTimer];
    [self.MEMView startTimer];
}

- (void)initVoidLineChartViews{
    self.CPUView = [[LineChartViews alloc]init];
    self.CPUView.isMemory = NO;
    self.MEMView = [[LineChartViews alloc]init];
    self.MEMView.isMemory = YES;
    _xCPUArr = [NSMutableArray array];
    _yCPUArr = [NSMutableArray array];
    _xMEMArr = [NSMutableArray array];
    _yMEMArr = [NSMutableArray array];
    [self.CPUView setDataWithxArray:_xCPUArr andYArray:_yCPUArr];
    [self.MEMView setDataWithxArray:_xMEMArr andYArray:_yMEMArr];
}

- (void)stopVoidTimer{
    [self.CPUView closeTimer];
    [self.MEMView closeTimer];
}

- (void)stopTimer{
    [self.runCPUView closeTimer];
    [self.runMEMView closeTimer];
    [self.tableView reloadData];
}

- (void)warningStatus:(WarningStatus)status warning:(NSString *)warning conditionMeet:(BOOL)meet{
    self.circleView.conditionStatusFit = meet;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_showDataArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"status";
    mainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    functionsCellModel *model = _showDataArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.tableView = tableView;
    [cell setCellWithModel:model];
    
    __weak typeof(testModel) weakTestModel = testModel;
    cell.clickResultBtnBlock = ^(functionsCellModel *cellModel) {
        
        functionsCellModel *model = cellModel;
        if ([model.name isEqualToString:@"1-功能"]) {
            FunctionViewController *fun = [[FunctionViewController alloc]init];
            if (weakSelf.functionArr) {
                fun.functionArr = weakSelf.functionArr;
            }
            [weakSelf.navigationController pushViewController:fun animated:YES];
        }
        else if ([model.name isEqualToString:@"2- 性能"]){
            //进入功能界面
            NSLog(@"进入性能界面...");
            
            NSBundle *bundle = [NSBundle bundleForClass:[performanceVCViewController class]];
            
            performanceVCViewController *perVC = [[performanceVCViewController alloc] initWithNibName:@"performanceVCViewController" bundle:bundle];
            if (weakTestModel) {
                [weakTestModel initdataFromArray];
                perVC.resoultModel = weakTestModel;
            }
             //数据传递
            perVC.xRunCPUArr = weakSelf.xRunCPUArr;
            perVC.yRunCPUArr = weakSelf.yRunCPUArr;
            perVC.xCPUArr = weakSelf.xCPUArr;
            perVC.yCPUArr = weakSelf.yCPUArr;
            perVC.xRunMEMArr = weakSelf.xRunMEMArr;
            perVC.yRunMENArr = weakSelf.yRunMENArr;
            perVC.xMEMArr = weakSelf.xMEMArr;
            perVC.yMEMArr = weakSelf.yMEMArr;
            
            NSLog(@"xRunCPUArr : %ld",weakSelf.xRunCPUArr.count);
            NSLog(@"yRunCPUArr : %ld",weakSelf.yRunCPUArr.count);
            NSLog(@"xCPUArr : %ld",weakSelf.xCPUArr.count);
            NSLog(@"yCPUArr : %ld",weakSelf.yCPUArr.count);
            NSLog(@"xRunMEMArr : %ld",weakSelf.xRunMEMArr.count);
            NSLog(@"yRunMENArr : %ld",weakSelf.yRunMENArr.count);
            NSLog(@"xMEMArr : %ld",weakSelf.xMEMArr.count);
            NSLog(@"yMEMArr : %ld",weakSelf.yMEMArr.count);
            
            [weakSelf.navigationController pushViewController:perVC animated:YES];
        }
        else{
            //进入稳定性界面
            NSLog(@"进入稳定性界面...");
        }
        
    };
    __block typeof(allTest) weakAllTest = allTest;
    __block typeof(model) weakModel = model;
    cell.clickTestBtnBlock = ^(UIButton *button) {
        weakSelf.isTestModel = weakModel;
        weakAllTest = NO;
        weakModel.isTest = YES;
        [weakSelf dealTestWithButton:button andIndexPath:indexPath];
    };
    cell.clickSelectBtnBlock = ^(NSIndexPath *indexP) {
        [weakSelf clickSelectBtnInCellWithIndexPath:indexP];
    };
    return cell;
}

#pragma mark  点击查看结果后获取选中的二级名字和三级model (NSString和functionCellModel类型)
- (NSMutableArray *)clickCheckResultBtnInCellWithIndexPath:(NSIndexPath *)indexPath  andIsAllTest:(BOOL)isAllTest{
    
    NSMutableArray *source = [mainViewAction clickCheckResultBtnInCellWithIndexPath:indexPath andArray:_showDataArr isAllTest:isAllTest];
    return source;
}

#pragma mark -----点击cell左侧选中按钮触发事件--------
- (void)clickSelectBtnInCellWithIndexPath:(NSIndexPath *)indexpath {
    [mainViewAction clickSelectBtnInCellWithIndexPath:indexpath andArray:_showDataArr andSaveArr:_modelArr];
    [self.tableView reloadData];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [mainViewAction tableView:tableView didSelectRowAtIndexPath:indexPath withArray:_showDataArr andSaveArr:_modelArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
