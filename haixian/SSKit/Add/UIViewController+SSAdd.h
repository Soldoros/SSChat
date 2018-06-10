//
//  UIViewController+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>



//系统提示框点击按钮回调
typedef void (^ActionBtnClick)(NSInteger index);



@interface UIViewController (SSAdd)

//导航栏
@property(nonatomic,strong)UIImageView      *navtionBar;
@property(nonatomic,strong)UIImageView *navtionImgView;

//导航栏线条
@property(nonatomic,strong)UIView *navLine;

//导航栏标题
@property(nonatomic,strong)UILabel *titleLab;
//导航栏标题图片
@property(nonatomic,strong)UIImageView *titleImgView;

//导航栏标题图片
@property(nonatomic,strong)UIButton *titleButton;

//左侧按钮
@property(nonatomic,strong)UIButton *leftBtn1,*leftBtn2;
//右侧按钮
@property(nonatomic,strong)UIButton *rightBtn1,*rightBtn2;


@property(nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;



//=========================================
//导航栏部分
//=========================================

//根据切图图片设置导航栏
-(void)setNavgationBarImg:(NSString *)str;
//根据颜色设置导航栏
-(void)setNavgationBarColor:(UIColor *)color;
//根据颜色图片设置导航栏
-(void)setNavgationBarColorImg:(UIColor *)color;
//给导航栏添加一条线
-(void)setNavgationBarLine:(UIColor *)color;

//删除导航栏
-(void)setNavgationNil;

//设置导航栏标题属性
-(void)setNavgationTitleFont:(UIFont *)font color:(UIColor *)color;

//设置导航栏标题
-(void)setNavgaionTitle:(NSString *)str;
//设置导航栏图片
-(void)setNavgaionTitleImg:(NSString *)str;
//设置导航栏主题按钮
-(void)setNavgaionTitleButton:(NSString *)str;
-(void)titleButtonClick;


//左侧图片按钮 控制颜色的图片按钮 左侧文字按钮
-(void)setLeftOneBtnImg :(NSString *)str;
-(void)setLeftOneBtnImg:(NSString *)str color:(UIColor *)color;
-(void)setLeftOneBtnTitle :(NSString *)str;
-(void)leftBtnCLick;
//右侧图片按钮 图片按钮控制颜色  文字按钮
-(void)setRightOneBtnImg:(NSString *)str;
-(void)setRightOneBtnImg:(NSString *)str color:(UIColor *)color;
-(void)setRightOneBtnTitle:(NSString *)str;
-(void)rightBtnClick;


//左侧两个图片按钮
-(void)setLeftBtnImg:(NSString *)str1 str2:(NSString *)str2;
//右侧两个图片按钮
-(void)setRightBtnImg:(NSString *)str1 str2:(NSString *)str2;


//左侧图片按钮组 文字按钮组
-(void)setLeftBtnImgArr :(NSArray *)arr;
-(void)setLeftBtnTitleArr :(NSArray *)arr;
-(void)leftBtnCLick:(UIButton *)sender;

//右侧图片按钮组 文字按钮组
-(void)setRightBtnImgArr:(NSArray *)arr;
-(void)setRightBtnTitleArr:(NSArray *)arr;
-(void)rightBtnClick:(UIButton *)sender;

//设置导航栏背景色 控件颜色
-(void)setNavgationBarBackcolor:(UIColor *)color;
-(void)setNavgationBarTintcolor:(UIColor *)color;

//设置导航栏标题颜色 字体大小
-(void)setNavgationBarTitlecolor:(UIColor *)color size:(double)size;

//设置导航栏的图片
-(void)setNavgationBarImgAtColor:(UIColor *)color;
-(void)setNavgationBarImgAtString:(NSString *)string;

//设置工具栏的图片
-(void)setToorBarImgAtString:(NSString *)string;
-(void)setToorBarImgAtColor:(UIColor *)color;

//=========================================
//标签栏部分
//=========================================

//设置当前标签栏按钮的图片和文字 以及颜色
-(void)setItemImg1:(NSString *)imgStr1 img2:(NSString *)imgStr2 title:(NSString *)titleStr color1:(UIColor *)color1 color2:(UIColor *)color2;

//设置一个特殊的tabbarItem
-(void)setSpecialTabBarItem:(NSString *)img1 img2:(NSString *)img2 title:(NSString *)title color1:(UIColor *)color1 color2:(UIColor *)color2;

//设置底部一个大按钮
-(void)setToolBtnTitle:(NSString *)title;
//底部两个按钮
-(void)setBottomBtnTwo:(NSArray *)array;
-(void)toolBarBtnClick;
-(void)bottomBtnClick:(UIButton *)sender;
-(void)leftToolBarBtnClick;
-(void)rightToolBarBtnClick;

//=========================================
//其他 提示框
//=========================================
-(void)showTimeMsg:(NSString *)msg;
-(void)showAlert:(NSString *)msg;
-(void)closeAlert;
-(void)showTimeAlert:(NSString *)msg;
-(void)showTime:(NSString *)message;
-(void)showTimeAlert:(NSString *)title message:(NSString *)msg;

//系统的提示框
-(void)showAction:(NSString *)title
           cancel:(NSString *)cancel
         destruct:(NSString *)btn
         otherBtn:(NSString *)otherBtn
         btnClick:(ActionBtnClick)actionBtnClick;


//打电话
-(void)callPhone:(NSString *)phone;








@end
