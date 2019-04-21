//
//  AppDelegate.m
//  SSChat
//
//  Created by soldoros on 2018/11/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "AppDelegate.h"
#import "SSRootManager.h"
#import "SSHelloManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [SSHelloManager shareHelloManager];
    [SSRootManager shareRootManager];
    
    
    return YES;
    
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
    
}


- (void)applicationWillTerminate:(UIApplication *)application {

    
}


@end
