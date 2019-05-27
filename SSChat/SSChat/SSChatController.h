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

//支持P2P、Team和Chatroom
@property (nonatomic, strong)  NIMSession *session;

@end
