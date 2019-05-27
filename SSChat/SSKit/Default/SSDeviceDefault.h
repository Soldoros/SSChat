//
//  SSDeviceDefault.h
//  caigou
//
//  Created by soldoros on 2018/4/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 判断设备大的类型

 - iPhone: 苹果手机
 - iPodTouch: 苹果mp4设备
 - iPad: 苹果平板电脑设备
 */
typedef NS_ENUM(NSInteger,SSDeviceType) {
    DeviceiPhone=1,
    DeviceiPodTouch,
    DeviceiPad,
};


/**
 设备信息 目前做移动设备开发主要适配苹果手机 4到5.5英寸以及iPhone X屏幕 后续带刘海的iPhone屏幕都将成为主力

 - Simulator: 模拟器
 - iPodTouch1G: iPodTouch1G description
 - iPodTouch2G: iPodTouch2G description
 - iPodTouch3G: iPodTouch3G description
 - iPodTouch4G: iPodTouch4G description
 - iPodTouch5Gen: iPodTouch5Gen description
 - iPhone3G: iPhone3G description
 - iPhone3GS: iPhone3GS description
 - iPhone4: iPhone4 description
 - iPhone4S: iPhone4S description
 - iPhone5: iPhone5 description
 - iPhone5_GSM_CDMA: iPhone5_GSM_CDMA description
 - iPhone5C: iPhone5C description
 - iPhone5C_GSM: iPhone5C_GSM description
 - iPhone5C_GSM_CDMA: iPhone5C_GSM_CDMA description
 - iPhone5S: iPhone5S description
 - iPhone5S_GSM: iPhone5S_GSM description
 - iPhone5S_GSM_CDMA: iPhone5S_GSM_CDMA description
 - iPhone6: iPhone6 description
 - iPhone6Plus: iPhone6Plus description
 - iPhone6S: iPhone6S description
 - iPhone6SPlus: iPhone6SPlus description
 - iPhoneSE: iPhoneSE description
 - iPhone7: iPhone7 description
 - iPhone7Plus: iPhone7Plus description
 - iPhone8: iPhone8 description
 - iPhone8Plus: iPhone8Plus description
 - iPhoneX: iPhoneX description
 - iPhone7CGR: 国行、日版、港行iPhone 7
 - iPhone7PlusGC: 港行、国行iPhone 7 Plus
 - iPhone7TM: 美版、台版iPhone 7
 - iPhone7PlusTM: 美版、台版iPhone 7 Plus
 - iPad: iPad description
 - iPad3G: iPad3G description
 - iPad2WiFi: iPad2WiFi description
 - iPad2: iPad2 description
 - iPad3: iPad3 description
 - iPad2_CDMA: iPad2_CDMA description
 - iPadMini: iPadMini description
 - iPadMiniWiFi: iPadMiniWiFi description
 - iPadMini_GSM_CDMA: iPadMini_GSM_CDMA description
 - iPad3WiFi: iPad3WiFi description
 - iPad3_GSM_CDMA: iPad3_GSM_CDMA description
 - iPad4WiFi: iPad4WiFi description
 - iPad4: iPad4 description
 - iPad4_GSM_CDMA: iPad4_GSM_CDMA description
 - iPadAirWiFi: iPadAirWiFi description
 - iPadAirCellular: iPadAirCellular description
 - iPadMini2: iPadMini2 description
 - iPadMini2WiFi: iPadMini2WiFi description
 - iPadMini2Cellular: iPadMini2Cellular description
 - iPadMini3: iPadMini3 description
 - iPadMini4WiFi: iPadMini4WiFi description
 - iPadMini4LTE: iPadMini4LTE description
 - iPadAir2: iPadAir2 description
 - iPadPro9_7: iPadPro9_7 description
 - iPadPro12_9: iPadPro12_9 description
 */
typedef NS_ENUM(NSInteger,SSDeviceModel) {
    
    Simulator=1,
    
    iPodTouch1G,
    iPodTouch2G,
    iPodTouch3G,
    iPodTouch4G,
    iPodTouch5Gen,
    
    iPhone3G,
    iPhone3GS,
    iPhone4,
    iPhone4S,
    iPhone5,
    iPhone5_GSM_CDMA,
    
    iPhone5C,
    iPhone5C_GSM,
    iPhone5C_GSM_CDMA,
    iPhone5S,
    iPhone5S_GSM,
    iPhone5S_GSM_CDMA,
    
    iPhone6,
    iPhone6Plus,
    iPhone6S,
    iPhone6SPlus,
    iPhoneSE,
    iPhone7,
    iPhone7Plus,
    iPhone8,
    iPhone8Plus,
    iPhoneX,
    
    iPhone7CGR,
    iPhone7PlusGC,
    iPhone7TM,
    iPhone7PlusTM,
    
    
    iPad=500,
    iPad3G,
    iPad2WiFi,
    iPad2,
    iPad3,
    iPad2_CDMA,
    iPadMini,
    iPadMiniWiFi,
    iPadMini_GSM_CDMA,
    iPad3WiFi,
    iPad3_GSM_CDMA,
    iPad4WiFi,
    iPad4,
    iPad4_GSM_CDMA,
    
    
    iPadAirWiFi,
    iPadAirCellular,
    iPadMini2,
    iPadMini2WiFi,
    iPadMini2Cellular,
    iPadMini3,
    iPadMini4WiFi,
    iPadMini4LTE,
    iPadAir2,
    iPadPro9_7,
    iPadPro12_9,

};

@interface SSDeviceDefault : NSObject


+(SSDeviceDefault *)shareCKDeviceDefault;
-(void)initData;

//设备信息
@property(nonatomic,assign)SSDeviceType deviceType;
@property(nonatomic,assign)SSDeviceModel deviceModel;


//状态栏 导航栏 安全区域顶部  安全区域(iPhone X有) 标签栏
@property(nonatomic,assign)CGFloat statuBarHeight;
@property(nonatomic,assign)CGFloat navBarHeight;
@property(nonatomic,assign)CGFloat safeAreaTopHeight;
@property(nonatomic,assign)CGFloat safeAreaBottomHeight;
@property(nonatomic,assign)CGFloat tabBarHeight;





@end
