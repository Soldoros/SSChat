//
//  AppDelegate+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (SSAdd)


/**
 获取单例
 @return 返回delegate单例
 */
+(AppDelegate *)sharedAppDelegate;


//获取根控制器
+(BaseVirtualController *)getRootViewController;







@end
