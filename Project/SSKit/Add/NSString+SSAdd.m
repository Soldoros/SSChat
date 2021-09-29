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


//返回颜色处理过后的属性文字
+(NSMutableAttributedString *)placehodString:(NSString *)string color:(UIColor *)color{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : color}];
    return placeholderString;
}

//在一段文字前面加个小图标 并返回可变字符串
//图标 图标bouns 字符串  行间距3  字体大小16
+(NSMutableAttributedString *)attStringWithLeftIcon:(NSString *)imgStr imgBouds:(CGRect)imgBounds string:(NSString *)string lineSpacing:(CGFloat)lineSpacing  size:(CGFloat)size{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:imgStr];
    attach.bounds = imgBounds;
    
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithAttributedString:attachString];
    
    [mstr addAttribute:NSBaselineOffsetAttributeName value:@(-3) range:NSMakeRange(0, mstr.length)];
    
    NSMutableParagraphStyle *paragraphString = [[NSMutableParagraphStyle alloc]init];
    paragraphString.lineSpacing = lineSpacing;
    paragraphString.lineBreakMode = NSLineBreakByCharWrapping;
    
    [mstr addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, mstr.length)];
    
    [str insertAttributedString:mstr atIndex:0];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, str.length)];
    return str;
    
}


//将图片地址的正斜杠换成反斜杠
-(NSString *)imageString{
    if([self hasPrefix:@"http"]){
        return  [self stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    }else{
        return [makeString(@"http://", self) stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    }
}



//字符串转浮点计算容易出现精度问题 直接用NSDecimalNumber
+(NSString *)jiafa:(NSString *)a b:(NSString *)b{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberByAdding:num2];
    return [resultNum stringValue];
}

+(NSString *)jianfa:(NSString *)a b:(NSString *)b{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberBySubtracting:num2];
    return [resultNum stringValue];
}

+(NSString *)chengfa:(NSString *)a b:(NSString *)b{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberByMultiplyingBy:num2];
    return [resultNum stringValue];
}

+(NSString *)chufa:(NSString *)a b:(NSString *)b{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberByDividingBy:num2];
    return [resultNum stringValue];
}

+(BOOL)dayu:(NSString *)a b:(NSString *)b{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:b];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return NO;
    } else if (result == NSOrderedSame) {
        return NO;
    } else if (result == NSOrderedDescending) {
        return YES;
    }
    return NO;
 
}

+(BOOL)dengyu:(NSString *)a b:(NSString *)b{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:b];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return NO;
    } else if (result == NSOrderedSame) {
        return YES;
    } else if (result == NSOrderedDescending) {
        return NO;
    }
    return NO;
    
}

+(BOOL)A:(NSString *)a xiaoyuB:(NSString *)b{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:b];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return YES;
    } else if (result == NSOrderedSame) {
        return NO;
    } else if (result == NSOrderedDescending) {
        return NO;
    }
    return NO;
    
}

- (NSString *)URLEncodedString
{
    
    NSString* encodedValue = self;
    if (self.length > 0) {
        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]invertedSet];
        encodedValue = [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
    }
    return encodedValue;
}

@end
