//
//  UIDevice+SSAdd.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "UIDevice+SSAdd.h"


@implementation UIDevice (SSAdd)

//获取设备id
+(NSString *)getDeviceId{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
} 

//获取app名称
+(NSString *)getAppName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

//获取app版本
+(NSString *)getAppVersion{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获取app bulid版本号
+(NSString *)getAppBuildCode{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

//获取屏幕高度
+(CGFloat)getSCREEN_Height{
    return [[UIScreen mainScreen] bounds].size.height;
}

//获取屏幕宽度
+(CGFloat)getSCREEN_Width{
    return [[UIScreen mainScreen] bounds].size.width;
}

  
//获取状态栏高度
+(CGFloat)getStatuBarHeight{
    return CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}

//获取导航栏高度（不包括状态栏）
+(CGFloat)getNavGationBarHeight{
    return 44;
}

//获取标签栏高度
+(CGFloat)getTabBarHeight{
    return 49;
}

//获取顶部安全区域
+(CGFloat)getSafeAreaTopHeight{
    return [self getStatuBarHeight] + 44;
}

//获取底部安全区域(iPhone X有）
+(CGFloat)getSafeAreaBottomHeight{
    return [self getStatuBarHeight] == 20 ? 0 : 34;
}


//获取根页面主视图区域的高度
+(CGFloat)getMainViewSub_Height{
    
    return [self getSCREEN_Height] - [self getSafeAreaTopHeight] - [self getSafeAreaBottomHeight];
    
}


//获取根页面主视图区域的高度
+(CGFloat)getMainViewRoot_Height{
    return [self getMainViewSub_Height] - [self getTabBarHeight];
}




@end
