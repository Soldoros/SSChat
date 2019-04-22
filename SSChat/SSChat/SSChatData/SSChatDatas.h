//
//  SSChatDatas.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSChatMessagelLayout.h"


@interface SSChatDatas : NSObject




/**
 发送消息或者接受消息的时间 初始化-1 代表直接显示时间
 往后超过或等于5分钟就显示见识
 */
@property(nonatomic,assign)NSTimeInterval timelInterval;


/**
 环信消息转本地模型
 
 @param message 传入环信消息
 @return 转换模型
 */
-(SSChatMessage *)getModelWithMessage:(EMMessage *)message;




/**
 将环信消息模型转换成 SSChatMessagelLayout

 @param message 传入环信消息
 @return 返回 SSChatMessagelLayout
 */
-(SSChatMessagelLayout *)getLayoutWithMessage:(EMMessage *)message;


/**
 加载所有的消息并转换成layout数组
 
 @param aMessages 传入获取的会话消息数组
 @param conversationId 检测是否是当前会话id的数据
 @return 返回layout数组
 */
-(NSMutableArray *)getLayoutsWithMessages:(NSArray *)aMessages conversationId:(NSString *)conversationId;



/**
 消息发送进度回调

 @param progress 进度
 */
typedef void (^Progress)(int progress);


/**
 发送消息结果回调

 @param layout 消息体
 @param error 发送失败和失败的原因
 */
typedef void (^Completion)(SSChatMessagelLayout *layout, EMError *error);



/**
 发送消息

 @param conversationId 会话id 也是消息发送者
 @param receiver 消息接受者
 @param messageBody 消息体
 @param ext 附件
 @param progress 消息发送进度
 @param completion 消息发送结果
 */
-(void)sendMessage:(NSString *)conversationId receiver:(NSString *)receiver messageBody:(EMMessageBody *)messageBody ext:(NSDictionary *)ext progress:(Progress)progress completion:(Completion)completion;


@end
