//
//  UIView+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DEAdd)


-(BaseVirtualController *)getViewController;


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











@end
