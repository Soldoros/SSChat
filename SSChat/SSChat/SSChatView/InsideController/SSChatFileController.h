//
//  SSChatFileController.h
//  SSChat
//
//  Created by soldoros on 2019/5/30.
//  Copyright © 2019 soldoros. All rights reserved.
//

//需要传输的文件列表
#import "BaseTableViewGroupedController.h"

typedef void (^SSChatFileHandle)(NSDictionary *dict, id object);

@interface SSChatFileController : BaseTableViewGroupedController

@property(nonatomic, copy)SSChatFileHandle handle;

@end


