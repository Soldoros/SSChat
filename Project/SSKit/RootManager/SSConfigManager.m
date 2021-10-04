//
//  SSConfigManager.m
//  SSChat
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "SSConfigManager.h"


static  NSString *Model_fontType   = @"fontType";
static  NSString *Model_themeType  = @"themeType";


static SSConfigManager *config = nil;

@implementation SSConfigManager

@synthesize    fontType      =      _fontType;
@synthesize    themeType     =      _themeType;



//初始化系统基础信息
+(SSConfigManager *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[SSConfigManager alloc]init];
    });
    return config;
}

-(instancetype)init{
    if(self = [super init]){

        _userDefaults = [NSUserDefaults standardUserDefaults];
        
        self.fontType = self.fontType;
        self.themeType = self.themeType;
        
    }
    return self;
}



//获取字体
-(ConfigFontType)fontType{
    ConfigFontType fontType =  [_userDefaults integerForKey:Model_fontType];
    if(fontType == 0){
        cout(@"未初始化字体");
        fontType = ConfigFontMiddle;
    }
    return fontType;
}

//获取主题
-(ConfigThemeType)themeType{
    ConfigThemeType themeType = [_userDefaults integerForKey:Model_themeType];
    if(themeType == 0){
        cout(@"未初始化主题");
        themeType = ConfigThemeWhite;
    }
    return themeType;
}


//设置字体
-(void)setFontType:(ConfigFontType)fontType{
    _fontType = fontType;
    [_userDefaults setInteger:_fontType forKey:Model_fontType];
    
    switch (_fontType) {
        case ConfigFontMin:{
            self.chatFont   = makeFont(14);
        }
            break;
        case ConfigFontMiddle:{
            self.chatFont   = makeFont(16);
        }
        break;
        case ConfigFontMax:{
            self.chatFont   = makeFont(18);
        }
        break;
            
        default:
            break;
    }
    
}


//设置主题
-(void)setThemeType:(ConfigThemeType)themeType{
    _themeType = themeType; 
    [_userDefaults setInteger:_themeType forKey:Model_themeType];
    
    
    switch (_themeType) {

            //蓝白
        case ConfigThemeWhite:{
            self.titleColor   = makeColorRgb(77, 192, 255);
            self.navBarColor  = [UIColor whiteColor];
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor blackColor];
            self.navLineColor    = makeColorHex(@"#E2E2E2");
            self.backGroundColor        = makeColorRgb(240, 240, 240);
            self.tabBarTintDefaultColor = makeColorHex(@"#555555");
            self.tabBarTintSelectColor  = makeColorRgb(20, 164, 252);
            self.barStyle = UIStatusBarStyleDefault;
            self.leftBtnImg = @"return";
        }
            break;
            //黑色
        case ConfigThemeBlack:{
            self.titleColor   = [UIColor blackColor];
            self.navBarColor  = makeColorRgb(38, 38, 38);
            self.navLineColor    = makeColorRgb(38, 38, 38);
            self.tabBarTintSelectColor  = makeColorRgb(38, 38, 38);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //蓝色
        case ConfigThemeBlue:{
            self.titleColor   = makeColorRgb(57, 152, 247);
            self.navBarColor  = makeColorRgb(57, 152, 247);
            self.navLineColor    = makeColorRgb(57, 152, 247);
            self.tabBarTintSelectColor  = makeColorRgb(57, 152, 247);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //绿色
        case ConfigThemeGreen:{
            self.titleColor   = makeColorHex(@"20D3B3");
            self.navBarColor  = makeColorHex(@"20D3B3");
            self.navLineColor    = makeColorHex(@"20D3B3");
            self.tabBarTintSelectColor  = makeColorHex(@"20D3B3");
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //红色
        case ConfigThemeRed:{
            self.titleColor   = makeColorRgb(215, 19, 28);
            self.navBarColor  = makeColorRgb(215, 19, 28);
            self.navLineColor    = makeColorRgb(215, 19, 28);
            self.tabBarTintSelectColor  = makeColorRgb(215, 19, 28);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //黄色
        case ConfigThemeYellow:{
            self.navBarColor  = makeColorRgb(254, 230, 88);
            self.navLineColor    = makeColorRgb(254, 230, 88);
            self.titleColor   = makeColorRgb(254, 230, 88);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
        default:{
            
        }
            break;
    }
}


@end
