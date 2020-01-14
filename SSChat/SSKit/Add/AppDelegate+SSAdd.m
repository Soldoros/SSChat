//
//  AppDelegate+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "AppDelegate+SSAdd.h"


@implementation AppDelegate (SSAdd)


//获取全局单例
+(AppDelegate *)sharedAppDelegate{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}


//获取根控制器
+(BaseVirtualController *)getRootViewController{
    UINavigationController *nav = (UINavigationController *)[AppDelegate sharedAppDelegate].window.rootViewController;
    return (BaseVirtualController *)nav.viewControllers[0];
}






@end
