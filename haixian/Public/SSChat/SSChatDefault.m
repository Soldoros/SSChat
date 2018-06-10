//
//  SSChatDefault.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "SSChatDefault.h"

//17780503929  13540033103  18081921108

static SSChatDefault *sschat = nil;



@implementation SSChatDefault

+(SSChatDefault *)shareSSChatDefault{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        sschat = [[SSChatDefault alloc]init];
        
    });
    return sschat;
}


-(void)initSSChat{
    
    //注册环信
    EMOptions *options = [EMOptions optionsWithAppkey:EMAPPKey];
    options.apnsCertName = APNSKey;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    //好友请求代理注册
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [self sschatRegister];
}

//注册
-(void)sschatRegister{
    
    NSUserDefaults *_user = [NSUserDefaults standardUserDefaults];
    
    NSString *string = SSChatSendUserName;
//    if([_user boolForKey:USER_Login] == NO) {
//        return;
//    }
//
//    EMError *error = [[EMClient sharedClient] registerWithUsername:string password:string];
//
//    if(error){
//        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"环信注册失败!"];
//    }else{
//        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"环信注册成功!"];
//    }

    [[EMClient sharedClient] loginWithUsername:string
     password:string completion:^(NSString *aUsername, EMError *aError) {
         if(!aError)cout(@"环信登录成功");
         else cout(@"环信登录失败");
    }];
        
    

}

//环信自动登录失败回调
-(void)autoLoginDidCompleteWithError:(EMError *)aError{
    BOOL is = [[EMClient sharedClient] isLoggedIn];
    if(is==NO){
        makeUserLoginNo();
        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"自动登录失败!"];
    }
}


//账号异地登录
-(void)userAccountDidLoginFromOtherDevice{
    NSString *loginUsername = [[EMClient sharedClient] currentUsername];
    cout(loginUsername);
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        makeUserLoginNo();
        [self sendNotifCation:NotiMyMsgChange];
        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"您的账号在其他设备登录!"];
    }else{
        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:error.errorDescription];
    }
}


//用户数据物理删除
-(void)userAccountDidRemoveFromServer{
    makeUserLoginNo();
    [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"您已被平台物理删除"];
}

//用户被禁用
-(void)userDidForbidByServer{
    makeUserLoginNo();
    [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"您已被平台禁用IM功能"];
}

//别人加你好友 你会收到回调
-(void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
    if (!error) {
        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"添加好友成功"];
    }
}


//你加别人 别人同意了 你会收到回调
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    
    
}

//你加别人 别人拒绝了 你会收到回调
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
   
    
}

//在线普通消息回调
-(void)messagesDidReceive:(NSArray *)aMessages{
    cout(@"收到普通消息");
    NSDictionary *dic = @{NotiReceiveMessages:aMessages};
    [self sendNotifCation:NotiReceiveMessages data:dic];
}

//透传（cmd）在线消息回调 (消息撤回后回调)
-(void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    cout(@"透传消息收到");
    NSDictionary *dic = @{NotiReceiveCMDMessages:aCmdMessages};
    [self sendNotifCation:NotiReceiveCMDMessages data:dic];

}







@end
