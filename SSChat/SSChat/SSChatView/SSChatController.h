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
//会话id
@property (nonatomic, strong) NSString    *sessionId;

//名字
@property (nonatomic, strong) NSString    *titleString;

@end
