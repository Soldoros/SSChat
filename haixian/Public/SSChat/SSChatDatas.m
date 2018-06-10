//
//  SSChatDatas.m
//  haixian

//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.



#import "SSChatDatas.h"


@implementation SSChatDatas


//用类名做cellid名称
+(NSArray *)getCells{
    return @[@"SSChatTimeCell",@"SSChatTextCell",
             @"SSChatImgCell",@"SSChatVoiceCell",
             @"SSChatMapCell",@"SSChatVideoCell",
             @"SSChatOrderValue1Cell",@"SSChatOrderValue2Cell",
             @"SSChatMessageCell"];
}

//将所有的回话中 最后一条消息取出来  顺便取出回话ID
+(NSMutableArray *)conversationsWith:(NSArray *)conversations{
    
    NSMutableArray *TwoDatas = [NSMutableArray new];
    for(EMConversation *con in conversations){
        EMMessage *msg = con.latestMessage;
        if(!msg)break;
        SSChatModel *md = [self getModelWithEMMessage:msg];
        md.conversationId = con.conversationId;
        md.messageTime = msg.timestamp;
        
        [TwoDatas addObject:md];
    }
    return TwoDatas;
}


//接受的消息如果是个数组 用循环来处理
+(NSMutableArray *)receiveMessages:(NSArray *)aMessages{
    
    NSMutableArray *messages = [NSMutableArray new];
    for (EMMessage *message in aMessages) {
        SSChatModel *md = [self receiveMessage:message];
        [messages addObject:md];
    }
    return messages;
}

//接受的消息如果是单个消息
+(SSChatModel *)receiveMessage:(EMMessage *)message{
    SSChatModel *model = [self getModelWithEMMessage:message];
    model.messageFrom = SSChatMessageFromOther;
    model.headerImg = makeImage(@"icon_kefu");
    model.imgString = @"xiaoxi_liaotian_duihuakuang2";
    model.textColor = [UIColor blackColor];
    return model;
}


//发送的消息
+(SSChatModel *)sendMessage:(EMMessage *)message{
    
    NSString *imgUrl = makeString(URLStr, [[NSUserDefaults standardUserDefaults] valueForKey:USER_Img]);
    
    SSChatModel *model = [self getModelWithEMMessage:message];
    model.messageFrom = SSChatMessageFromMe;
    model.headerImgurl = imgUrl;
    model.textColor = [UIColor blackColor];
    model.imgString = @"xiaoxi_liaotian_duihuakuang1";
    return model;
}


//本来环信的meessage是一个很好的模型  这里我们再转换成自己的模型 方便控制
//这样方便以后换成其他的sdk 也可以很快用自己的模型介入
+(SSChatModel *)getModelWithEMMessage:(EMMessage *)message{
    
    SSChatModel *model = [SSChatModel new];
    model.message = message;
    model.messageId = message.messageId;
    model.conversationId = message.messageId;
    model.messageTime = message.timestamp;
    model.showTime = NO;
    
    EMMessageBody *msgBody = message.body;
    
    //其他消息
    switch (msgBody.type) {
        case EMMessageBodyTypeText:{
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            model.textString = textBody.text;
            model.messageType = SSChatMessageTypeText;
        }
            break;
        case EMMessageBodyTypeImage:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath);
           
            model.imageUrl = body.remotePath;
            model.messageType = SSChatMessageTypeImage;
        }
            break;
        case EMMessageBodyTypeLocation:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
            model.latitude = body.latitude;
            model.longitude = body.longitude;
            model.addressString = body.address;
            model.messageType = SSChatMessageTypeMap;
        }
            break;
        case EMMessageBodyTypeVoice:
        {
            // 音频sdk会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath);
            
            model.duration = body.duration;
            model.localPath = body.localPath;
            model.remotePath = body.remotePath;
            model.messageType = SSChatMessageTypeVoice;
        }
            break;
        case EMMessageBodyTypeVideo:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"视频local路径 -- %@"       ,body.localPath);
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %d"   ,body.downloadStatus);
            NSLog(@"视频的时间长度 -- %d"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %d"      ,body.thumbnailDownloadStatus);
            
            model.thumbnailRemotePath = body.thumbnailRemotePath;
            model.thumbnailLocalPath = body.thumbnailLocalPath;
            model.videoRemotePath = body.remotePath;
            model.videoLocalPath = body.localPath;
            model.videodDration = body.duration;
            model.messageType = SSChatMessageTypeVideo;
            
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
        }
            break;
            
        default:
            break;
    }
    
    return model;
}


//设置已读
+(void)setReadWithUsername:(NSString *)username type:(SSChatConversationType )type messageId:(NSString *)messageId{
    
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:username type:(EMConversationType)type createIfNotExist:YES];
    [conversation markMessageAsReadWithId:messageId error:nil];

}



//时间处理 (第一次显示 以后每隔5分钟显示)
+(NSMutableArray *)arrayWithMessageArray:(NSMutableArray *)array{
    
    long long timestamp=0;
    
    NSMutableArray *datas = [NSMutableArray new];
    for(int i=0;i<array.count;++i){
        SSChatModel *model = (SSChatModel *)array[i];
        if(i==0){
            model.showTime = YES;
            timestamp = model.messageTime;
        }else{
            
            //通过毫秒来计算5分钟
            if(model.messageTime-timestamp>=5*60*1000){
                timestamp = model.messageTime;
                model.showTime = YES;
            }else{
                model.showTime = NO;
            }
        }
        
        SSChatModelLayout *yout = [[SSChatModelLayout alloc]initWithModel:model];
        [datas addObject:yout];
    }
    
    return datas;
}


//最新模型里面是否显示时间(需要传 yout数组)
+(SSChatModelLayout *)layoutWithMessageArray:(NSMutableArray *)array model:(SSChatModel *)model{
    
    for(int i=(int)array.count-1;i>=0;i--){
        SSChatModelLayout *yout = (SSChatModelLayout *)array[i];
        
        if(yout.model.showTime==YES){
            if(model.messageTime-yout.model.messageTime>=5*60*1000){
                model.showTime = YES;
            }
            else{
                model.showTime = NO;
            }
            break;
        }
        continue;
    }
    SSChatModelLayout *yout = [[SSChatModelLayout alloc]initWithModel:model];
    return yout;
}



//发送消息
+(void)sendMessage:(NSDictionary *)dict messageType:(SSChatMessageType)messageType progressBlock:(ProgressBlock)progressBlock messageBlock:(MessageBlock)messageBlock{
    
    NSString *_userName = dict[@"userName"];
    NSString *me = [[EMClient sharedClient] currentUsername];
    EMMessage *message;
    
    
    switch (messageType) {
            
            //发送文本消息
        case SSChatMessageTypeText:{
            NSString *string = dict[@"text"];
            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:string];
            message = [[EMMessage alloc] initWithConversationID:_userName from:me to:_userName body:body ext:nil];
            message.chatType = EMChatTypeChat;
        }
            break;
            
            //发送图片消息
        case SSChatMessageTypeImage:{
            UIImage *theImage = dict[@"img"];
            NSData *data=UIImageJPEGRepresentation(theImage, 0.5);
            
            EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"image.png"];
            body.compressionRatio = 0.6f;
            message=[[EMMessage alloc]initWithConversationID:_userName from:me to:_userName body:body ext:nil];
            message.chatType=EMChatTypeChat;
        }
            break;
            
            //发送语音消息
        case SSChatMessageTypeVoice:{
            NSData *voice = dict[@"voice"];
            NSInteger second = [dict[@"second"]integerValue];
            EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithData:voice displayName:@"voice"];
            body.duration = (int)second;
            
            message = [[EMMessage alloc] initWithConversationID:_userName from:me to:_userName body:body ext:nil];
            message.chatType = EMChatTypeChat;
        }
            break;
            
            //发送地图消息
        case SSChatMessageTypeMap:{
 
            double latitude = [dict[@"latitude"]doubleValue];
            double longitude = [dict[@"longitude"]doubleValue];
            NSString *address = dict[@"address"];

            EMLocationMessageBody *body = [[EMLocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:address];
            
            message = [[EMMessage alloc] initWithConversationID:_userName from:me to:_userName body:body ext:nil];
            message.chatType = EMChatTypeChat;
        }
            break;
            
            //发送视频消息
        case SSChatMessageTypeVideo:{
            
            NSString *videoPath = dict[@"video"];
            EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithLocalPath:videoPath displayName:@"xxx.mp4"];
            
            message = [[EMMessage alloc] initWithConversationID:_userName from:me to:_userName body:body ext:nil];
            message.chatType = EMChatTypeChat;
        }
            break;
            
        default:
            break;
    }
    

    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        progressBlock(progress);
    } completion:^(EMMessage *message, EMError *error) {
        
            messageBlock(message,error);
        
    }];
    
}





@end
