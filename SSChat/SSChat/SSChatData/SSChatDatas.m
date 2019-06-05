//
//  SSChatDatas.m
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import "SSChatDatas.h"
#import <UserNotifications/UserNotifications.h>
#import "SSChatTime.h"


@implementation SSChatDatas

-(instancetype)init{
    if(self = [super init]){
        _timelInterval = -1;
    }
    return self;
}

// 获取昵称/群组名
+(NSString *)showNicknameWithSession:(NIMSession *)session message:(NIMMessage *)message{
    
    NSString *uid = message.from;
    NSString *name = session.sessionId;
    
    if ([[NIMSDK sharedSDK].robotManager isValidRobot:session.sessionId]){
        NIMRobot *robot = [[NIMSDK sharedSDK].robotManager robotInfo:session.sessionId];
        if (robot){
            name = robot.nickname;
        }
    }else{
        
        switch (session.sessionType) {
            case NIMSessionTypeP2P:
            {
                NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:uid];
                name = [PBData getUserNameWithUser:user];
            }
                break;
            case NIMSessionTypeTeam:
            {
                NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:session.sessionId];
                name = team.teamName;
            }
                break;
            case NIMSessionTypeChatroom:
            {
                if ([uid isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount]){
                    
                    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:uid];
                    name = user.userInfo.nickName;
                }else{
                    
                    NIMMessageChatroomExtension *ext = message.messageExt;
                    name = ext.roomNickname;
                }
            }
                break;
            default:
                
                break;
        }
    }
    
    return name;
}

//获取列表头像
+(NSString *)showHeaderImgWithSession:(NIMSession *)session{
    
    NSString *name = @"user_avatar_blue";
    
    if ([[NIMSDK sharedSDK].robotManager isValidRobot:session.sessionId]){
        name = @"call";
    }else{
        
        switch (session.sessionType) {
            case NIMSessionTypeP2P:
            {
               name = @"user_avatar_blue";
            }
                break;
            case NIMSessionTypeTeam:
            {
                name = @"group_avatar";
            }
                break;
            case NIMSessionTypeChatroom:
            {
                name = @"chatroom";
            }
                break;
            default:
                
                break;
        }
    }
    
    return name;
}


//获取名称
+(NSString *)getNavagationTitle:(NIMSession *)session{
    
    NSString *title = @"";
    NIMSessionType type = session.sessionType;
    switch (type) {
        case NIMSessionTypeTeam:{
            NIMTeam *team = [[[NIMSDK sharedSDK] teamManager] teamById:session.sessionId];
            title = [NSString stringWithFormat:@"%@(%zd)",[team teamName],[team memberNumber]];
        }
            break;
        case NIMSessionTypeP2P:{
            NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:session.sessionId];
            title = [PBData getUserNameWithUser:user];
        }
            break;
        default:
            break;
    }
    return title;
}


//处理消息的时间显示
-(void)dealTimeWithMessageModel:(SSChatMessage *)model{
    SSChatMessage *message = model;
    CGFloat interval = (_timelInterval - model.timestamp) / 1000;
    if (_timelInterval < 0 || interval > 60 || interval < -60) {
        message.messageTime = [SSChatTime formattedTimeFromTimeInterval:model.timestamp];
        _timelInterval = model.timestamp;
        message.showTime = YES;
    }
}

//网易模型数组转本地layout数组
-(NSMutableArray *)getLayoutsWithMessages:(NSArray *)aMessages sessionId:(NSString *)sessionId{
    
    NSMutableArray *array = [NSMutableArray new];
    for(NIMMessage *message in aMessages){
        
        if([message.session.sessionId isEqualToString:sessionId]){
            SSChatMessagelLayout *layout = [self getLayoutWithMessage:message];
            [array addObject:layout];
        }
    }
    return  array;
}

//model转layout
-(SSChatMessagelLayout *)getLayoutWithMessage:(NIMMessage *)message{
    SSChatMessage *chatMessage = [self getModelWithMessage:message];
    return [[SSChatMessagelLayout alloc]initWithMessage:chatMessage];
}


//网易IM模型转本地模型
-(SSChatMessage *)getModelWithMessage:(NIMMessage *)message{
    
    SSChatMessage *chatMessage = [SSChatMessage new];
    chatMessage.message = message;
    chatMessage.timestamp = message.timestamp;
    [self dealTimeWithMessageModel:chatMessage];
    
    NSString *currentId = [[NIMSDK sharedSDK] loginManager].currentAccount;
    
    if([message.from isEqualToString:currentId]){
        chatMessage.messageFrom = SSChatMessageFromMe;
        chatMessage.backImgString = @"icon_qipao1";
        
        chatMessage.voiceImg = [UIImage imageNamed:@"chat_animation_white3"];
        chatMessage.voiceImgs =
        @[[UIImage imageNamed:@"chat_animation_white1"],
          [UIImage imageNamed:@"chat_animation_white2"],
          [UIImage imageNamed:@"chat_animation_white3"]];
    }else{
        chatMessage.messageFrom = SSChatMessageFromOther;
        chatMessage.backImgString = @"icon_qipao2";
        
        chatMessage.voiceImg = [UIImage imageNamed:@"chat_animation3"];
        chatMessage.voiceImgs =
        @[[UIImage imageNamed:@"chat_animation1"],
          [UIImage imageNamed:@"chat_animation2"],
          [UIImage imageNamed:@"chat_animation3"]];
    }
    
    switch (message.messageType) {
        case NIMMessageTypeText:{
            
            chatMessage.textColor   = SSChatTextColor;
            chatMessage.cellString  = SSChatTextCellId;
            chatMessage.messageType = SSChatMessageTypeText;
            chatMessage.textString  = message.text;
        }
            break;
        case NIMMessageTypeImage:{
            
            chatMessage.cellString =  SSChatImageCellId;
            chatMessage.messageType = SSChatMessageTypeImage;
            chatMessage.imageObject = (NIMImageObject *)message.messageObject;
        }
            break;
        case NIMMessageTypeAudio:{
            
            chatMessage.cellString =  SSChatVoiceCellId;
            chatMessage.messageType = SSChatMessageTypeVoice;
            chatMessage.audioObject = (NIMAudioObject *)message.messageObject;
        }
            break;
        case NIMMessageTypeVideo:{
            
            chatMessage.cellString =  SSChatVideoCellId;
            chatMessage.messageType = SSChatMessageTypeVideo;
            chatMessage.videoObject = (NIMVideoObject *)message.messageObject;
        }
            break;
        case NIMMessageTypeLocation:{
            
            chatMessage.cellString =  SSChatMapCellId;
            chatMessage.messageType = SSChatMessageTypeLocation;
            chatMessage.locationObject = (NIMLocationObject *)message.messageObject;
        }
            break;
        case NIMMessageTypeNotification:{
            
            chatMessage.textColor   = SSChatTextColor;
            chatMessage.cellString  =  SSChatNotiCellId;
            chatMessage.messageType = SSChatMessageTypeNotification;
//            chatMessage.notiObject  = (NIMNotificationObject *)message.messageObject;
//
            chatMessage.textString = @"NIMMessageTypeNotification";
            
            chatMessage.textColor   = SSChatTextColor;
        }
            break;
            
        case NIMMessageTypeFile:{
            chatMessage.cellString =  SSChatFileCellId;
            chatMessage.messageType = SSChatMessageTypeFile;
            chatMessage.textString = @"NIMMessageTypeFile";
            chatMessage.fileObject = (NIMFileObject *)message.messageObject;
            chatMessage.textColor   = SSChatTextColor;
            
        }
            break;
        case NIMMessageTypeTip:{
            
            chatMessage.cellString =  SSChatFileCellId;
            chatMessage.messageType = SSChatMessageTypeCustom;
            chatMessage.textString = @"NIMMessageTypeTip";
            
            chatMessage.textColor   = SSChatTextColor;
        }
            break;
        case NIMMessageTypeCustom:{
            chatMessage.cellString =  SSChatFileCellId;
            chatMessage.messageType = SSChatMessageTypeTypeTip;
            chatMessage.textString = @"NIMMessageTypeCustom";
            
            chatMessage.textColor   = SSChatTextColor;
        }
            break;
            
        default:{
            cout(@"未处理类型");
            cout(@(message.messageType));
        }
            break;
    }
    
    return chatMessage;
}




@end
