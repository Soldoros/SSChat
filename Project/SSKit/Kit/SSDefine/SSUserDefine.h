//
//  SSUserDefine.h
//  htcm
//
//  Created by soldoros on 2018/7/3.
//  Copyright © 2018年 soldoros. All rights reserved.
//





#ifndef SSUserDefine_h
#define SSUserDefine_h
 


//app名称 app版本 bulid版本
#define app_Name         [UIDevice getAppName]
#define app_Version      [UIDevice getAppVersion]
#define app_build        [UIDevice getAppBuild]

//当前屏幕的尺寸 高度 宽度
#define SCREENBounds     [[UIScreen mainScreen ] bounds];
#define SCREEN_Height    [[UIScreen mainScreen] bounds].size.height
#define SCREEN_Width     [[UIScreen mainScreen] bounds].size.width

//状态栏  导航栏 标签栏
#define StatuBar_Height  [UIDevice getStatuBarHeight]
#define NavBar_Height    [UIDevice getNavGationBarHeight]
#define TabBar_Height    [UIDevice getTabBarHeight]

//安全区域顶部 安全区域底部（iPhone X有）
#define SafeAreaTop_Height     [UIDevice getSafeAreaTopHeight]
#define SafeAreaBottom_Height  [UIDevice getSafeAreaBottomHeight]


//根页面主视图部分的高度 子页面主视图部分的高度
#define MainViewRoot_Height    [UIDevice getMainViewRoot_Height]
#define MainViewSub_Height     [UIDevice getMainViewSub_Height]


//输入框的限制输入
#define SHURUMIMA @"1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
#define SHURUSHOUJIHAO @"1234567890"


//打印
#define MESSAGE     NSLog(@"响应了")
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)


//主题色
#define TitleColor    [SSConfigManager shareManager].titleColor
//普通背景色
#define BackGroundColor  [SSConfigManager shareManager].backGroundColor

//cell线条颜色
#define CellLineColor  makeColorRgb(200, 200, 200)
//按钮颜色
#define ButtonColor  [SSConfigManager shareManager].titleColor

//线条颜色
#define LineColor  [SSConfigManager shareManager].navLineColor
//导航栏颜色
#define NavBarColor  [SSConfigManager shareManager].navBarColor
//导航栏颜色
#define NavBarTitColor  [SSConfigManager shareManager].navTintColor
//标签栏颜色
#define TabbarColor  [SSConfigManager shareManager].tabBarColor
//标签栏字体未选中的颜色
#define TabBarTintDefaultColor  [SSConfigManager shareManager].tabBarTintDefaultColor
//标签栏字体选中的颜色
#define TabBarTintSelectColor   [SSConfigManager shareManager].tabBarTintSelectColor


//判断版本
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

//根视图
#define NAVIGATION (UINavigationController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController]



#endif

