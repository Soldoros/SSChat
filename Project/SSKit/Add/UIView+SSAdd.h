//
//  UIView+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DEAdd)


-(UIViewController *)getViewController;


/**
 视图弹出和回收的动画

 @param animateView 视图对象
 */
+(void)animateIn:(UIView *)animateView;
+(void)animateOut:(UIView *)animateView;



//给按钮提供菊花展示
-(void)addActivityOnBtn;
-(void)addActivityOnBtn:(UIColor *)color scale:(CGFloat)scale;
-(void)closeActivityByBtn:(NSString *)title;
-(void)closeActivityByBtnImg:(NSString *)img;

//自定义提示弹窗
-(void)showTime:(NSString *)message;
-(void)showTimeBlack:(NSString *)string;



//全部阴影0  上1  下2  左3  右4
-(void)setShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius  option:(NSInteger)option;


-(void)layerWith:(CGRect)frame color :(UIColor *)color1 color2:(UIColor *)color2 point1:(CGPoint)point1 point2:(CGPoint)point2;


@end
