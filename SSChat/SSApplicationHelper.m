//
//  SSApplicationHelper.m
//  SSChat
//
//  Created by soldoros on 2019/5/20.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSApplicationHelper.h"
#import "SSChatIMEmotionModel.h"

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
    [[NIMSDKConfig sharedConfig] setTeamReceiptEnabled:YES];
    
    NIMMessageSetting *setting = [NIMMessageSetting new];
    setting.teamReceiptEnabled = YES;
    setting.historyEnabled = YES;
    setting.roamingEnabled = YES;
    setting.shouldBeCounted = YES;
    
    [Bmob registerWithAppKey:BOMB_APPKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        SSChartEmotionImages *emotion = [SSChartEmotionImages ShareSSChartEmotionImages];
        [emotion initEmotionImages];
        [emotion initSystemEmotionImages];
    });
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}






@end
