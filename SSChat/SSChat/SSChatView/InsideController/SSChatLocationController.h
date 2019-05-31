//
//  SSChatLocationController.h
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseController.h"

typedef void (^SSChatLocationBlock)(NSDictionary *locationDic, NSError *error);

@interface SSChatLocationController : BaseController

@property(nonatomic,copy)SSChatLocationBlock locationBlock;


@end


