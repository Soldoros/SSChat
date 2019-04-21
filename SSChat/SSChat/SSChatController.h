//
//  SSChatController.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSChatMessagelLayout.h"
#import "SSChatViews.h"

@interface SSChatController : UIViewController

//单聊 群聊
@property(nonatomic,assign)SSChatConversationType chatType;

//环信会话
@property(nonatomic,strong)EMConversation *conversation;

@end
