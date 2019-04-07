//
//  SSChatDatas.m
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import "SSChatDatas.h"


#define headerImg1  @"http://www.120ask.com/static/upload/clinic/article/org/201311/201311061651418413.jpg"
#define headerImg2  @"http://www.qqzhi.com/uploadpic/2014-09-14/004638238.jpg"
#define headerImg3  @"http://e.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d3b104443639f33a87e950b1b0.jpg"

@implementation SSChatDatas

//获取单聊的初始会话 数据均该由服务器处理生成 这里demo写死
+(NSMutableArray *)LoadingMessagesStartWithChat:(NSString *)sessionId{
    
    
    NSDictionary *dic1 = @{@"text":@"王医生你好，我最近老是感到头晕乏力，是什么原因造成的呢",
                           @"date":@"2018-10-10 09:20:15",
                           @"from":@"1",
                           @"messageId":@"20181010092015",
                           @"type":@"1",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg1
                           };
    NSDictionary *dic2 = @{@"text":@"您好，可以给我发送一份你的体检报告吗？便于我了解情况,随时给我打电话13540033103",
                           @"date":@"2018-10-10 09:22:15",
                           @"from":@"2",
                           @"messageId":@"20181010092515",
                           @"type":@"1",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg2
                           };
    NSDictionary *dic3 = @{@"text":@"好的，我已经发到您的邮箱了。我的邮箱也发给你76811172@qq.com",
                           @"date":@"2018-10-10 09:24:15",
                           @"from":@"1",
                           @"messageId":@"20181010092715",
                           @"type":@"1",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg1
                           };
    NSDictionary *dic4 = @{@"date":@"2018-11-09 09:14:26",
                           @"from":@"1",
                           @"messageId":@"20181109091426",
                           @"type":@"2",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg1,
                           @"image":[UIImage imageNamed:@"image1.JPEG"]
                           };

    NSDictionary *dic5 = @{@"date":@"2018-11-09 09:15:26",
                           @"from":@"1",
                           @"messageId":@"20181109091427",
                           @"type":@"3",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg2,
                           @"imageLocalPath":[[NSBundle mainBundle] URLForResource:@"image101" withExtension:@"gif"]
                           };
    NSDictionary *dic6 = @{@"text":@"恩，这是我的语音消息，请查收！我们的网址www.baidu.com",
                           @"date":@"2018-10-10 10:33:15",
                           @"from":@"2",
                           @"messageId":@"20181010102015",
                           @"type":@"1",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg2
                           };
    NSDictionary *dic7 = @{@"date":@"2018-11-09 11:14:26",
                           @"from":@"1",
                           @"messageId":@"20181109091424",
                           @"type":@"2",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg1,
                           @"image":[UIImage imageNamed:@"image3.JPEG"]
                           };
    NSDictionary *dic8 = @{@"date":@"2018-11-09 11:19:26",
                           @"from":@"1",
                           @"messageId":@"20181109091421",
                           @"type":@"2",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg1,
                           @"image":[UIImage imageNamed:@"image4.JPEG"]
                           };
    NSDictionary *dic9 = @{@"date":@"2018-11-09 11:19:26",
                           @"from":@"1",
                           @"messageId":@"20181109091421",
                           @"type":@"6",
                           @"sessionId":sessionId,
                           @"headerImg":headerImg1,
                           @"videoLocalPath":[[NSBundle mainBundle] pathForResource:@"chengdu"ofType:@"mp4"]
                           };
    
    NSMutableArray *messages = [NSMutableArray new];
    [messages addObjectsFromArray: @[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9]];
    
    return [SSChatDatas receiveMessages:messages];
    
}



//获取群聊的初始会话
+(NSMutableArray *)LoadingMessagesStartWithGroupChat:(NSString *)sessionId{
    
    return nil;
}


//处理接收的消息数组
+(NSMutableArray *)receiveMessages:(NSArray *)messages{
    
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dic in messages){
        SSChatMessagelLayout *layout = [SSChatDatas getMessageWithDic:dic];
        [array addObject:layout];
    }
    return array;
}

//接受一条消息
+(SSChatMessagelLayout *)receiveMessage:(NSDictionary *)dic{
    return [SSChatDatas getMessageWithDic:dic];
}

//消息内容生成消息模型
+(SSChatMessagelLayout *)getMessageWithDic:(NSDictionary *)dic{
    
    SSChatMessage *message = [SSChatMessage new];
   
    SSChatMessageType messageType = (SSChatMessageType)[dic[@"type"]integerValue];
    SSChatMessageFrom messageFrom = (SSChatMessageFrom)[dic[@"from"]integerValue];
    
    if(messageFrom == SSChatMessageFromMe){
        message.messageFrom = SSChatMessageFromMe;
        message.backImgString = @"icon_qipao1";
    }else{
        message.messageFrom = SSChatMessageFromOther;
        message.backImgString = @"icon_qipao2";
    }
    
    
    message.sessionId    = dic[@"sessionId"];
    message.sendError    = NO;
    message.headerImgurl = dic[@"headerImg"];
    message.messageId    = dic[@"messageId"];
    message.textColor    = SSChatTextColor;
    message.messageType  = messageType;
    
    
    //判断时间是否展示
    message.messageTime = [NSTimer getChatTimeStr2:[NSTimer getStampWithTime:dic[@"date"]]];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user valueForKey:message.sessionId]==nil){
        [user setValue:dic[@"date"] forKey:message.sessionId];
        message.showTime = YES;
    }else{
        [message showTimeWithLastShowTime:[user valueForKey:message.sessionId] currentTime:dic[@"date"]];
        if(message.showTime){
            [user setValue:dic[@"date"] forKey:message.sessionId];
        }
    }

    //判断消息类型 文本消息生成的时候直接生成了可变文本
    if(message.messageType == SSChatMessageTypeText){
        
        message.cellString   = SSChatTextCellId;
        message.textString = dic[@"text"];
        
    }else if (message.messageType == SSChatMessageTypeImage){
        message.cellString   = SSChatImageCellId;
        
        if([dic[@"image"] isKindOfClass:NSClassFromString(@"NSString")]){
            message.image = [UIImage imageNamed:dic[@"image"]];
        }else{
            message.image = dic[@"image"];
        }
    }else if(message.messageType == SSChatMessageTypeGif){
        message.cellString   = SSChatImageCellId;
        message.imageLocalPath = dic[@"imageLocalPath"];
        message.imageArr = [UIImage getImagesWithGif:dic[@"imageLocalPath"]];
        message.image = message.imageArr[0];
        NSLog(@"%@",message.imageArr);
    }else if (message.messageType == SSChatMessageTypeVoice){
        
        message.cellString   = SSChatVoiceCellId;
        message.voice = dic[@"voice"];
        message.voiceDuration = [dic[@"second"]integerValue];
        message.voiceTime = [NSString stringWithFormat:@"%@'s ",dic[@"second"]];

        message.voiceImg = [UIImage imageNamed:@"chat_animation_white3"];
        message.voiceImgs =
        @[[UIImage imageNamed:@"chat_animation_white1"],
          [UIImage imageNamed:@"chat_animation_white2"],
          [UIImage imageNamed:@"chat_animation_white3"]];
        
        if(messageFrom == SSChatMessageFromOther){

            message.voiceImg = [UIImage imageNamed:@"chat_animation3"];
            message.voiceImgs =
            @[[UIImage imageNamed:@"chat_animation1"],
              [UIImage imageNamed:@"chat_animation2"],
              [UIImage imageNamed:@"chat_animation3"]];
        }
        
    }else if (message.messageType == SSChatMessageTypeMap){
        message.cellString = SSChatMapCellId;
        message.latitude = [dic[@"lat"] doubleValue];
        message.longitude = [dic[@"lon"] doubleValue];
        message.addressString = dic[@"address"];
        
    }else if (message.messageType == SSChatMessageTypeVideo){
        message.cellString = SSChatVideoCellId;
        message.videoLocalPath = dic[@"videoLocalPath"];
        message.videoImage = [UIImage getImage:message.videoLocalPath];
    }
    
    SSChatMessagelLayout *layout = [[SSChatMessagelLayout alloc]initWithMessage:message];
    return layout;
    
}




//发送一条消息
+(void)sendMessage:(NSDictionary *)dict sessionId:(NSString *)sessionId messageType:(SSChatMessageType)messageType messageBlock:(MessageBlock)messageBlock{
   
    NSMutableDictionary *messageDic = [NSMutableDictionary dictionaryWithDictionary:dict];

    NSString *time = [NSTimer getLocationTime];
    NSString *messageId = [time stringByReplacingOccurrencesOfString:@" " withString:@""];
    messageId = [messageId stringByReplacingOccurrencesOfString:@"-" withString:@""];
    messageId = [messageId stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    
    switch (messageType) {
        case SSChatMessageTypeText:{
            [messageDic setObject:@"1" forKey:@"from"];
            [messageDic setValue:time forKey:@"date"];
            [messageDic setValue:@(messageType) forKey:@"type"];
            [messageDic setValue:messageId forKey:@"messageId"];
            [messageDic setValue:sessionId forKey:@"sessionId"];
            [messageDic setValue:headerImg1 forKey:@"headerImg"];
        }
            break;
        case SSChatMessageTypeImage:{
            [messageDic setObject:@"1" forKey:@"from"];
            [messageDic setValue:time forKey:@"date"];
            [messageDic setValue:@(messageType) forKey:@"type"];
            [messageDic setValue:messageId forKey:@"messageId"];
            [messageDic setValue:sessionId forKey:@"sessionId"];
            [messageDic setValue:headerImg1 forKey:@"headerImg"];
        }
            break;
        case SSChatMessageTypeGif:{
            [messageDic setObject:@"1" forKey:@"from"];
            [messageDic setValue:time forKey:@"date"];
            [messageDic setValue:@(messageType) forKey:@"type"];
            [messageDic setValue:messageId forKey:@"messageId"];
            [messageDic setValue:sessionId forKey:@"sessionId"];
            [messageDic setValue:headerImg1 forKey:@"headerImg"];
        }
            break;
        case SSChatMessageTypeVoice:{
            [messageDic setObject:@"1" forKey:@"from"];
            [messageDic setValue:time forKey:@"date"];
            [messageDic setValue:@(messageType) forKey:@"type"];
            [messageDic setValue:messageId forKey:@"messageId"];
            [messageDic setValue:sessionId forKey:@"sessionId"];
            [messageDic setValue:headerImg1 forKey:@"headerImg"];
        }
            break;
        case SSChatMessageTypeMap:{
            [messageDic setObject:@"1" forKey:@"from"];
            [messageDic setValue:time forKey:@"date"];
            [messageDic setValue:@(messageType) forKey:@"type"];
            [messageDic setValue:messageId forKey:@"messageId"];
            [messageDic setValue:sessionId forKey:@"sessionId"];
            [messageDic setValue:headerImg1 forKey:@"headerImg"];
        }
            break;
        case SSChatMessageTypeVideo:{
            [messageDic setObject:@"1" forKey:@"from"];
            [messageDic setValue:time forKey:@"date"];
            [messageDic setValue:@(messageType) forKey:@"type"];
            [messageDic setValue:messageId forKey:@"messageId"];
            [messageDic setValue:sessionId forKey:@"sessionId"];
            [messageDic setValue:headerImg1 forKey:@"headerImg"];
        }
            break;
        case SSChatMessageTypeRedEnvelope:{
            
        }
            break;
            
        default:
            break;
    }
    
    SSChatMessagelLayout *layout = [SSChatDatas getMessageWithDic:messageDic];
    NSProgress *pre = [[NSProgress alloc]init];
    
    messageBlock(layout,nil,pre);
}


@end
