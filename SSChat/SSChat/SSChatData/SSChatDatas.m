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


//设置已读
-(void)setReadWithUsername:(NSString *)username type:(SSChatConversationType )type messageId:(NSString *)messageId{
    
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:username type:type createIfNotExist:YES];
    
    //    [conversation markAllMessagesAsRead:nil];
    [conversation markMessageAsReadWithId:messageId error:nil];
    
}



//将环信的消息模型转换成本地模型
-(SSChatMessage *)getModelWithMessage:(EMMessage *)message{
    
    SSChatMessage *model = [SSChatMessage new];
    model.conversationId = message.messageId;
    model.timestamp = message.timestamp;
    [self dealTimeWithMessageModel:model];
    
    if(message.direction == EMMessageDirectionSend){
        model.messageFrom = SSChatMessageFromMe;
        model.backImgString = @"icon_qipao1";
        
        model.voiceImg = [UIImage imageNamed:@"chat_animation_white3"];
        model.voiceImgs =
        @[[UIImage imageNamed:@"chat_animation_white1"],
          [UIImage imageNamed:@"chat_animation_white2"],
          [UIImage imageNamed:@"chat_animation_white3"]];
    }
    else{
        model.messageFrom = SSChatMessageFromOther;
        model.backImgString = @"icon_qipao2";
        
        model.voiceImg = [UIImage imageNamed:@"chat_animation3"];
        model.voiceImgs =
        @[[UIImage imageNamed:@"chat_animation1"],
          [UIImage imageNamed:@"chat_animation2"],
          [UIImage imageNamed:@"chat_animation3"]];
    }
    
    model.message = message;
    
    EMMessageBody *msgBody = message.body;
    
    //其他消息
    switch (msgBody.type) {
        case EMMessageBodyTypeText:{

            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            
            model.textColor   = SSChatTextColor;
            model.cellString  =  SSChatTextCellId;
            model.messageType = SSChatMessageTypeText;
            model.textString  = textBody.text;
            
        }
            break;
        case EMMessageBodyTypeImage:{
            
            model.cellString =  SSChatImageCellId;
            model.messageType = SSChatMessageTypeImage;
            model.imageBody = (EMImageMessageBody *)message.body;
        }
            break;
        case EMMessageBodyTypeLocation:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
            
            model.cellString =  SSChatMapCellId;
        }
            break;
        case EMMessageBodyTypeVoice:        {

            model.voiceBody = (EMVoiceMessageBody *)msgBody;
            model.messageType = SSChatMessageTypeVoice;
            model.cellString =  SSChatVoiceCellId;
        }
            break;
        case EMMessageBodyTypeVideo:{
            
            model.messageType = SSChatMessageTypeVideo;
            model.cellString =  SSChatVideoCellId;
            model.videoBody = (EMVideoMessageBody *)msgBody;
            
        }
            break;
        case EMMessageBodyTypeFile:
        {
            EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
            NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
            NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"文件的secret -- %@"        ,body.secretKey);
            NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
            
            model.cellString =  SSChatVoiceCellId;
        }
            break;
            
        default:
            break;
    }
    
    return model;
}



//将环信模型转换成 SSChatMessagelLayout
-(SSChatMessagelLayout *)getLayoutWithMessage:(EMMessage *)message{
    
    SSChatMessage *chatMessage = [self getModelWithMessage:message];
    return [[SSChatMessagelLayout alloc]initWithMessage:chatMessage];
}


//加载所有的消息并转换成layout数组
-(NSMutableArray *)getLayoutsWithMessages:(NSArray *)aMessages conversationId:(NSString *)conversationId{
    
    NSMutableArray *array = [NSMutableArray new];
    for(EMMessage *message in aMessages){
        if([message.conversationId isEqualToString:conversationId]){
            SSChatMessagelLayout *layout = [self getLayoutWithMessage:message];
            [array addObject:layout];
        }
    }
    return  array;
}


@end
