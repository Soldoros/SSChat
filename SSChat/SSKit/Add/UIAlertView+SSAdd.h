//
//  UIAlertView+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.



#import <UIKit/UIKit.h>

@interface UIAlertView (DEAdd)

typedef void(^alertBlock)(UIAlertView *alertView,NSInteger index);


//带有点击事件的block回调方法
+ (void)showMsg:(NSString *)msg btnClicAction:(alertBlock)block;
+ (void)showMsg:(NSString *)msg btn1:(NSString *)btn1 btn2:(NSString *)btn2 btnClicAction:(alertBlock)block;


//不带点击事件的单纯提示框
+(void)showAlertMsg:(NSString*)msg;
//不带点击事件的单纯提示框
+(void)showAlertTitle:(NSString *)title andMsg:(NSString *)message;



@end
