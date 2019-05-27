//
//  SSRequestLoadingStatus.h
//  htcm
//
//  Created by soldoros on 2018/7/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSRequestStatus.h"


/**
 网络请求加载状态视图的按钮点击回调的代码块

 @param statusCode 返回网络请求的状态值
 */
typedef void (^LoadingBlock)(SSRequestStatusCode statusCode);



@interface SSRequestLoadingStatus : UIView


/**
 网络请求加载状态视图的按钮点击回调的代码块
 */
@property(nonatomic,copy) LoadingBlock loadingBlock;



/**
 网络请求的状态值
 */
@property(nonatomic,assign) SSRequestStatusCode statusCode;



/**
 承载当前视图的父类视图对象
 */
@property(nonatomic,strong) UIView *superView;


/**
 进度指示器
 */
@property(nonatomic,strong)UIImageView *mActivityImg;
@property(nonatomic,strong)UILabel *mLoadingLab;


/**
 图片 设置图片的名称
 */
@property(nonatomic,strong)UIImageView  *mImgView;
@property(nonatomic,strong)NSString     *imgString;


/**
 提示信息  提示信息的文字
 */
@property(nonatomic,strong)UILabel     *mLabel;
@property(nonatomic,strong)NSString    *labString;


/**
 操作按钮  按钮的文字
 */
@property(nonatomic,strong)UIButton    *mButton;
@property(nonatomic,strong)NSString    *btnString;




/**
 初始化当前对象

 @param superView 承载当前视图的对象视图
 @param statusCode 网络加载的状态值xi
 @param loadingBlock 当前视图按钮点击回调代码块
 @return 返回当前对象
 */
-(instancetype)initWithView:(UIView *)superView statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock;



/**
 初始化当前对象

 @param frame 传入当前视图的frame
 @param superView 承载当前视图的对象视图
 @param statusCode 网络加载的状态值
 @param loadingBlock 当前视图按钮点击回调代码块
 @return 返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock;


/**
 初始化当前对象

 @param frame 传入当前视图的frame
 @param superView 承载当前视图的对象视图
 @param imgString 图片的名称
 @param btnString 按钮的名称
 @param labString 显示详情的文字
 @param statusCode 网络加载的状态值
 @param loadingBlock 当前视图按钮点击回调代码块
 @return 返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView imgString:(NSString *)imgString btnString:(NSString *)btnString labString:(NSString *)labString statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock;














@end
