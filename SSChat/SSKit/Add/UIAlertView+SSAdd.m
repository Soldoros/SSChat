//
//  UIAlertView+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "UIAlertView+SSAdd.h"

#import <objc/runtime.h>

static alertBlock _alertBlock;

@implementation UIAlertView (DEAdd)



//带有点击事件的block回调方法
+ (void)showMsg:(NSString *)msg btnClicAction:(alertBlock)block{
    _alertBlock = block;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:[self self] cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}


+ (void)showMsg:(NSString *)msg btn1:(NSString *)btn1 btn2:(NSString *)btn2 btnClicAction:(alertBlock)block{
    _alertBlock = block;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:[self self] cancelButtonTitle:btn1 otherButtonTitles:btn2, nil];
    [alert show];
}



//警告框的代理回调
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _alertBlock(alertView,buttonIndex);
}





//不带点击事件的单纯提示框
+(void)showAlertMsg:(NSString*)msg
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}

//不带点击事件的单纯提示框
+(void)showAlertTitle:(NSString *)title andMsg:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


@end
