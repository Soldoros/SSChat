//
//  DEDefine.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


//用户信息
extern NSString *const USER_Message;
//登陆key  登陆判断
extern NSString *const USER_Login;
//userId
extern NSString *const USER_Token;
//设备号
extern NSString *const USER_Device;


//token_type
extern NSString *const USER_TokenType;
//access_token
extern NSString *const USER_AccessToken;
//请求头headerUrl=token_type+access_token
extern NSString *const USER_HeaderUrl;


//用户名 手机号 密码
extern NSString *const USER_Name;
extern NSString *const USER_Mobile;
extern NSString *const USER_Password;

//客服电话
extern NSString *const USER_Kefu;


//key 图片 手机号 性别 昵称 头像
extern NSString *const USER_Key;
extern NSString *const USER_Img;
extern NSString *const USER_Sex;
extern NSString *const USER_Nickname;
extern NSString *const USER_Avator;

//企业名称 联系人 联系电话 所属行业 企业地址 详细地址
extern NSString *const USER_CPName;
extern NSString *const USER_CPPerson;
extern NSString *const USER_CPPhone;
extern NSString *const USER_CPIndustry;
extern NSString *const USER_CPAddress;
extern NSString *const USER_CPDetAddress;


//环信账号
extern NSString *const USER_HxPhone;

//用户类型 1个人用户 2普通企业用户 3授信企业用户
extern NSString *const USER_MemberTyp;

//授信状态
extern NSString *const USER_IsSet;


//企业授信申请 1待审核 2审核不通过 3审核通过
extern NSString *const USER_CpApproved;

//定位信息
extern NSString *const USER_Dingwei;
extern NSString *const USER_DingweiDatas;
extern NSString *const USER_Jingdu;
extern NSString *const USER_Weidu;

//搜搜历史
extern NSString *const USER_SearchHistory;


//输入框限制输入信息
extern NSString *const NUMERIC_CHARACTERS;
//搜索历史
extern NSString *const SEARCHHISTORY;



#ifndef IOS_Soldoros__Define
#define IOS_Soldoros__Define



//打印
#define MESSAGE     NSLog(@"响应了")
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)


//主题色
#define TitleColor  [SSAttributeDefault shareCKAttributeDefault].titleColor

//第二主题色
#define TitleColor2  [SSUserDefault shareCKUserDefault].tabBarColor

//标签栏颜色
#define TabbarColor  [SSAttributeDefault shareCKAttributeDefault].tabBarColor
//标签栏字体未选中的颜色
#define TabBarTintDefaultColor  [SSAttributeDefault shareCKAttributeDefault].tabBarTintDefaultColor
//标签栏字体选中的颜色
#define TabBarTintSelectColor  [SSAttributeDefault shareCKAttributeDefault].tabBarTintSelectColor


#define RoundViewColor  [UIColor redColor]



//图片占位颜色
#define ImagePlaceColor  makeColorRgb(200, 200, 200)

//占位图
#define ImagePlace1        @"zhanwei1"
#define ImagePlace2        @"zhanwei2"
#define ImagePlace3        @"zhanwei3"
#define ImagePlace4        @"zhanwei4"

//cell线条颜色
#define CellLineColor  makeColorRgb(200, 200, 200)
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
#define LineColor  makeColorRgb(240, 240, 240)


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














#endif
