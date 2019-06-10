//
//  AppDelegate.m
//  SSChat
//
//  Created by soldoros on 2018/11/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*
 
 UIEdgeInsets safeArea = UIEdgeInsetsZero;
 if (@available(iOS 11.0, *))
 {
 safeArea = self.superview.safeAreaInsets;
 }
 
 Git  add .
 Git commit –m “版本”

 
 git pull origin master
 git push -u origin master
 
 com.netease.NIM.demo
 
 com.soldoros.SSChat
 2018年7月12  2019-06-04
 */


#import "AppDelegate.h"
#import "SSRootManager.h"
#import "SSApplicationHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SSApplicationHelper applicationRegister];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [SSRootManager shareRootManager];
    
    return [[SSApplicationHelper shareApplicationHelper] application:application didFinishLaunchingWithOptions:launchOptions];
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount] + [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
   
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    cout(deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    cout(userInfo);
}



- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    cout(error);
}


@end
