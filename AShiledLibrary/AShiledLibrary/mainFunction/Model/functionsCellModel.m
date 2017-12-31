//
//  functionCellModel.m
//  SDKTestDemo
//
//  Created by LDS on 2017/8/31.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "functionsCellModel.h"
#import <objc/runtime.h>

@implementation functionsCellModel

- (BOOL)modelIsHasChild {
    
    return self.childModel != nil && self.childModel.count >0 ? YES:NO;
}

- (id)copyWithZone:(NSZone *)zone
{
    functionsCellModel * cellModel = [[self class] allocWithZone:zone];
    
//    cellModel.fatherName = self.fatherName;
    
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *namePro = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:namePro];
        //赋值
        [cellModel setValue:value forKey:namePro];
        
    }
    
    return cellModel;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    
    functionsCellModel * cellModel = [[[self class] allocWithZone:zone]init];
    
//    cellModel.fatherName = self.fatherName;
    
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i=0; i<count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *namePro = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:namePro];
        //赋值
        [cellModel setValue:value forKey:namePro];
        
    }
    
    return cellModel;
}


@end
