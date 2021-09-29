//
//  SSConfigManager.h
//  SSChat
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 
 app模块
 
 - TabBarQuFound: 用户端
 - TabBarQuBusiness: 商家端
 - TabBarQuBusEmployees: 商家员工
 - TabBarQuAgent: 经纪人端
 - TabBarQuDeveloper: 开发商端
 - TabBarQuLandlord: 企业房东
 - TabBarQuLandEmployees: 企业房东员工
 */
typedef NS_ENUM(NSInteger,TabBarType) {
    
    TabBarQuFound = 1,
    TabBarQuBusiness,
    TabBarQuBusEmployees,
    TabBarQuAgent,
    TabBarQuDeveloper,
    TabBarQuLandlord,
    TabBarQuLandEmployees,
};



/**
 
 app字号设置
 
 - ConfigFontMin: 小号字体
 - ConfigFontMiddle: 中号字体
 - ConfigFontMax: 大号字体
 */
typedef NS_ENUM(NSInteger,ConfigFontType) {
    
    ConfigFontMin = 1,
    ConfigFontMiddle,
    ConfigFontMax,
};


/**
 
 app主题色设置
 
 - ConfigThemeWhite: 白色
 - ConfigThemeBlack: 黑色
 - ConfigThemeBlue: 蓝色
 - ConfigThemeGreen: 绿色
 - ConfigThemeRed: 红色
 - ConfigThemeYellow: 黄色
 */
typedef NS_ENUM(NSInteger,ConfigThemeType) {
    
    ConfigThemeWhite = 1,
    ConfigThemeBlack,
    ConfigThemeBlue,
    ConfigThemeGreen,
    ConfigThemeRed,
    ConfigThemeYellow,
};


@interface SSConfigManager : NSObject


//初始化APP属性
+(SSConfigManager *)shareManager;

@property(nonatomic, strong)NSUserDefaults *userDefaults;


//字号规格
@property(nonatomic, assign)ConfigFontType fontType;
//聊天字号
@property(nonatomic, strong)UIFont    *chatFont;


//主题
@property(nonatomic, assign)ConfigThemeType  themeType;
//主题颜色
@property(nonatomic, strong)UIColor   *titleColor;
//导航栏+状态栏背景颜色
@property(nonatomic, strong)UIColor   *navBarColor;
//标签栏背景颜色
@property(nonatomic, strong)UIColor   *tabBarColor;
//导航栏图标颜色
@property(nonatomic, strong)UIColor   *navTintColor;
//标签栏图标默认状态颜色
@property(nonatomic, strong)UIColor   *tabBarTintDefaultColor;
//标签栏图标选中状态颜色
@property(nonatomic, strong)UIColor   *tabBarTintSelectColor;
//视图背景色
@property(nonatomic, strong)UIColor   *backGroundColor;
//导航栏底部线条颜色
@property(nonatomic, strong)UIColor   *navLineColor;
//状态栏文字颜色
@property(nonatomic,assign)UIStatusBarStyle barStyle;
//返回按钮图片
@property(nonatomic, strong)NSString *leftBtnImg;


//聊天背景图
@property(nonatomic, strong)NSString   *chatBackImage;



@end



