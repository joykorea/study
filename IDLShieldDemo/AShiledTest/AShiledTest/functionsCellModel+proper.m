//
//  functionsCellModel+proper.m
//  AShiledTest
//
//  Created by baidu on 2017/11/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "functionsCellModel+proper.h"
#import <objc/runtime.h>

@implementation functionsCellModel (proper)

@dynamic nl_asdasd;

- (id)copyWithZone:(NSZone *)zone
{
    functionsCellModel * cellModel = [[self class] allocWithZone:zone];
    
    
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *namePro = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        if ([namePro isEqualToString:@"nl_asdasd"]) {
            cellModel.nl_asdasd = self.nl_asdasd;
        }else{
            id value = [self valueForKey:namePro];
            //赋值
            [cellModel setValue:value forKey:namePro];
        }
        
        
    }
    
    return cellModel;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    
    functionsCellModel * cellModel = [[[self class] allocWithZone:zone]init];
    
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *namePro = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        if ([namePro isEqualToString:@"nl_asdasd"]) {
            cellModel.nl_asdasd = self.nl_asdasd;
        }else{
            id value = [self valueForKey:namePro];
            //赋值
            [cellModel setValue:value forKey:namePro];
        }
        
    }
    
    return cellModel;
}

@end
