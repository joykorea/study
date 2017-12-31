//
//  setViewController.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "setViewController.h"
//#import "IDLFaceSDK/IDLFaceSDK.h"
#import "netWork.h"

@interface setViewController ()<UITextFieldDelegate>

@end

@implementation setViewController{
    CGRect lastRect;
    NSInteger textfildTag;
    UIAlertView *alert;
    NSString *message;
    UILabel *label;
    NSString *eMailString;
    UITextView *textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"123");
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //键盘通知
    [defaultCenter addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    
    [defaultCenter addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self createTextView];
    
}

- (void)createTextView{
    
    float width = [UIScreen mainScreen].bounds.size.width;
//    float height = [UIScreen mainScreen].bounds.size.height;
    textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, width-40, 200)];
    __weak typeof(self) weakSelf = self;
    textView.delegate = weakSelf;
    textView.font = [UIFont systemFontOfSize:18];
    textView.keyboardType = UIKeyboardTypeASCIICapable;
//    textView.contentInset = UIEdgeInsetsMake(10, 10, 10, -10);
    
    textView.scrollEnabled = YES;
    
    [self.view addSubview:textView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, width-46, 50)];
    label.numberOfLines = 0;
    
    label.enabled = NO;
    
    label.text = @"请输入测试报告接收人邮箱前缀(@前部分)，不同收件人以英文','隔开。";
    
    label.font =  [UIFont systemFontOfSize:18];
    
    label.textColor = [UIColor lightGrayColor];
    
    [textView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, 320, width - 120, 60);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"设置收件人" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)buttonOnClick:(UIButton *)button{
    [[NSUserDefaults standardUserDefaults] setObject:eMailString forKey:@"eMailString"];
//    [netWork postWithEMailString:eMailString];
    [textView resignFirstResponder];
    if (eMailString.length > 0) {
        alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"设置完成！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"邮箱为空！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    NSLog(@"完成");
}

- (void) textViewDidChange:(UITextView *)textView{
    if (textView.text.length < 1) {
        label.hidden = NO;
        return;
    }
    NSString *str = [textView.text substringFromIndex:textView.text.length-1];
    if ([str isEqualToString:@"@"]) {
        alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"不需要填写邮箱后缀：@xxx.com！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        textView.text = [textView.text substringToIndex:textView.text.length-1];
    }
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
    }
    eMailString = textView.text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 键盘通知回调
- (void)keyboardWillShowOrHide:(NSNotification *)notification
{
    //获取通知名
    NSString *notificationName = notification.name;
    //获取通知内容
    NSDictionary *keyboardInfo = notification.userInfo;
    
    //键盘弹出时，让画面整体稍稍上移，并伴随动画
    //键盘回收时反之
//    NSLog(@"keyboardInfo: %@", keyboardInfo);
    
    //动画结束后self.view的frame值
    CGRect selfViewFrame = self.view.frame;
    if (textfildTag >= 408) {
        //通过通知名字判断弹出还是回收
        if ([notificationName isEqualToString:UIKeyboardWillShowNotification]) {
            selfViewFrame.origin.y = -170;
        }
        else {
            selfViewFrame.origin.y = 0;
        }
    }
    //取出动画时长
    NSTimeInterval duration = [keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //使用动画更改self.view.frame
    [UIView animateWithDuration:duration animations:^{
        //这里填入一些view的最终状态属性设置，即会自动产生过渡动画
        self.view.frame = selfViewFrame;
    }];
    
}

- (IBAction)clickFinishButton:(UIButton *)sender {
    
    NSLog(@"点击了设置完成按钮...");
    alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"未填写项将设置为默认值！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
//    [self setPrepertyByTextField];
    
}

//- (void)setPrepertyByTextField{
//    
//    // 设置是否进行人脸图片质量检测
//    [[FaceSDKManager sharedInstance] setIsCheckQuality:self.ischeckQuality.selectedSegmentIndex];
//    
//    if (!self.minFaceSize.text.length){
//        // 设置最小检测人脸阈值
//        [[FaceSDKManager sharedInstance] setMinFaceSize:200];
//    }else{
//        [[FaceSDKManager sharedInstance] setMinFaceSize:[self.minFaceSize.text integerValue]];
//    }
//    
//    if (!self.cropFaceSizeWidth.text.length){
//        // 设置截取人脸图片大小
//        [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:400];
//    }else{
//        // 设置截取人脸图片大小
//        [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:[self.cropFaceSizeWidth.text integerValue]];
//    }
//    
//    if (!self.occluThreshold.text.length){
//        // 设置人脸遮挡阀值
//        [[FaceSDKManager sharedInstance] setOccluThreshold:0.5];
//    }else{
//        [[FaceSDKManager sharedInstance] setOccluThreshold:[self.occluThreshold.text floatValue]];
//    }
//    
//    if (!self.illumThreshold.text.length){
//        // 设置亮度阀值
//        [[FaceSDKManager sharedInstance] setIllumThreshold:40];
//    }else{
//        [[FaceSDKManager sharedInstance] setIllumThreshold:[self.illumThreshold.text integerValue]];
//    }
//    
//    if (!self.blurThreshold.text.length){
//        // 设置图像模糊阀值
//        [[FaceSDKManager sharedInstance] setBlurThreshold:0.7];
//    }else{
//        [[FaceSDKManager sharedInstance] setBlurThreshold:[self.blurThreshold.text floatValue]];
//    }
//    
//    if (!self.pitch.text.length){
//        // 设置头部姿态角度
//        [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
//    }else{
//        [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:[self.pitch.text integerValue] yaw:10 roll:10];
//    }
//    //此处需要特殊处理
//    if (!self.yaw.text.length){
//        // 设置头部姿态角度
//        [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
//    }else{
//         [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:[self.pitch.text integerValue] yaw:10 roll:10];
//    }
//    
//    if (!self.roll.text.length){
//        // 设置头部姿态角度
//        [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
//    }else{
//         [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:[self.pitch.text integerValue] yaw:10 roll:10];
//    }
//    
//    //    if (!self.ischeckQuality)
//    if (!self.conditionTimeout.text.length){
//        // 设置超时时间
//        [[FaceSDKManager sharedInstance] setConditionTimeout:10];
//    }else{
//        [[FaceSDKManager sharedInstance] setConditionTimeout:[self.conditionTimeout.text floatValue]];
//    }
//    
//    if (!self.notFaceThreshold.text.length){
//        // 设置人脸检测精度阀值
//        [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.6];
//    }else{
//        [[FaceSDKManager sharedInstance] setNotFaceThreshold:[self.notFaceThreshold.text floatValue]];
//    }
//    
//    if(!self.cropFaceEnlargeRatio.text.length){
//        [[FaceVerifier sharedInstance] cropFaceEnlargeRatio:3.0];
//    }else{
//        [[FaceVerifier sharedInstance] cropFaceEnlargeRatio:[self.cropFaceEnlargeRatio.text floatValue]];
//    }
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (SetCode)getsetCode{
    if (!self.minFaceSize.text.length)
        return ResultCodeMinFaceSize;
    
    if (!self.cropFaceSizeWidth.text.length)
        return ResultCodeCropFaceSizeWidth;
    
    if (!self.occluThreshold.text.length)
        return ResultCodeOccluThreshold;
    
    if (!self.illumThreshold.text.length)
        return ResultCodeIllumThreshold;
    
    if (!self.blurThreshold.text.length)
        return ResultCodeBlurThreshold;
    
    if (!self.pitch.text.length)
        return ResultCodePitch;
    
    if (!self.yaw.text.length)
        return ResultCodEyaw;
    
    if (!self.roll.text.length)
        return ResultCodeRoll;
    
//    if (!self.ischeckQuality)
    if (!self.conditionTimeout.text.length)
        return ResultCodeConditionTimeout;
    
    if (!self.notFaceThreshold.text.length)
        return ResultCodeNotFaceThreshold;
    
    if(!self.cropFaceEnlargeRatio.text.length)
        return ResultCodeCropFaceEnlargeRatio;
    
    else
        return -1;
}

#pragma mark - 文本框代理方法



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textfildTag = textField.tag;
    
}
#pragma mark - 文本框文字发生改变之前调用
//判断文本将会如何改变，返回一个布尔值表示是否允许改变
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textfildTag = textField.tag;
    //获得改变前（现在）的文本
    NSString *currentText = textField.text;
    //“预测”改变后的文本
    NSString *changedText = [currentText stringByReplacingCharactersInRange:range withString:string];
    if (changedText.length > 10) {
        
        alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"输入过长，请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好哒", nil];
        [alert show];
        textField.text = @"";
//        textField.placeholder = textField.placeholder;
        return NO;
    }
    
        return YES;
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
