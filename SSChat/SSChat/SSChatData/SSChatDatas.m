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
        model.headerImgurl = @"";
    }
    else{
        model.messageFrom = SSChatMessageFromOther;
        model.backImgString = @"icon_qipao2";
        model.headerImgurl = @"";
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
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            
            model.cellString =  SSChatImageCellId;
            model.messageType = SSChatMessageTypeImage;
            //大图路径
            model.remotePath = body.remotePath;
            model.localPath = body.localPath;
            //下载之后生成
            model.secretKey = body.secretKey;
            model.sizeWidth = body.size.width;
            model.sizeHeight = body.size.height;
            model.downloadStatus = body.downloadStatus;
            //缩略图自动生成
            model.thumbnailRemotePath = body.thumbnailRemotePath;
            model.thumbnailLocalPath = body.thumbnailLocalPath;
            model.thumbnailSecretKey = body.thumbnailSecretKey;
            model.thumbSizeWidth = body.thumbnailSize.width;
            model.thumbSizeHeight = body.thumbnailSize.height;
            model.thumbnailDownloadStatus = body.thumbnailDownloadStatus;
            
            cout(model.remotePath);
            cout(model.localPath);
            cout(model.secretKey);
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
            // 音频sdk会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
            NSLog(@"音频的secret -- %@"        ,body.secretKey);
            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
            NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
            
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
-(NSMutableArray *)getLayoutsWithMessages:(NSArray *)aMessages{
    
    NSMutableArray *array = [NSMutableArray new];
    for(EMMessage *message in aMessages){
        SSChatMessagelLayout *layout = [self getLayoutWithMessage:message];
        [array addObject:layout];
    }
    return  array;
}


@end
