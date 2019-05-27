//
//  SSRootManager.m
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSRootManager.h"
#import "AccountLoginController.h"
#import "RootTabBarController.h"
#import "SSAccountManager.h"


static SSRootManager *root = nil;

@implementation SSRootManager

+(SSRootManager *)shareRootManager{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        root = [[SSRootManager alloc]init];
    });
    return root;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NIMSDK sharedSDK].loginManager addDelegate:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotiLoginStatusChange object:nil];
        
        SSAccountModel *model = [SSAccountManager shareSSAccountManager].accountModel;
        if(model.account.length && model.password.length){
            [self autoLogin:model];
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

-(void)autoLogin:(SSAccountModel *)model{
    
    NIMAutoLoginData *login = [NIMAutoLoginData new];
    login.account = model.account;
    login.token =  model.password;
    [[NIMSDK sharedSDK].loginManager autoLogin:login];
}

-(void)initalizeRootController:(BOOL)isLogin{
    if(isLogin == NO) {
        [self emptyAllDatas];
        AccountLoginController *vc = [AccountLoginController new];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [AppDelegate sharedAppDelegate].window.rootViewController = nav;
    }else{
        RootTabBarController *tab = [RootTabBarController new];
        [AppDelegate sharedAppDelegate].window.rootViewController = tab;
    }
}

-(void)emptyAllDatas{
    [SSAccountManager shareSSAccountManager].accountModel = nil;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma arguments -NIMLoginManagerDelegate
-(void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType{
    
    NSString *message = @"您的账号在另一个设备登录";
    if(code == NIMKickReasonByServer){
        message = @"您被服务器踢下线";
    }else{
        message = @"您的账号在另一个客户端登录";
    }
    
    [[NIMSDK sharedSDK].loginManager logout:^(NSError * _Nullable error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
        [SSAlert pressentAlertControllerWithTitle:@"强制下线提醒" message:message okButton:@"确定" cancelButton:nil alertBlock:nil];
    }];
}

-(void)onAutoLoginFailed:(NSError *)error{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
    [SSAlert pressentAlertControllerWithTitle:nil message:@"自动登录失败，请重新登录" okButton:@"确定" cancelButton:nil alertBlock:nil];
}

@end
