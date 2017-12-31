//
//  MethodDIY.m
//  SDKTestDemo
//
//  Created by baidu on 2017/8/29.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "Method.h"




@implementation MethodDIY

+(UIImage *)getImageFromLineChartsView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)getImageResourceForName:(NSString *)name {
    NSString* bundlepath = [[NSBundle mainBundle] pathForResource:@"com.baidu.idl.face.faceSDK.bundle" ofType:nil];
    NSBundle* modelBundle = [NSBundle bundleWithPath:bundlepath];
    NSString* imagePath = [modelBundle pathForResource:name ofType:@"png"];
    return [[UIImage alloc] initWithContentsOfFile:imagePath];
}

+ (CGRect)convertRectFrom:(CGRect)imageRect imageSize:(CGSize)imageSize detectRect:(CGRect)detectRect {
    CGPoint imageTopLeft = imageRect.origin;
    CGPoint imageBottomRight = CGPointMake(CGRectGetMaxX(imageRect),CGRectGetMaxY(imageRect));
    
    CGPoint viewTopLeft = [self convertPointFrom:imageTopLeft imageSize:imageSize detectSize:detectRect.size];
    CGPoint viewBottomRight = [self convertPointFrom:imageBottomRight imageSize:imageSize detectSize:detectRect.size];
    
    return CGRectMake(viewTopLeft.x, viewTopLeft.y, viewBottomRight.x - viewTopLeft.x, viewBottomRight.y - viewTopLeft.y);
}
+ (CGPoint)convertPointFrom:(CGPoint)imagePoint imageSize:(CGSize)imageSize detectSize:(CGSize)detectSize {
    CGPoint viewPoint = imagePoint;
    CGFloat scale = MAX(detectSize.width / imageSize.width, detectSize.height / imageSize.height);
    viewPoint.x *= scale;
    viewPoint.y *= scale;
    viewPoint.x += (detectSize.width - imageSize.width * scale) / 2.0;
    viewPoint.y += (detectSize.height - imageSize.height * scale) / 2.0;
    return viewPoint;
}

+ (NSMutableArray *)getPlistWithName:(NSString *)name{
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    
    return [[NSDictionary alloc]initWithContentsOfFile:path][@"Objects"];
}

+ (void)setNavigation:(UIViewController *)vc withTitle:(NSString *)title withFontSize:(CGFloat)size withColor:(UIColor *)color{
    //默认颜色黑色
    if (!color) {
        color = [UIColor blackColor];
    }
    
    vc.navigationItem.title = title;
    [vc.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:size],
       NSForegroundColorAttributeName:color}];
}


+ (UIView *)createCustomButtonwithNumber:(int)num andTitles:(NSArray *)title action:(nonnull SEL)action fromVC:(UIViewController *)firstVC{
    UIView *view = [[UIView alloc]init];
    float width = ([UIScreen mainScreen].bounds.size.width - num*5 - 5)/ num;
    
    for (int a = 0; a < num; a++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5 + a*(width + 5), 5, width, 50);
        [button setTitle:title[a] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.backgroundColor = [UIColor orangeColor];
        button.tag = 100 + a;
        
        [button addTarget:firstVC action:action forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
    
}

+ (UIButton *)createCustomButtonWithTitle:(NSString *)title{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.backgroundColor = [UIColor orangeColor];
    
    return button;
    
}

//向plist写内容
+(void)writeFileToplistwithDictionary:(NSDictionary *)dic
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"testRun.plist"];//这里就是你将要存储的沙盒路径（.plist文件，名字自定义）
    
    NSLog(@"%@",plistPath);
    NSString *xmlString = [XMLWriter XMLStringFromDictionary:dic];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSData *data = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        BOOL b = [manager createFileAtPath:plistPath contents:nil attributes:nil];
        if (b) {
            NSLog(@"------1----- %@创建成功",xmlString);
        }else{
            NSLog(@"------1----- %@创建不成功",xmlString);
        }
        NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:[documentsDirectory stringByAppendingString:@"testRun.plist"]];
        [handle writeData:data];
        
        
    }else{
        [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil];
        BOOL b = [manager createFileAtPath:plistPath contents:nil attributes:nil];
        if (b) {
            NSLog(@"------2----- %@创建成功",xmlString);
        }else{
            NSLog(@"------2----- %@创建不成功",xmlString);
        }
        NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:[documentsDirectory stringByAppendingString:@"testRun.plist"]];
        [handle writeData:data];
    }
    
}


@end
