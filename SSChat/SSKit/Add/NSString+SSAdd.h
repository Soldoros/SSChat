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

@end
