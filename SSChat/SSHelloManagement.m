//
//  SSHelloManagement.m
//  SSChat
//
//  Created by soldoros on 2019/4/13.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSHelloManagement.h"

static SSHelloManagement *hello = nil;

@implementation SSHelloManagement

+(SSHelloManagement *)shareHelloManagement{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        hello = [[SSHelloManagement alloc]init];
        [hello initalizeRegister];
    });
    return hello;
}

-(void)initalizeRegister{
    
    EMOptions *options = [EMOptions optionsWithAppkey:HelloAppKey];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //登录回调
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    //注册好友申请/删除回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
}


//网络自动重连
-(void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    cout(@"网络自动重连");
}

//自动登录失败回调
-(void)autoLoginDidCompleteWithError:(EMError *)aError{
    if (aError) {
        [SSAlert pressentAlertControllerWithTitle:nil message:@"自动登陆失败，请重新登陆!" okButton:@"确定" cancelButton:nil alertBlock:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO]; 
    }
    else{
        cout(@"自动登录成功!");
    }
}

//账号在其他设备登录
-(void)userAccountDidLoginFromOtherDevice{
    [SSAlert pressentAlertControllerWithTitle:nil message:@"您的账号在其他设备登录" okButton:@"确定" cancelButton:nil alertBlock:nil];
    [[EMClient sharedClient] logout:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
}

//账号从服务器端删除
-(void)userAccountDidRemoveFromServer{
    [SSAlert pressentAlertControllerWithTitle:nil message:@"您的账号在服务器端被删除" okButton:@"确定" cancelButton:nil alertBlock:nil];
    [[EMClient sharedClient] logout:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
}

//账号被禁用
-(void)userDidForbidByServer{
    [SSAlert pressentAlertControllerWithTitle:nil message:@"您的账号已被禁用" okButton:@"确定" cancelButton:nil alertBlock:nil];
    [[EMClient sharedClient] logout:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
}

//账号被强制下线
-(void)userAccountDidForcedToLogout:(EMError *)aError{
    [SSAlert pressentAlertControllerWithTitle:@"强制下线提醒" message:aError.errorDescription okButton:@"确定" cancelButton:nil alertBlock:nil];
    [[EMClient sharedClient] logout:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
}


//用户A发送加用户B为好友的申请，用户B会收到这个回调
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{
    cout(@"收到好友请求的回调");
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiGetAddContacts object:nil];
}

//用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    cout(@"收到好友同意添加的回调");
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiContactChange object:nil];
}

//用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    cout(@"收到好友拒绝添加的回调");
}

//用户B删除与用户A的好友关系后，用户A，B会收到这个回调
- (void)friendshipDidRemoveByUser:(NSString *)aUsername{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiContactChange object:nil];
}

//接收一条及以上的普通在线消息
-(void)messagesDidReceive:(NSArray *)aMessages{
    cout(@"在线来消息了");
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiReceiveMessages object:aMessages];
}

//接收一条及以上的透传消息
-(void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    cout(@"透传来消息了");
     [[NSNotificationCenter defaultCenter] postNotificationName:NotiReceiveMessages object:aCmdMessages];
}


@end
