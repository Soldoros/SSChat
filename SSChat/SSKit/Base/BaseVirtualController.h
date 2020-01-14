//
//  BaseVirtualController.h
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//  抽象基类


/*
 
 原框架采用的了大量的类别来处理相关方法，甚至利用runtime添加了不少属性，这是不太合理的方案。我不建议在类别中添加属性，即便是可用通过特殊途径实现。类别很好滴解决了面向对象的多态问题，但是使用继承来配合类别使用，会让代码的规范性更好。新的框架将视图控制器的大部分封装视图呈现在这里，包括自定义导航栏、导航栏标题、导航栏图片、导航栏返回键，导航栏其他的按钮展示，导航栏的部分操作，视图控制器部分特殊视图封装展示......
 
 我们在对代码解耦的处理过程中，以面向对象的思维去解决和重构，模块化是一种编码趋势。单独地提出一段代码容易让更多的地方、更多的技术人员来调用。尽量地针对接口编程，而不是针对项目编程。针对项目会使代码的耦合度十分紧密，不利于小功能代码块的复用。我们需要单独模块化这些代码，尽可能提供丰富的API。其次，文件IO的速度总是很慢的，因而读取头文件的速度要比在同一文件访问一个类的速度要慢。因此我并不反对在一个文件里面写上几千行甚至上万行代码，写多个类或者方法。只要各个类区分开来，各个方法区分开来，大家在调用的时候很方便，就足够了。
 
 */




#import <UIKit/UIKit.h>


//系统提示框点击按钮回调
typedef void (^ActionBtnClick)(NSInteger index);


@interface BaseVirtualController : UIViewController

@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;


/**
 导航栏背景视图 视图层采用图片视图，总共加了两层，是为了避免某些界面的导航栏有特效，两层处理起来更加方便
 */
@property(nonatomic,strong)UIImageView      *navtionBar;
@property(nonatomic,strong)UIImageView      *navtionImgView;


/**
 导航栏底部的一根很细的线条，因为系统导航栏有这玩意儿，UI在设计的时候不免会参考到，线条高度为0.5个像素
 */
@property(nonatomic,strong)UIView *navLine;

//导航栏标题
@property(nonatomic,strong)UILabel *titleLab;


/**
 针对项目设置的一个属性，htcm系统首页的导航栏有一张logo图，如果设置可点击的话 建议用按钮
 */
@property(nonatomic,strong)UIImageView *titleImgView;


/**
 导航栏有筛选功能 在体检报告对比的界面
 */
@property(nonatomic,strong)UIButton *titleButton;

//左侧按钮
@property(nonatomic,strong)UIButton *leftBtn1,*leftBtn2;
//右侧按钮
@property(nonatomic,strong)UIButton *rightBtn1,*rightBtn2;





/**
 根据图片设置导航栏，记着，最里面那一层的图片视图永远设置透明背景的图，避免某些页面出现特效难以调整。

 @param str 传入图片名称
 */
-(void)setNavgationBarImg:(NSString *)str;


/**
 根据颜色设置导航栏

 @param color 传入颜色值
 */
-(void)setNavgationBarColor:(UIColor *)color;



/**
 根据颜色设置导航栏的图片 这个时候导航栏的颜色一定是纯色的

 @param color 传入颜色值
 */
-(void)setNavgationBarColorImg:(UIColor *)color;



/**
 设置导航栏最底部的线条 并给出颜色

 @param color 传入颜色值
 */
-(void)setNavgationBarLine:(UIColor *)color;


/**
 删除导航栏 部分页面是不需要导航栏的

 */
-(void)setNavgationNil;



/**
 设置导航栏标题属性

 @param font 标题的字体大小
 @param color 标题的颜色
 */
-(void)setNavgationTitleFont:(UIFont *)font color:(UIColor *)color;


/**
 设置导航栏标题文字

 @param str 传入字符串
 */
-(void)setNavgaionTitle:(NSString *)str;


/**
 设置导航栏正中间的图片 比如首页的logo

 @param str 传入图片名称
 */
-(void)setNavgaionTitleImg:(NSString *)str;



/**
 设置导航栏中间的筛选按钮 比如报告对比界面的筛选

 @param str 传入按钮图片的名称
 */
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



//打电话
-(void)callPhone:(NSString *)phone;



//给右侧的按钮加个红点 删除红点
@property(nonatomic, strong)UIView     *redView;
-(void)setRedViewOnRightButton;
-(void)deleteRedView;




//自定义提示弹窗
-(void)showTime:(NSString *)message;
-(void)showTimeMsg:(NSString *)msg;
-(void)showTimeBlack:(NSString *)string;



/**
 系统提示框按钮点击回调代码块

 @param action 点击的action
 */
typedef void (^AlertBlock)(UIAlertAction * action);

/**
 系统自带提示框
 
 @param title 提示框标题
 @param msg 详细信息
 @param ok 确认按钮
 @param cancel 返回按钮
 */
-(void)systemAlert:(NSString *)title msg:(NSString *)msg okButton:(NSString *)ok cancelButton:(NSString *)cancel  alertBlock:(AlertBlock)alertBlock;







@end



