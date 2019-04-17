//
//  SSRootManager.m
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSRootManager.h"
#import "AccountLoginController.h"
#import "ConversationController.h"
#import "ContactController.h"
#import "MineController.h"

#import "SSHelloManager.h"
#import "SSNotificationManager.h"


static SSRootManager *manager = nil;

@implementation SSRootManager

+(SSRootManager *)shareRootManager{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        manager = [[SSRootManager alloc]init];
        manager.user = [NSUserDefaults standardUserDefaults];
        [manager registerNitification];
       
        if([manager.user valueForKey:USER_Name] == nil){
            [manager.user setBool:NO forKey:USER_Login];
            [manager.user setValue:@"" forKey:USER_Name];
            [manager.user setValue:@"" forKey:USER_Nickname];
            [manager.user setValue:@"" forKey:USER_Password];
            [manager.user setBool:YES forKey:USER_AddVerification];
        }
        
        [manager initalizeManagement:[manager.user boolForKey:USER_Login]];
    });
    return manager;
}

-(void)registerNitification{
    
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(loginStateChange:) name:NotiLoginStatusChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(didNotificationsUnreadCountUpdate:) name:NotiUnreadCount object:nil];
}

-(void)loginStateChange:(NSNotification *)noti{
    
    BOOL isLogin = [noti.object boolValue];
    [manager.user setBool:isLogin forKey:USER_Login];
    [self initalizeManagement:isLogin];
}

-(void)initalizeManagement:(BOOL)isLogin{
    if(isLogin == NO) {
        [manager initalizeLoginController];
        
    }else{
        
        [manager initalizeUserInterface];
        [SSHelloManager shareHelloManager];
        [SSNotificationManager shareSSNotificationManager];
    }
}

-(void)initalizeLoginController{
    AccountLoginController *vc = [AccountLoginController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [AppDelegate sharedAppDelegate].window.rootViewController = nav;
}

-(void)initalizeUserInterface{
    
    ConversationController *vc1 = [[ConversationController alloc]initWithRoot:YES title:@"消息"];
    ContactController *vc2 = [[ContactController alloc]initWithRoot:YES title:@"通讯录"];
    MineController *vc3 = [[MineController alloc]initWithRoot:YES title:@"我的"];
    
    UINavigationController *nav1 = [manager setNav:vc1 title:@"消息" nomImg:@"Tab_message_nol" selImg:@"Tab_message_sel"];
    UINavigationController *nav2 = [manager setNav:vc2 title:@"通讯录" nomImg:@"Tab_contact_nol" selImg:@"Tab_contact_sel"];
    UINavigationController *nav3 = [manager setNav:vc3 title:@"我的" nomImg:@"Tab_wode_nol" selImg:@"Tab_wode_sel"];
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.delegate = self;
    tabBarController.viewControllers = @[nav1,nav2,nav3];
    [AppDelegate sharedAppDelegate].window.rootViewController = tabBarController;
}


-(UINavigationController *)setNav:(BaseVirtualController *)vc title:(NSString *)title nomImg:(NSString *)img1 selImg:(NSString *)img2{
    [vc setItemImg1:img1 img2:img2 title:title color1:TabBarTintDefaultColor color2:TabBarTintSelectColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    return nav;
}


//消息未读展示红点
-(void)didNotificationsUnreadCountUpdate:(NSNotification *)noti{
    
    NSInteger count = [(NSString *)noti.object integerValue];
    
    UITabBarController *tabBarController = (UITabBarController *)[AppDelegate sharedAppDelegate].window.rootViewController;
    UINavigationController *nav = tabBarController.viewControllers[1];
    if(count>0){
        nav.tabBarItem.badgeValue = makeStrWithInt(count);
    }else{
        nav.tabBarItem.badgeValue = nil;
    }
}


@end
