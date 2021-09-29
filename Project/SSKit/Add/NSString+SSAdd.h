//
//  NSString+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SSAdd)


//英文字母
+(BOOL)yingwenzimu:(NSString *)str;
//用户名  手机号
+(BOOL)yonghuming:(NSString *)str;
+(BOOL)shoujihao:(NSString *)str;
//验证码 密码
+(BOOL)yanzhengma:(NSString *)str;
+(BOOL)mima:(NSString *)str;
//身份证号 邮箱
+(BOOL)shenfenzheng:(NSString *)str;
+(BOOL)youxiang:(NSString *)str;

//返回属性文字 主要是针对UITextField的默认文字颜色处理
+(NSMutableAttributedString *)placehodString:(NSString *)string color:(UIColor *)color;

//在一段文字前面加个小图标 并返回可变字符串
//图标 图标bouns 字符串  行间距3  字体大小16
+(NSMutableAttributedString *)attStringWithLeftIcon:(NSString *)imgStr imgBouds:(CGRect)imgBounds string:(NSString *)string lineSpacing:(CGFloat)lineSpacing  size:(CGFloat)size;


//将图片地址的正斜杠换成反斜杠
-(NSString *)imageString;

//字符串转浮点计算容易出现精度问题 直接用NSDecimalNumber
+(NSString *)jiafa:(NSString *)a b:(NSString *)b;
+(NSString *)jianfa:(NSString *)a b:(NSString *)b;
+(NSString *)chengfa:(NSString *)a b:(NSString *)b;
+(NSString *)chufa:(NSString *)a b:(NSString *)b;
+(BOOL)dayu:(NSString *)a b:(NSString *)b;
+(BOOL)dengyu:(NSString *)a b:(NSString *)b;


- (NSString *)URLEncodedString;

@end
