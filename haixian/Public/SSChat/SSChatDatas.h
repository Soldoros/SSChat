//
//  SSChatDatas.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSChatModel.h"
#import "SSChatModelLayout.h"

@interface SSChatDatas : NSObject

@property(nonatomic,strong) SSChatModel *model;

+(NSArray *)getCells;

//聊天对象
@property (strong, nonatomic) NSString *userName;
//聊天类型
@property (assign, nonatomic) SSChatConversationType conversationType;

+(void)setReadWithUsername:(NSString *)username type:(SSChatConversationType )type messageId:(NSString *)messageId;

//消息列表的数据处理
+(NSMutableArray *)conversationsWith:(NSArray *)conversations;

//聊天列表的数据处理
+(NSMutableArray *)receiveMessages:(NSArray *)aMessages;
+(SSChatModel *)receiveMessage:(EMMessage *)message;
+(SSChatModel *)sendMessage:(EMMessage *)message;

//时间处理
+(NSMutableArray *)arrayWithMessageArray:(NSMutableArray *)array;

//最新模型里面是否显示时间(需要传 yout数组)
+(SSChatModelLayout *)layoutWithMessageArray:(NSMutableArray *)array model:(SSChatModel *)model;




/**
 发送消息的回调代码块

 @param message 发送的消息
 @param error 发送失败还是成功
 */
typedef void (^MessageBlock)(EMMessage *message, EMError *error);


/**
 发送消息的进度回调

 @param progress 进度
 */
typedef void (^ProgressBlock)(int progress);


/**
 发送消息

 @param dict 发送消息的内容
 @param messageType 发送消息的类型
 @param messageBlock 发送消息后回调的代码块
 */
+(void)sendMessage:(NSDictionary *)dict messageType:(SSChatMessageType)messageType progressBlock:(ProgressBlock)progressBlock messageBlock:(MessageBlock)messageBlock;






@end
