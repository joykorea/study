//
//  showViewController.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/30.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "showViewController.h"
#import "FaceSDK.h"

@interface showViewController ()

@end

@implementation showViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [MethodDIY setNavigation:self withTitle:@"ASheild" withFontSize:19 withColor:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Show.jpg"]];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // 设置返回按钮的背景图片
    
    
    self.label.text = [NSString stringWithFormat:@"鉴权状态：%d",[[FaceVerifier sharedInstance] canWork]];
    
}


- (IBAction)goMainVC:(UIButton *)sender {
    
    
    mainViewController *fun = [[mainViewController alloc]init];
    [self.navigationController pushViewController:fun animated:YES];
    
}

- (IBAction)goDemo:(UIButton *)sender {
    
    
    
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
