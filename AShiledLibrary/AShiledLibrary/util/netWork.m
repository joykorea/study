//
//  netWork.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "netWork.h"
#import "Method.h"

@implementation netWork

+ (NSString *)postWithEMailString:(NSString *)string{
    // 1. 网络访问
    // 1) URL
    NSURL *url = [NSURL URLWithString:@"http://cp01-idl-test-1002.epc.baidu.com:8383/"];
    
    // 2) URLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
    
    // 1> HTTPMethod访问方法
    request.HTTPMethod = @"POST";
    NSDictionary *dic = @{@"recevierMail":string};
    NSData *dicData =    [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    //    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // 2> HTTPBody数据体 NSData
    //    request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = dicData;
    
    // 登录一般为同步请求，发送同步请求
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"---eMailStr----%@", result);
    return result;
}

+ (NSString *)postWithNsstring:(NSString *)string andEMailString:(NSString *)eMailStrong{
    // 1. 网络访问
    // 1) URL
    NSURL *url = [NSURL URLWithString:@"http://cp01-idl-test-1002.epc.baidu.com:8383/"];
    
    // 2) URLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
    
    // 1> HTTPMethod访问方法
    request.HTTPMethod = @"POST";
    if (eMailStrong.length == 0) {
        eMailStrong = @"";
    }
    NSDictionary *dic = @{@"html":string,@"recevierMail":eMailStrong};
    NSData *dicData =    [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // 2> HTTPBody数据体 NSData
//    request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = dicData;
    
    // 登录一般为同步请求，发送同步请求
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"---htmlStr----%@", result);
    return result;
}

+ (NSString *)postImage:(UIImage *)image withImageKey:(NSString *)imageKey{
    
    // 1. 获取用户名和密码
    // 2. 网络访问
    // 1) URL
    NSURL *url = [NSURL URLWithString:@"http://cp01-idl-test-1002.epc.baidu.com:8383/"];
    
    // 2) URLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
    
    // 1> HTTPMethod访问方法
    request.HTTPMethod = @"POST";
    NSData *imageData = UIImageJPEGRepresentation(image,1);
    NSString *imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *dic = @{@"image":imageStr,@"imageKey":imageKey};
    NSData *dicData =    [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // 2> HTTPBody数据体 NSData
    request.HTTPBody = dicData;
    
    // 登录一般为同步请求，发送同步请求
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [netWork saveURL:[NSArray arrayWithObjects:result,imageKey, nil]];
    NSLog(@"---imageStr----%@   %@", result,imageKey);
    return result;
}

+ (void)saveURL:(NSArray *)array{
    if (!array || array.count != 2) {
        return;
    }
    //把图片地址存入plist文件
    [[NSUserDefaults standardUserDefaults] setObject:array[0] forKey:array[1]];
}


+ (void)postSessionWithImage:(UIImage *)image{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://cp01-idl-test-1002.epc.baidu.com:8383/"];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（POST）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *args = [NSString stringWithFormat:@"image=%@",imageStr];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到image数据");
        /*
         对从服务器获取到的数据data进行相应的处理.
         */
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

+ (void)postSessionWithHtml:(NSString *)string{
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://cp01-idl-test-1002.epc.baidu.com:8383/"];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（POST）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *args = [NSString stringWithFormat:@"html=%@",string];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到html数据");
        /*
         对从服务器获取到的数据data进行相应的处理.
         */
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

@end
