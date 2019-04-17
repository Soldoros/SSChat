//
//  SSHelloManager.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  HelloAppKey         @"soldoros#hello"
#define  HelloClientID       @"YXA6deff8P67EeibxQVRc16l-Q"
#define  HelloClientSecret   @"YXA6OnhzjgmOdvqHv2AqBI-SqAUNgqU"

@interface SSHelloManager : NSObject<EMChatManagerDelegate,EMContactManagerDelegate,EMClientDelegate>

+(SSHelloManager *)shareHelloManager;

@end


