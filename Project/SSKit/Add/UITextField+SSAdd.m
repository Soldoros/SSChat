//
//  UITextField+SSAdd.m
//  caigou
//
//  Created by soldoros on 2018/1/31.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "UITextField+SSAdd.h"

@implementation UITextField (SSAdd)

+(BOOL)textF:(UITextField *)textField shouldChangeRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL isHaveDian = YES;
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    
    if ([string length]>0){
        //当前输入的字符
        unichar single=[string characterAtIndex:0];
        //数据格式正确
        if ((single >='0' && single<='9') || single=='.'){
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                if (single == '0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //判断是否已有小数点
            if (single=='.'){
                if(!isHaveDian){
                    isHaveDian=YES;
                    return YES;
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else{
                //判断小数点后面只能有两位
                if (isHaveDian){
                    NSArray *arr = [textField.text componentsSeparatedByString:@"."];
                    
                    if ([arr[1] length] < 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                //判断整数部分只能是三位
                else{
                    NSArray *arr = [textField.text componentsSeparatedByString:@"."];
                    if ([arr[0] length] < 3){
                        return YES;
                    }else{
                        return NO;
                    }
                }
            }
        }
        //数据格式不正确
        else{
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    return YES;
}

@end
