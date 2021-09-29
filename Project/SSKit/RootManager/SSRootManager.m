//
//  SSRootManager.m
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSRootManager.h"
#import "RootTabBarController.h"
#import "AccountLoginController.h"


@implementation SSRootManager

+(instancetype)shareRootManager:(SSRootManagerType)type{
    switch (type) {
        case ManagerTypePart:{
            return [SSRootPartOfManager shareRootPartOfManager];
        }
            break;
        case ManagerTypeAll:{
            return [SSRootAllOfManager shareSSRootAllOfManager];
        }
            break;
        default:
            return nil;
            break;
    }
}


@end




/**
 部分界面需要登录显示
 */

static SSRootPartOfManager *partRoot = nil;
@implementation SSRootPartOfManager

+(SSRootPartOfManager *)shareRootPartOfManager{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        partRoot = [[SSRootPartOfManager alloc]init];
    });
    return partRoot;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotiLoginStatusChange object:nil];
        
        RootTabBarController *tab = [RootTabBarController new];
        tab.delegate = self;
        [AppDelegate sharedAppDelegate].window.rootViewController = tab;
    }
    return self;
}

/**
 @param noti 登出后接收到的通知对象
 */
-(void)loginStateChange:(NSNotification *)noti{
    
    BOOL isLogin = [noti.object boolValue];
    cout([NSString stringWithFormat:@"%d",isLogin]);
    [SSRootAccount setUserLogin:[NSString stringWithFormat:@"%d",isLogin]];
    
    //退出登录是否需要弹出登录界面
    if(isLogin == NO) {
       
//        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        RootTabBarController *tab = (RootTabBarController *)appDelegate.window.rootViewController;
//
//        AccountLoginController *vc = [AccountLoginController new];
//        RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
//        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [tab presentViewController:nav animated:YES completion:nil];
    }
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSInteger new = [tabBarController.viewControllers indexOfObject:viewController];
     
    NSInteger content = -1;
    
    for(NSString *string in self.needIndexs){
        NSInteger index = string.integerValue;
        if(new == index){
            content = index;
            break;
        }
    }
    
    //未登录
    if(([SSRootAccount getUserLogin]  == nil || [[SSRootAccount getUserLogin] integerValue] == 0) && content != -1){
        
        AccountLoginController *vc = [AccountLoginController new];
        RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [tabBarController presentViewController:nav animated:YES completion:nil];
        return  NO;
    }
    else{
        return YES;
    }
}

@end



/**
 全部界面需要显示
 */
static SSRootAllOfManager *allRoot = nil;
@implementation SSRootAllOfManager

+(SSRootAllOfManager *)shareSSRootAllOfManager{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        allRoot = [[SSRootAllOfManager alloc]init];
    });
    return allRoot;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotiLoginStatusChange object:nil];
        
        if([SSRootAccount getUserLogin]  == nil || [[SSRootAccount getUserLogin] integerValue] == 0){
            [self initalizeRootController:YES];
        }else{
            [self initalizeRootController:NO];
        }
    }
    return self;
}

-(void)loginStateChange:(NSNotification *)noti{
    
    BOOL isLogin = [noti.object boolValue];
    [self initalizeRootController:isLogin];
}

-(void)initalizeRootController:(BOOL)isLogin{
    
    if(isLogin == NO) {
        
        [SSRootAccount setUserLogin:@"0"];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        AccountLoginController *vc = [AccountLoginController new];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [AppDelegate sharedAppDelegate].window.rootViewController = nav;
    }else{
        
        RootTabBarController *tab = [RootTabBarController new];
        [AppDelegate sharedAppDelegate].window.rootViewController = tab;
    }
}


@end
