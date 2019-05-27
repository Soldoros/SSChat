//
//  NSString+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "NSString+SSAdd.h"

@implementation NSString (SSAdd)





//pragma mark-- 英文字母
+(BOOL)yingwenzimu:(NSString *)str{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

//pragma mark-- 用户名
+(BOOL)yonghuming:(NSString *)str{
    
    NSString *regex = @"^[a-zA-Z]\\w{5,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

//pragma mark-- 手机号
+(BOOL)shoujihao:(NSString *)str{
    
    NSString *pattern = @"^1+[345789]+\\d{9}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:str];
}

//pragma mark-- 验证码
+(BOOL)yanzhengma:(NSString *)str{
    
    NSString *regex =@"\\d{6}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:str];
}

//pragma mark-- 密码
+(BOOL)mima:(NSString *)str{
    
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

//pragma mark-- 身份证号
+(BOOL)shenfenzheng:(NSString *)str{
    
    NSString *regex = @"\\d{14}[[0-9],0-9xX]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

//pragma mark-- 邮箱
+(BOOL)youxiang:(NSString *)str{
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}





@end
