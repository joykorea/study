//
//  testReportViewController.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/29.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "testReportViewController.h"
#import "XMLWriter.h"
#import "FileManager.h"
#import "createHtmlString.h"
#import "netWork.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface testReportViewController ()<UIWebViewDelegate>

@end

@implementation testReportViewController{
    NSString *htmlString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    if (!self.resoultModel.conclusionArr.count || !self.resoultModel.performanceDetailsArr.count) {
        NSLog(@"没有数据");
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.image = [UIImage imageNamed:@"xiong.jpg"];
        
        [self.view addSubview:imageView];
        
    }else{
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        
        [self createHtml];
    }
    
    
    
}

// 读取写入的文件

- (NSString *)readingFileWithNsstring:(NSString *)string
{
    // 获取路径
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    
    //读data
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",string]];
    return dataPath;
}

#pragma mark------创建HTML字符串-----------

- (void)createHtml{
    //表格名称数组
    self.titles = [NSMutableArray arrayWithObjects:@"测试结论",@"功能详情",@"性能详情", nil];
    //表格头名称
    self.headArr = [NSMutableArray arrayWithObjects:
                    @[@"类型",@"case",@"block",@"pass",@"fail"],
                    @[@"caseName",@"预期结果",@"测试结果",@"耗时",@"是否通过"],
                    @[@"case总数",@"成功调用",@"平均时间",@"最大时间",@"最小时间"], nil];
    NSString *runCPUURL;
    NSString *runMEMURL;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"iOS_runCPUView"]) {
        runCPUURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"iOS_runCPUView"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"iOS_runMEMView"]) {
        runMEMURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"iOS_runMEMView"];
    }
    NSString *runCPUStr = [NSString stringWithFormat:@"<a href=\"%@\"><img src=\"%@\"  colspan=\"4\" height=\"150\" ></a>",runCPUURL,runCPUURL];
    NSString *runMEMStr = [NSString stringWithFormat:@"<a href=\"%@\"><img src=\"%@\"  colspan=\"4\" height=\"150\" ></a>",runMEMURL,runMEMURL];
    
    self.rowArr = [NSMutableArray arrayWithObjects:
                   @[self.resoultModel.conclusionArr[0],
                     self.resoultModel.conclusionArr[1]
                     ],
                   self.resoultModel.functionDetailsArr,
                   @[self.resoultModel.performanceDetailsArr[0],
                     @[@"CPU消耗",runCPUStr],
                     @[@"内存消耗",runMEMStr]
                     ],
                   nil];
    NSMutableArray *functionDetailStyle = [NSMutableArray arrayWithCapacity:self.resoultModel.functionDetailsArr.count];
    for (int i = 0; i < self.resoultModel.functionDetailsArr.count; i++) {
        NSArray *arr = [NSArray array];
        [functionDetailStyle addObject:arr];
    }
    NSString *imageCPUStr = [NSString stringWithFormat:@"colspan=\"4\" height=\"150\" "];
    NSString *imageMEMStr = [NSString stringWithFormat:@"colspan=\"4\" height=\"150\" "];
    self.styleArr = [NSMutableArray arrayWithObjects:
                     @[@[],
                       @[],
                       @[]
                       ],
                     functionDetailStyle,
                     @[@[],
                       @[@"colspan=\"1\" height=\"150\"",imageCPUStr],
                       @[@"colspan=\"1\" height=\"150\"",imageMEMStr]
                       ],
                     nil];
    
    
    htmlString = [createHtmlString createHtmlWithTitles:self.titles
                                           andHeadArray:self.headArr
                                            andRowArray:self.rowArr
                                               andStyle:self.styleArr];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"eMailString"]) {
        [[NSUserDefaults standardUserDefaults] objectForKey:@"v_lidisheng"];
    }
    NSString *emailString = [[NSUserDefaults standardUserDefaults] objectForKey:@"eMailString"];
    //    post请求，返回值为生成的html的网址
    NSString *htmlPath = [netWork postWithNsstring:htmlString andEMailString:emailString];
    NSLog(@"emailString ： %@ , htmlPath : %@",emailString,htmlPath);
    //
    //    NSURL *localURL=[[NSURL alloc]initFileURLWithPath:htmlPath];
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:localURL]];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
}

- (NSString *)createHtmlStringTest{
    
    createHtmlString *html = [[createHtmlString alloc]init];
    //0 开始创建html信息
    [html createHtmlHead];
    //1  表标题
    [html createHtmlTableHeadWithTitle:@"测试结论"];
    //2  表头信息
    [html createHtmlHeadWithArray:@[@"类型",@"测试集",@"成功次数",@"成功率",@"结论"]];
    //3 添加每一行的信息,可多次添加
    [html createHtmlTableRowWithArray:@[@"功能",@"1111",@"1111",@"100%",@"通过"] withStyle:nil];
    [html createHtmlTableRowWithArray:@[@"性能",@"2000",@"1999",@"99%",@"通过"] withStyle:nil];
    //4 结束本表格的添加
    [html endHtmlHead];
    //5 结束本次html中表格的编写
    NSString *str= [html endEditHtml];
    
    return str;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    NSString *headerStr = @"document.getElementById(\"Function\").innerText = '1234张'";
    //    [webView stringByEvaluatingJavaScriptFromString:headerStr];
    
}


#pragma mark------数组懒加载-------

- (NSMutableArray *)getTitles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
- (NSMutableArray *)getHeadArr{
    if (!_headArr) {
        _headArr = [NSMutableArray array];
    }
    return _headArr;
}
- (NSMutableArray *)getRowArr{
    if (!_rowArr) {
        _rowArr = [NSMutableArray array];
    }
    return _rowArr;
}
- (NSMutableArray *)getStyleArr{
    if (!_styleArr) {
        _styleArr = [NSMutableArray array];
    }
    return _styleArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
