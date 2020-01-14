//
//  AppDelegate.m
//  SSChat
//
//  Created by soldoros on 2018/11/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*
 
git remote add origin https://github.com/Soldoros/SSChat.git
 
 
 git pull origin master
 git push -u origin master
 
 */

#import "AppDelegate.h"
#import "RootController.h"
#import "SSChatIMEmotionModel.h"

@interface AppDelegate ()

@property(nonatomic,strong)SSChartEmotionImages *emotion;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.emotion = [SSChartEmotionImages ShareSSChartEmotionImages];
        [self.emotion initEmotionImages];
        [self.emotion initSystemEmotionImages];
        
    });
    
    //                domain: http://linjw-gobid.oss-cn-beijing.aliyuncs.com/
    //                backname: linjw-gobid
    //                endpoint: http://oss-cn-beijing.aliyuncs.com
    
    NSString *endpoint = @"----------";
    
    
    
    RootController *vc = [[RootController alloc]init];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
