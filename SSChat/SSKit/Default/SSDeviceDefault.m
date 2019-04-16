//
//  SSDeviceDefault.m
//  caigou
//
//  Created by soldoros on 2018/4/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSDeviceDefault.h"
#import "sys/utsname.h"


static SSDeviceDefault* device = nil;


@implementation SSDeviceDefault

+(SSDeviceDefault *)shareCKDeviceDefault{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        device = [[SSDeviceDefault alloc]init];
        [device initData];
    });
    return device;
}


-(void)initData{

    //默认设备
    device.deviceType = DeviceiPhone;
    device.deviceModel = iPhone6S;
    
    device.statuBarHeight = 20;
    device.navBarHeight = 44;
    device.safeAreaTopHeight = 64;
    device.safeAreaBottomHeight = 0;
    device.tabBarHeight = 49;
    
    
    //判断当前设备属于哪个大类
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"])
        device.deviceType = DeviceiPhone;
    else if([deviceType isEqualToString:@"iPod touch"])
        device.deviceType = DeviceiPodTouch;
    else if([deviceType isEqualToString:@"iPad"])
        device.deviceType = DeviceiPad;
    
    
    //根据当前设备实时适配
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"i386"])
        device.deviceModel = Simulator;
    else if ([platform isEqualToString:@"x86_64"]){
        device.deviceModel = Simulator;
    }
    
    else if ([platform isEqualToString:@"iPhone3,1"])
        device.deviceModel = iPhone4;
    else if ([platform isEqualToString:@"iPhone3,2"])
        device.deviceModel = iPhone4;
    else if ([platform isEqualToString:@"iPhone3,3"])
        device.deviceModel = iPhone4;
    else if ([platform isEqualToString:@"iPhone4,1"])
        device.deviceModel = iPhone4S;
    else if ([platform isEqualToString:@"iPhone5,1"])
        device.deviceModel = iPhone5;
    
    else if ([platform isEqualToString:@"iPhone5,2"])
        device.deviceModel = iPhone5_GSM_CDMA ;
    else if ([platform isEqualToString:@"iPhone5,3"])
        device.deviceModel = iPhone5C_GSM;
    else if ([platform isEqualToString:@"iPhone5,4"])
        device.deviceModel = iPhone5C_GSM_CDMA;
    else if ([platform isEqualToString:@"iPhone6,1"])
        device.deviceModel = iPhone5S_GSM;
    else if ([platform isEqualToString:@"iPhone6,2"])
        device.deviceModel = iPhone5S_GSM_CDMA;
    
    else if ([platform isEqualToString:@"iPhone7,1"])
        device.deviceModel = iPhone6Plus;
    else if ([platform isEqualToString:@"iPhone7,2"])
        device.deviceModel = iPhone6;
    else if ([platform isEqualToString:@"iPhone8,1"])
        device.deviceModel = iPhone6S;
    else if ([platform isEqualToString:@"iPhone8,2"])
        device.deviceModel = iPhone6SPlus;
    else if ([platform isEqualToString:@"iPhone8,4"])
        device.deviceModel = iPhoneSE;
    
    else if ([platform isEqualToString:@"iPhone9,1"])
        device.deviceModel = iPhone7;
    else if ([platform isEqualToString:@"iPhone9,2"])
        device.deviceModel = iPhone7Plus;
    
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    else if ([platform isEqualToString:@"iPhone9,1"])
        device.deviceModel = iPhone7CGR;
    else if ([platform isEqualToString:@"iPhone9,2"])
        device.deviceModel = iPhone7PlusGC;
    else if ([platform isEqualToString:@"iPhone9,3"])
        device.deviceModel = iPhone7TM;
    else if ([platform isEqualToString:@"iPhone9,4"])
        device.deviceModel = iPhone7PlusTM;
    else if ([platform isEqualToString:@"iPhone10,1"])
        device.deviceModel = iPhone8;
    
    else if ([platform isEqualToString:@"iPhone10,4"])
        device.deviceModel = iPhone8;
    else if ([platform isEqualToString:@"iPhone10,2"])
        device.deviceModel = iPhone8Plus;
    else if ([platform isEqualToString:@"iPhone10,5"])
        device.deviceModel = iPhone8Plus;
    else if ([platform isEqualToString:@"iPhone10,3"])
        device.deviceModel = iPhoneX;
    else if ([platform isEqualToString:@"iPhone10,6"])
        device.deviceModel = iPhoneX;
    
    else if ([platform isEqualToString:@"iPod1,1"])
        device.deviceModel = iPodTouch1G;
    else if ([platform isEqualToString:@"iPod2,1"])
        device.deviceModel = iPodTouch2G;
    else if ([platform isEqualToString:@"iPod3,1"])
        device.deviceModel = iPodTouch3G;
    else if ([platform isEqualToString:@"iPod4,1"])
        device.deviceModel = iPodTouch4G;
    else if ([platform isEqualToString:@"iPod5,1"])
        device.deviceModel = iPodTouch5Gen;
    
    else if ([platform isEqualToString:@"iPad1,1"])
        device.deviceModel = iPad;
    else if ([platform isEqualToString:@"iPad1,2"])
        device.deviceModel = iPad3G;
    else if ([platform isEqualToString:@"iPad2,1"])
        device.deviceModel = iPad2WiFi;
    else if ([platform isEqualToString:@"iPad2,2"])
        device.deviceModel = iPad2;
    else if ([platform isEqualToString:@"iPad2,3"])
        device.deviceModel = iPad2_CDMA;
    else if ([platform isEqualToString:@"iPad2,4"])
        device.deviceModel = iPad2;
    
    else if ([platform isEqualToString:@"iPad2,5"])
        device.deviceModel = iPadMiniWiFi;
    else if ([platform isEqualToString:@"iPad2,6"])
        device.deviceModel = iPadMini;
    else if ([platform isEqualToString:@"iPad2,7"])
        device.deviceModel = iPadMini_GSM_CDMA;
    else if ([platform isEqualToString:@"iPad3,1"])
        device.deviceModel = iPad3WiFi;
    
    else if ([platform isEqualToString:@"iPad3,2"])
        device.deviceModel = iPad3_GSM_CDMA;
    else if ([platform isEqualToString:@"iPad3,3"])
        device.deviceModel = iPad3;
    else if ([platform isEqualToString:@"iPad3,4"])
        device.deviceModel = iPad4WiFi;
    else if ([platform isEqualToString:@"iPad3,5"])
        device.deviceModel = iPad4;
    else if ([platform isEqualToString:@"iPad3,6"])
        device.deviceModel = iPad4_GSM_CDMA;
    
    else if ([platform isEqualToString:@"iPad4,1"])
        device.deviceModel = iPadAirWiFi;
    else if ([platform isEqualToString:@"iPad4,2"])
        device.deviceModel = iPadAirCellular;
    else if ([platform isEqualToString:@"iPad4,4"])
        device.deviceModel = iPadMini2WiFi;
    else if ([platform isEqualToString:@"iPad4,5"])
        device.deviceModel = iPadMini2Cellular;
    else if ([platform isEqualToString:@"iPad4,6"])
        device.deviceModel = iPadMini2;
    
    else if ([platform isEqualToString:@"iPad4,7"])
        device.deviceModel = iPadMini3;
    else if ([platform isEqualToString:@"iPad4,8"])
        device.deviceModel = iPadMini3;
    else if ([platform isEqualToString:@"iPad4,9"])
        device.deviceModel = iPadMini3;
    else if ([platform isEqualToString:@"iPad5,1"])
        device.deviceModel = iPadMini4WiFi;
    else if ([platform isEqualToString:@"iPad5,2"])
        device.deviceModel = iPadMini4LTE;
    
    else if ([platform isEqualToString:@"iPad5,3"])
        device.deviceModel = iPadAir2;
    else if ([platform isEqualToString:@"iPad5,4"])
        device.deviceModel = iPadAir2;
    else if ([platform isEqualToString:@"iPad6,3"])
        device.deviceModel = iPadPro9_7;
    else if ([platform isEqualToString:@"iPad6,4"])
        device.deviceModel = iPadPro9_7;
    else if ([platform isEqualToString:@"iPad6,7"])
        device.deviceModel = iPadPro12_9;
    else if ([platform isEqualToString:@"iPad6,8"])
        device.deviceModel = iPadPro12_9;
    
    
    
    //根据不同的设备适配尺寸 iPhone X的尺寸是375*812
    if(device.deviceType==DeviceiPhone){
        
        if(device.deviceModel==Simulator){
            
            cout(@(SCREEN_Width));
            cout(@(SCREEN_Height));
            
            
            if(SCREEN_Height==812 || SCREEN_Height==896){
                device.statuBarHeight = 44;
                device.navBarHeight = 44;
                device.safeAreaTopHeight = 88;
                device.safeAreaBottomHeight = 34;
                device.tabBarHeight = 49;
            }else{
                device.statuBarHeight = 20;
                device.navBarHeight = 44;
                device.safeAreaTopHeight = 64;
                device.safeAreaBottomHeight = 0;
                device.tabBarHeight = 49;
            }
        }
        
        else{
            if(device.deviceModel == iPhoneX){
                device.statuBarHeight = 44;
                device.navBarHeight = 44;
                device.safeAreaTopHeight = 88;
                device.safeAreaBottomHeight = 34;
                device.tabBarHeight = 49;
            }else{
                device.statuBarHeight = 20;
                device.navBarHeight = 44;
                device.safeAreaTopHeight = 64;
                device.safeAreaBottomHeight = 0;
                device.tabBarHeight = 49;
            }
        }
        
    }
    
    //MP4设备目前都采用20+44+49的布局
    else if(device.deviceType==DeviceiPodTouch){
        device.statuBarHeight = 20;
        device.navBarHeight = 44;
        device.safeAreaTopHeight = 64;
        device.safeAreaBottomHeight = 0;
        device.tabBarHeight = 49;
    }
    
}




@end
