//
//  SSHelloManagement.h
//  SSChat
//
//  Created by soldoros on 2019/4/13.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  HelloAppKey         @"soldoros#hello"
#define  HelloClientID       @"YXA6deff8P67EeibxQVRc16l-Q"
#define  HelloClientSecret   @"YXA6OnhzjgmOdvqHv2AqBI-SqAUNgqU"

@interface SSHelloManagement : NSObject<EMChatManagerDelegate,EMContactManagerDelegate,EMClientDelegate>

+(SSHelloManagement *)shareHelloManagement;

@end

