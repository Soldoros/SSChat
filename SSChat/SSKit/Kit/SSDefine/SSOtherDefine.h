//
//  SSAllDefine.h
//  htcm
//
//  Created by soldoros on 2018/7/3.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#ifndef SSAllDefine_h
#define SSAllDefine_h



//输入框的限制输入
#define SHURUMIMA @"1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
#define SHURUSHOUJIHAO @"1234567890"


//打印
#define MESSAGE     NSLog(@"响应了")
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)


//主题色
#define TitleColor  [SSAttributeDefault shareCKAttributeDefault].titleColor

//第二主题色
#define TitleColor2  [SSUserDefault shareCKUserDefault].tabBarColor

//导航栏背景色
#define NavBarColor  [SSAttributeDefault shareCKAttributeDefault].navBarColor

//标签栏颜色
#define TabbarColor  [SSAttributeDefault shareCKAttributeDefault].tabBarColor
//标签栏字体未选中的颜色
#define TabBarTintDefaultColor  [SSAttributeDefault shareCKAttributeDefault].tabBarTintDefaultColor
//标签栏字体选中的颜色
#define TabBarTintSelectColor  [SSAttributeDefault shareCKAttributeDefault].tabBarTintSelectColor


//聊天界面的颜色
#define SSChatCellColor  makeColorRgb(245, 245, 245)


#define RoundViewColor  makeColorHex(@"FF6262")

//文字颜色
#define TextColor  makeColorHex(@"333333")



//图片占位颜色
#define ImagePlaceColor  makeColorRgb(200, 200, 200)

//占位图
#define ImagePlace1        @"faxian_banner_big"
#define ImagePlace2        @"faxian_banner_small"
#define ImagePlace3        @"faxian_yiliaomeirong_banner"
#define ImagePlace4        @"faxianzhanwei"
#define ImagePlace5        @"shouye_banner"
#define ImagePlace6        @"taocanxiangqing_banner"
#define ImagePlace7        @"tuijianzixun"
#define ImagePlace8        @"touxiang_weidenglu"



//cell线条颜色
#define CellLineColor  makeColorRgb(220, 220, 220)
//按钮颜色
#define ButtonColor  makeColorRgb(251, 188, 54)

//普通的灰色背景
#define BackGroundColor  makeColorRgb(246, 247, 248)
//浅蓝色
#define LightBlueColor  makeColorRgb(146, 216, 253)
//加深的灰色
#define GrayColor makeColorRgb(137, 148, 160)
//主题玫红色
#define RedTitleColor makeColorRgb(245, 75, 130)
//主题蓝
#define BlueTitleColor makeColorRgb(35, 69, 96)
//主题橙色
#define OrangeTitleColor makeColorRgb(252, 154, 40)
//线条颜色
#define LineColor  makeColorHex(@"E6E6E6")


//app名称
#define app_Name  [[[NSBundle mainBundle] [[NSBundle mainBundle] infoDictionary]] \
objectForKey:@"CFBundleDisplayName"];

//app版本
#define app_Version  [[[NSBundle mainBundle] [[NSBundle mainBundle] infoDictionary]] \
objectForKey:@"CFBundleShortVersionString"];

//app bulid版本
#define app_build  [[[NSBundle mainBundle] [[NSBundle mainBundle] infoDictionary]] \
objectForKey:@"CFBundleVersion"];


//当前屏幕的尺寸
#define SCREENBounds [[UIScreen mainScreen ] bounds];
//当前窗口的高度 宽度
#define SCREEN_Height [[UIScreen mainScreen] bounds].size.height
#define SCREEN_Width  [[UIScreen mainScreen] bounds].size.width
//状态栏
#define StatuBar_Height  [SSDeviceDefault shareCKDeviceDefault].statuBarHeight
//导航栏
#define NavBar_Height  [SSDeviceDefault shareCKDeviceDefault].navBarHeight
//安全区域顶部
#define SafeAreaTop_Height  [SSDeviceDefault shareCKDeviceDefault].safeAreaTopHeight
//安全区域底部（iPhone X有）
#define SafeAreaBottom_Height  [SSDeviceDefault shareCKDeviceDefault].safeAreaBottomHeight
//标签栏
#define TabBar_Height  [SSDeviceDefault shareCKDeviceDefault].tabBarHeight
//根页面主视图部分的高度
#define MainViewRoot_Height (SCREEN_Height - SafeAreaTop_Height - TabBar_Height - SafeAreaBottom_Height)
//子页面主视图部分的高度
#define MainViewSub_Height (SCREEN_Height - SafeAreaTop_Height -  SafeAreaBottom_Height)



//判断版本
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

//根视图
#define NAVIGATION (UINavigationController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController]


//沙盒路径
#define  DOCUMENTSDIRECTORYPATH  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

//得到选择后沙盒中图片的完整路径
#define FILEPATH [[NSString alloc]initWithFormat:@"%@%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],  @"/image.png"]




#endif /* SSAllDefine_h */
