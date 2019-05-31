//
//  ContactChoiceFriendsController.h
//  SSChat
//
//  Created by soldoros on 2019/5/31.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "BaseTableViewGroupedController.h"

typedef void (^ContactChoiceFriendsHandle)(NSArray *userIds,NSString *name);

@interface ContactChoiceFriendsController : BaseTableViewGroupedController

@property(nonatomic,copy)ContactChoiceFriendsHandle handle;

@end


