//
//  ContactChoiceFriendsController.h
//  SSChat
//
//  Created by soldoros on 2019/5/31.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "BaseTableViewGroupedController.h"

typedef void (^ContactChoiceFriendsHandle)(NSArray *userIds,NSString *name, NIMTeamType type);

@interface ContactChoiceFriendsController : BaseTableViewGroupedController

@property(nonatomic,assign)NIMTeamType type;

@property(nonatomic,copy)ContactChoiceFriendsHandle handle;

@end


