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
 通过会话和消息获取昵称/聊天室名/群组名

 @param session 传入会话
 @param message 传入消息
 @return 返回名称
 */
+(NSString *)showNicknameWithSession:(NIMSession *)session message:(NIMMessage *)message;


/**
 通过会话和消息返回头像
 
 @param session 传入会话
 @return 返回名称
 */
+(NSString *)showHeaderImgWithSession:(NIMSession *)session;



/**
 根据会话返回昵称/群组名

 @param session 传入会话
 @return 返回名称
 */
+(NSString *)getNavagationTitle:(NIMSession *)session;


/**
 消息设置已读

 @param message 消息
 @param type 会话类型
 */
-(void)setMessagesAsReadWithMessage:(NIMMessage *)message type:(NSInteger)type;



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
-(SSChatMessage *)getModelWithMessage:(NIMMessage *)message;




/**
 将环信消息模型转换成 SSChatMessagelLayout

 @param message 传入环信消息
 @return 返回 SSChatMessagelLayout
 */
-(SSChatMessagelLayout *)getLayoutWithMessage:(NIMMessage *)message;


/**
 加载所有的消息并转换成layout数组
 
 @param aMessages 传入获取的会话消息数组
 @param sessionId 检测是否是当前会话id的数据
 @return 返回layout数组
 */
-(NSMutableArray *)getLayoutsWithMessages:(NSArray *)aMessages sessionId:(NSString *)sessionId;



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
typedef void (^Completion)(SSChatMessagelLayout *layout, NSError *error);



/**
 发送消息

 @param sessionId 会话id 也是消息发送者
 @param receiver 消息接受者
 @param messageBody 消息体
 @param ext 附件
 @param progress 消息发送进度
 @param completion 消息发送结果
 */
-(void)sendMessage:(NSString *)sessionId receiver:(NSString *)receiver messageBody:(NIMMessage *)messageBody ext:(NSDictionary *)ext progress:(Progress)progress completion:(Completion)completion;


@end
