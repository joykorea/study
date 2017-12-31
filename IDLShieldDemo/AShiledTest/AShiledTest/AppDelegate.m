//
//  AppDelegate.m
//  AShiledTest
//
//  Created by baidu on 2017/10/30.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "AppDelegate.h"
#import "showViewController.h"
#import "FaceSDK.h"
#import "License.h"

#import <GestureDebug/DetectClassifyInterface.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    IdcardQualityAdaptor *adaptor = [[IdcardQualityAdaptor alloc] init];
//
//    [adaptor initWithToken:[self getMyToken:0]];
//
//    IdcardQualityModel * model = [adaptor process:[UIImage imageNamed:@"adaa.jpg"] width:nil height:nil channel:3 cardType:@"IDCARD_FRONT_SIDE"];
//
//    NSLog(@"------ model -------\n %@",model);
    
    // 配置手势识别SDK授权信息
    NSString *licensePath = [[NSBundle mainBundle] pathForResource:@"gesture-license" ofType:@"face-ios"];
    [[DetectClassifyInterface sharedInstance] verifyLicenceKey:@"SDKLLDS-face-ios" withPath:licensePath];
    
    
//    [[FaceVerifier sharedInstance] initWithToken:[License getMyToken:0]];
//    NSString *licensePatha = [[NSBundle mainBundle] pathForResource:@"idl-license-2" ofType:@"face-ios"];
//    [[FaceVerifier sharedInstance] setLicenseID:@"SDKLLDS-face-ios" andLocalLicenceFile:licensePatha];
//    NSLog(@"canwork: %u",[[FaceVerifier sharedInstance] canWork]);
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //创建FunctionVC和导航栏
    showViewController *showVC = [[showViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:showVC];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyWindow];
    
    // 获取系统崩溃日志 by 李迪生
    [self installUncaughtExcptionHandler];
    
    
    
    return YES;
}

//- (NSString*)getMyToken:(int)offset//offset 设置为0
//{
//    NSString* key = @"IdcardQualityAdaptor-yanxiangda@baidu.com";
//    const char* cKey = [key UTF8String];
//    unsigned char result[16];
//    genToken(cKey, result, offset);
//    NSString *mytoken = [NSString stringWithFormat:
//                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//                         result[0], result[1], result[2], result[3],
//                         result[4], result[5], result[6], result[7],
//                         result[8], result[9], result[10], result[11],
//                         result[12], result[13], result[14], result[15]
//                         ];
//    NSLog(@"[In BankcardAdaptor] offset = %d, myToken = %@", offset, mytoken);
//    return mytoken;
//}
//
//void static genToken(const char seed[32], unsigned char token[16], int offset)  {
//    int i;
//    if(token==NULL || seed==NULL){
//        return;
//    }
//
//    time_t t = (time(NULL)/5 + offset)*5;
//    char st[11] = {'\0'};
//    sprintf(st,"%ld", t);
//    //char* p =(char*)&t;
//    unsigned char processData[43] = {'\0'};
//    int is = 0;
//    int it = 0;
//    for(i=0; i<42; i++) {
//        if((i%2 == 1) && (it < 10)) {
//            processData[i] = st[it++];
//        } else {
//            processData[i] = seed[is++];
//        }
//    }
//
//    CC_MD5(processData, 42, token);
//}


- (NSString *)getLicense {
    NSString *licensePath = [[NSBundle mainBundle] pathForResource:@"aip_license" ofType:nil];
    NSError *error = nil;
    NSString* licensePathContents = [NSString stringWithContentsOfFile:licensePath encoding:NSUTF8StringEncoding error:&error];
    
    return licensePathContents;
}

- (void)installUncaughtExcptionHandler{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
void UncaughtExceptionHandler(NSException *exception){
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *urlStr = [NSString stringWithFormat:@"\n----------Bug报告！----------\n错误详情(%@):%@\n----------\n%@\n----------\n%@\n\n\n",currentVersion,name,reason,[arr componentsJoinedByString:@"<br>"]];
    //此处可保存为Log日志
    NSLog(@"%@",urlStr);
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
