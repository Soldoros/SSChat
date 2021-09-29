//
//  UIDevice+SSAdd.h
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIDevice (SSAdd)

//获取设备id
+(NSString *)getDeviceId;

//获取app名称
+(NSString *)getAppName;
//获取app版本
+(NSString *)getAppVersion;
//获取app bulid版本
+(NSString *)getAppBuildCode;



//获取屏幕高度
+(CGFloat)getSCREEN_Height;
//获取屏幕宽度
+(CGFloat)getSCREEN_Width;


//获取状态栏高度
+(CGFloat)getStatuBarHeight;
//获取导航栏高度（不包括状态栏）
+(CGFloat)getNavGationBarHeight;
//获取标签栏高度
+(CGFloat)getTabBarHeight;

//获取顶部安全区域
+(CGFloat)getSafeAreaTopHeight;
//获取底部安全区域(iPhone X有）
+(CGFloat)getSafeAreaBottomHeight;


//获取根页面主视图区域的高度
+(CGFloat)getMainViewRoot_Height;
//获取根页面主视图区域的高度
+(CGFloat)getMainViewSub_Height;



@end


