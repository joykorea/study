//
//  createHtmlString.m
//  SDKTestDemo
//
//  Created by baidu on 2017/9/11.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "createHtmlString.h"

@implementation createHtmlString{
    NSMutableString *htmlString;
}

+ (NSString *)createHtmlWithTitles:(NSArray *)titles andHeadArray:(NSArray *)headArray andRowArray:(NSArray *)rowArray andStyle:(NSArray *)styleArray{
    
    createHtmlString *html = [[createHtmlString alloc]init];
    //0 开始创建html信息
    [html createHtmlHead];
    for (int i = 0; i < titles.count; i++) {
        //1  表标题
        [html createHtmlTableHeadWithTitle:titles[i]];
        //2  表头信息
        [html createHtmlHeadWithArray:headArray[i]];
        for (int k = 0; k < ((NSArray *)rowArray[i]).count; k++) {
            if (((NSArray *)styleArray[i][k]).count) {
                [html createHtmlTableRowWithArray:rowArray[i][k] withStyle:styleArray[i][k]];
            }else{
                //3 添加每一行的信息,可多次添加
                [html createHtmlTableRowWithArray:rowArray[i][k] withStyle:nil];
            }
            
            
        }
        //4 结束本表格的添加
        [html endHtmlHead];
    }
    //5 结束本次html中表格的编写
    NSString *str= [html endEditHtml];
    
    return str;
}

- (void)createHtmlHead{
    htmlString=[[NSMutableString alloc]init];
    [htmlString appendString:@"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><title>人脸SDK测试工具测试结果</title><style>body{width:80%;margin: 40px auto;font-family: 'trebuchet MS', 'Lucida sans', Arial;font-size: 14px;color: #444;}table{ *border-collapse: collapse;border-spacing: 0;width: 100%;}.bordered {border: solid #ccc 1px;-moz-border-radius: 0px;-webkit-border-radius: 0px;border-radius: 0px;-webkit-box-shadow: 0 1px 1px #ccc; -moz-box-shadow: 0 1px 1px #ccc;box-shadow: 0 1px 1px #ccc;}.project {border: none;able-layout:fixed;word-break:break-all;}.project td, .project th {text-align: left;}.bordered tr:hover {background: #fbf8e9;-o-transition: all 0.1s ease-in-out;-webkit-transition: all 0.1s ease-in-out;-moz-transition: all 0.1s ease-in-out;-ms-transition: all 0.1s ease-in-out;transition: all 0.1s ease-in-out;}.bordered td, .bordered th {border-left: 1px solid #ccc;border-top: 1px solid #ccc;padding: 10px;text-align: left;}.bordered th {background-color: #dce9f9;background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);background-image:         linear-gradient(top, #ebf3fc, #dce9f9);-webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;-moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;border-top: none;text-shadow: 0 1px 0 rgba(255,255,255,.5);}.bordered td:first-child, .bordered th:first-child {border-left: none;}</style></head><body>"];
    
}
//1  表标题
- (void)createHtmlTableHeadWithTitle:(NSString *)title{
    [htmlString appendFormat:@"<h3>%@</h3><table class=\"bordered\">",title];
}
//2  表头信息
- (void)createHtmlHeadWithArray:(NSArray *)array{
    NSMutableString *mstr = [[NSMutableString alloc]initWithString:@"<thead><tr>"];
    for (int i = 0; i < array.count; i++) {
        NSString *string = [NSString stringWithFormat:@"<th style=\"text-align:center\">%@</th>",array[i]];
        [mstr appendString:string];
    }
    [mstr appendString:@"</tr></thead>"];
    [htmlString appendString:mstr];
}
//3 添加每一行的信息,可多次添加
- (void)createHtmlTableRowWithArray:(NSArray *)array withStyle:(NSArray *)styleArray{
    NSMutableString *mstr = [[NSMutableString alloc]initWithString:@"<tr>"];
    for (int i = 0; i < array.count; i++) {
        if (styleArray[i]) {
            [mstr appendFormat:@"<td style=\"text-align:center\" %@>%@</td>",styleArray[i],array[i]];
            
        }else{
           [mstr appendFormat:@"<td style=\"text-align:center\">%@</td>",array[i]];
        }
    }
    [mstr appendString:@"<tr>"];
    [htmlString appendString:mstr];
}
//4 结束本表格的添加
- (void)endHtmlHead{
    [htmlString appendString:@"</table><br></br>"];
}
//结束本次html中表格的编写
- (NSString *)endEditHtml{
    [htmlString appendFormat:@"</body></html>"];
    return htmlString;
}
    


@end
