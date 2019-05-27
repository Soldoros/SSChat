//
//  SSApplicationHelper.m
//  SSChat
//
//  Created by soldoros on 2019/5/20.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSApplicationHelper.h"

static SSApplicationHelper *applicationHelper = nil;

@implementation SSApplicationHelper

+(SSApplicationHelper *)shareApplicationHelper{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        applicationHelper = [SSApplicationHelper new];
    });
    return applicationHelper;
}

+(void)applicationRegister{
    
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:NIM_APPKey];
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    [Bmob registerWithAppKey:BOMB_APPKey];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}






@end
