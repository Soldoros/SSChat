//
//  BaseVirtualController.h
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//  抽象基类



#import <UIKit/UIKit.h>
#import "SSRequestLoadingStatus.h"

//系统提示框点击按钮回调
typedef void (^ActionBtnClick)(NSInteger index);


@interface BaseVirtualController : UIViewController


//添加加载指示器
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;

-(void)addSysIndicatorView;
-(void)deleteSysIndicatorView;



//视图frame
@property(nonatomic,assign)CGRect viewFrame;

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


//左侧头像
-(void)setLeftImgButton;



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


//导航栏按钮点击
-(void)navgationButtonPressed:(UIButton *)sender;


//左侧图片按钮 控制颜色的图片按钮 左侧文字按钮
-(void)setLeftOneBtnImg :(NSString *)str;
-(void)setLeftOneBtnImg:(NSString *)str color:(UIColor *)color;
-(void)setLeftOneBtnTitle :(NSString *)str;

//右侧图片按钮 图片按钮控制颜色  文字按钮
-(void)setRightOneBtnImg:(NSString *)str;
-(void)setRightOneBtnImg:(NSString *)str color:(UIColor *)color;
-(void)setRightOneBtnTitle:(NSString *)str;


//左侧两个图片按钮
-(void)setLeftBtnImg:(NSString *)str1 str2:(NSString *)str2;
//右侧两个图片按钮
-(void)setRightBtnImg:(NSString *)str1 str2:(NSString *)str2;


//左侧图片按钮组 文字按钮组
-(void)setLeftBtnImgArr :(NSArray *)arr;
-(void)setLeftBtnTitleArr :(NSArray *)arr;


//右侧图片按钮组 文字按钮组
-(void)setRightBtnImgArr:(NSArray *)arr;
-(void)setRightBtnTitleArr:(NSArray *)arr;

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


//红色数字
@property(nonatomic, strong)UILabel     *redLabel;
-(void)setRedLab:(NSInteger)index;
-(void)deleteRedLabel;


//自定义提示弹窗
-(void)showTime:(NSString *)message;
-(void)showTimeMsg:(NSString *)msg;
-(void)showTimeBlack:(NSString *)string;


/**
 加载数据的状态显示视图
 */
@property(nonatomic,strong)SSRequestLoadingStatus *loadingStatus;
-(void)initRequestLoadingStatus:(CGRect)frame superView:(UIView *)superView;
-(void)deleteLoadingStatus;



@end



