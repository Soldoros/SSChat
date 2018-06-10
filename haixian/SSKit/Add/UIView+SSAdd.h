//
//  UIView+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DEAdd)

@property(nonatomic,strong) UIView *indicatorView;
@property(nonatomic,strong) UIActivityIndicatorView *indicator;


-(UIViewController *)getViewController;


@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.


/**
 视图弹出和回收的动画

 @param animateView 视图对象
 */
+(void)animateIn:(UIView *)animateView;
+(void)animateOut:(UIView *)animateView;


/**
 显示和关闭进度指示器
 */
-(void)showActivity;
-(void)closeActivity;



/**
 给按钮提供菊花展示

 @param color 菊花颜色
 @param scale 菊花大小
 */
-(void)addActivityOnBtn;
-(void)addActivityOnBtn:(UIColor *)color scale:(CGFloat)scale;


/**
 按钮菊花停止展示 并显示文字
 
 @param title 传入按钮的文字
 */
-(void)closeActivityByBtn:(NSString *)title;







@end
