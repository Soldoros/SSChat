//
//  SSChatMessageController.h
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "BaseTableViewGroupedController.h"
@class SSChatMessage;

NS_ASSUME_NONNULL_BEGIN

@interface SSChatMessageController : BaseTableViewGroupedController

//发送消息
- (void)sendMessage:(SSChatMessage *)message;

//转发消息
- (void)forwardMessage:(SSChatMessage *)message;

//滚动至底部
- (void)scrollToBottom:(BOOL)animate;

//开启多选模式
- (void)enableMultiSelectedMode:(BOOL)enable;

//开启多选模式后，获取当前选中的结果
- (NSArray *)multiSelectedResult;

@end

NS_ASSUME_NONNULL_END
