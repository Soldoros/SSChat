//
//  SSContactManager.m
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSContactManager.h"
#import "SSDocumentManager.h"


static  NSString *Model_Sender   = @"sender";
static  NSString *Model_Receiver = @"receiver";
static  NSString *Model_GroupId  = @"groupId";
static  NSString *Model_Message  = @"message";
static  NSString *Model_Time     = @"time";
static  NSString *Model_Status   = @"status";
static  NSString *Model_Type     = @"type";
static  NSString *Model_IsRead   = @"isRead";


@implementation SSContactModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
    [aCoder encodeObject:_sender forKey:Model_Sender];
    [aCoder encodeObject:_receiver forKey:Model_Receiver];
    [aCoder encodeObject:_groupId forKey:Model_GroupId];
    [aCoder encodeObject:_message forKey:Model_Message];
    [aCoder encodeObject:_time forKey:Model_Time];
    [aCoder encodeInteger:_status forKey:Model_Status];
    [aCoder encodeInteger:_type forKey:Model_Type];
    [aCoder encodeBool:_isRead forKey:Model_IsRead];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if(self = [super init]){
        
        _sender   = [aDecoder decodeObjectForKey:Model_Sender];
        _receiver = [aDecoder decodeObjectForKey:Model_Receiver];
        _groupId  = [aDecoder decodeObjectForKey:Model_GroupId];
        _message  = [aDecoder decodeObjectForKey:Model_Message];
        _time     = [aDecoder decodeObjectForKey:Model_Time];
        _status   = [aDecoder decodeIntegerForKey:Model_Status];
        _type     = [aDecoder decodeIntegerForKey:Model_Type];
        _isRead   = [aDecoder decodeBoolForKey:Model_IsRead];
    }
    return self;
}

@end



/**
 好友群组消息管理器
 */
@implementation SSContactManager

static SSContactManager *manager = nil;

+ (instancetype)shareSSContactManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SSContactManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _modelList = [[NSMutableArray alloc] init];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        _filePath = [[SSDocumentManager getUserDocumentPath] stringByAppendingPathComponent:@"contact_message_data"];
        
        [self readLocalDatas];
    }
    return self;
}


- (void)readLocalDatas{
    
}

- (void)saveLocalDatas{
    
}

- (void)setAllRead{
    
}

//刷新tabBarItem
-(void)updateUnreadMessageCount{
    
}

@end
