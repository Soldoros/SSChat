//
//  SSNotificationManager.m
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSNotificationManager.h"


static  NSString *Noti_Sender   = @"sender";
static  NSString *Noti_Receiver = @"receiver";
static  NSString *Noti_GroupId  = @"groupId";
static  NSString *Noti_Message  = @"message";
static  NSString *Noti_Time     = @"time";
static  NSString *Noti_Status   = @"status";
static  NSString *Noti_Type     = @"type";
static  NSString *Noti_IsRead   = @"isRead";


//模型归档/解档
@implementation SSNotificationModel

-(instancetype)init{
    if(self = [super init]){
        _groupId = @"";
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        
        _sender = [aDecoder decodeObjectForKey:Noti_Sender];
        _receiver = [aDecoder decodeObjectForKey:Noti_Receiver];
        _groupId = [aDecoder decodeObjectForKey:Noti_GroupId];
        _message = [aDecoder decodeObjectForKey:Noti_Message];
        _time = [aDecoder decodeObjectForKey:Noti_Time];
        _status = [aDecoder decodeIntegerForKey:Noti_Status];
        _type = [aDecoder decodeIntegerForKey:Noti_Type];
        _isRead = [aDecoder decodeBoolForKey:Noti_IsRead];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_sender forKey:Noti_Sender];
    [aCoder encodeObject:_receiver forKey:Noti_Receiver];
    [aCoder encodeObject:_groupId forKey:Noti_GroupId];
    [aCoder encodeObject:_message forKey:Noti_Message];
    [aCoder encodeObject:_time forKey:Noti_Time];
    [aCoder encodeInteger:_status forKey:Noti_Status];
    [aCoder encodeInteger:_type forKey:Noti_Type];
    [aCoder encodeBool:_isRead forKey:Noti_IsRead];
}

@end


//消息通知中心 好友添加 群组邀请 聊天室邀请 群组加入
@implementation SSNotificationManager

static SSNotificationManager *manager = nil;

+(instancetype)shareSSNotificationManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SSNotificationManager alloc]init];
        
        manager.isCheckUnreadCount = YES;
        manager.notificationList = [[NSMutableArray alloc] init];
        manager.dateFormatter = [[NSDateFormatter alloc] init];
        [manager.dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm"];
        manager.fileName = [NSString stringWithFormat:@"notificationCenter%@.data", [EMClient sharedClient].currentUsername];
        
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(receiveFriendRequest:) name:NotiGetAddContacts object:nil];
        
        [manager getNotificationsFromLocal];
    });
    return manager;
}


//解档
- (void)getNotificationsFromLocal{
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:manager.fileName];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    [manager.notificationList removeAllObjects];
    [manager.notificationList addObjectsFromArray:array];
    
    manager.unreadCount = 0;
    for (SSNotificationModel *model in manager.notificationList) {
        if (!model.isRead) ++ manager.unreadCount;
        else continue;
    }
    
    if (manager.isCheckUnreadCount) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotiUnreadCount object:makeStrWithInt(manager.unreadCount)];
    }
}

//保存数据
- (void)dataLocalPersistence{
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:manager.fileName];
    [NSKeyedArchiver archiveRootObject:manager.notificationList toFile:file];
}

- (void)markAllAsRead{
    
    BOOL isArchive = NO;
    for (SSNotificationModel *model in manager.notificationList) {
        if (!model.isRead) {
            model.isRead = YES;
            isArchive = YES;
        }
    }
    
    if (isArchive) [self dataLocalPersistence];
    
    if (manager.unreadCount != 0) {
        
        manager.unreadCount = 0;
        if (manager.isCheckUnreadCount) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotiUnreadCount object:makeStrWithInt(0)];
        }
    }
}


//收到好友请求回调
- (void)receiveFriendRequest:(NSNotification *)noti{
    
    NSString *aUsername = noti.object[0];
    NSString *aMessage = noti.object[1];
    
    if ([aUsername length] == 0) return;
    if ([aMessage length] == 0) {
        aMessage = @"申请添加您为好友";
    }
    SSNotificationModel *model = [[SSNotificationModel alloc] init];
    model.sender = aUsername;
    model.message = aMessage;
    model.type = SSNotificationTypeContact;
    model.status = SSNotificationDefault;
    [self insertModel:model];
    
}

- (void)insertModel:(SSNotificationModel *)aModel{
    
    NSString *time = [manager.dateFormatter stringFromDate:[NSDate date]];
    
    for (SSNotificationModel *model in _notificationList) {
        if (model.type == aModel.type &&
            model.status == aModel.status &&
            [model.sender isEqualToString:aModel.sender] &&
            [model.groupId isEqualToString:aModel.groupId]) {
            
            [manager.notificationList removeObject:model];
            break;
        }
    }
    
    aModel.time = time;
    if ([aModel.message length] == 0) {
        if (aModel.type == SSNotificationTypeContact) {
            aModel.message = @"申请添加您为好友";
        }
    }
    
    if (!manager.isCheckUnreadCount) {
        aModel.isRead = YES;
    } else {
        ++manager.unreadCount;
        [[NSNotificationCenter defaultCenter] postNotificationName:NotiUnreadCount object:makeStrWithInt(manager.unreadCount)];
    }
    
    [manager.notificationList insertObject:aModel atIndex:0];
    [self dataLocalPersistence];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiDataPersistence object:nil];
}


@end

