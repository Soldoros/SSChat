//
//  SSChatLocationController.h
//  htcm1
//
//  Created by soldoros on 2018/5/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseController.h"


@protocol SSChatLocationControllerDelegate <NSObject>

-(void)SSChatLocationControllerSendLatitude:(double)latitude  longitude:(double)longitude address:(NSString *)address;

@end

@interface SSChatLocationController : BaseController

@property(nonatomic,assign)id<SSChatLocationControllerDelegate>delegate;

@end
