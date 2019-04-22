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
    
    
    EMMessageBody *msgBody = message.body;
    
    //其他消息
    switch (msgBody.type) {
        case EMMessageBodyTypeText:{
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            
            model.textColor   = SSChatTextColor;
            model.cellString  =  SSChatTextCellId;
            model.messageType = SSChatMessageTypeText;
            model.textString  = textBody.text;
            
        }
            break;
        case EMMessageBodyTypeImage:
        {
            
            model.cellString =  SSChatImageCellId;
            model.messageType = SSChatMessageTypeImage;
            model.imageBody = (EMImageMessageBody *)message.body;
          
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"大图的secret -- %@"    ,body.secretKey);
            NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
            NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
            
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,小图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);

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
        case EMMessageBodyTypeVoice:
        {
//            // 音频sdk会自动下载
//            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
//            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
//            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
//            NSLog(@"音频的secret -- %@"        ,body.secretKey);
//            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
//            NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
//            NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
            model.voiceBody = (EMVoiceMessageBody *)msgBody;
            model.messageType = SSChatMessageTypeVoice;
            model.cellString =  SSChatVoiceCellId;
        }
            break;
        case EMMessageBodyTypeVideo:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
            NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
            
            model.cellString =  SSChatVoiceCellId;
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
