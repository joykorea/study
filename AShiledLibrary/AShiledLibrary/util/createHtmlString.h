//
//  createHtmlString.h
//  SDKTestDemo
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface createHtmlString : NSObject

//@property(nonatomic,strong)NSMutableString *htmlString;

+ (NSString *)createHtmlWithTitles:(NSArray *)titles andHeadArray:(NSArray *)headArray andRowArray:(NSArray *)rowArray andStyle:(NSArray *)styleArray;

//0 开始创建html信息
- (void)createHtmlHead;
//1  表标题
- (void)createHtmlTableHeadWithTitle:(NSString *)title;
//2  表头信息
- (void)createHtmlHeadWithArray:(NSArray *)array;
//3 添加每一行的信息,可多次添加
- (void)createHtmlTableRowWithArray:(NSArray *)array withStyle:(NSArray *)styleArray;
//4 结束本表格的添加
- (void)endHtmlHead;
//5 结束本次html中表格的编写
- (NSString *)endEditHtml;


@end
