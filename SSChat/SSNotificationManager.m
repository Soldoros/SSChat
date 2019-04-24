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
        
        manager.notificationList = [[NSMutableArray alloc] init];
        manager.dateFormatter = [[NSDateFormatter alloc] init];
        [manager.dateFormatter setDateFormat:@"YYYY-MM-DD hh:mm"];
        manager.fileName = [NSString stringWithFormat:@"notificationCenter%@.data", [EMClient sharedClient].currentUsername];
        
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(receiveFriendRequest:) name:NotiGetAddContacts object:nil];
        
        [manager getLocalDatas];
    });
    return manager;
}


//收到好友请求回调 如果是相同的好友申请 则删除之前的 留最新的
- (void)receiveFriendRequest:(NSNotification *)noti{
    
    NSString *aUsername = noti.object[0];
    NSString *aMessage = noti.object[1];
    
    if ([aUsername length] == 0) return;
    if ([aMessage length] == 0) {
        aMessage = @"申请添加您为好友";
    }
    SSNotificationModel *aModel = [[SSNotificationModel alloc] init];
    aModel.sender = aUsername;
    aModel.message = aMessage;
    aModel.type = SSNotificationTypeContact;
    aModel.status = SSNotificationDefault;
    
    [self insertModel:aModel];
}

//如果是相同的好友申请 则删除之前的 留最新的
- (void)insertModel:(SSNotificationModel *)aModel{
    
    for (SSNotificationModel *model in _notificationList) {
        if (model.type == aModel.type &&
            model.status == aModel.status &&
            [model.sender isEqualToString:aModel.sender] &&
            [model.groupId isEqualToString:aModel.groupId]) {
            
            [manager.notificationList removeObject:model];
            break;
        }
    }
    
    NSString *time = [manager.dateFormatter stringFromDate:[NSDate date]];
    
    aModel.time = time;
    aModel.message = @"申请添加您为好友";
    aModel.isRead = NO;
    ++manager.unreadCount;
    
    [manager.notificationList insertObject:aModel atIndex:0];
    
    [self setLocalDatas];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiDataPersistence object:nil];
}



//解档读取数据 刷新tabBarItem
- (void)getLocalDatas{
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:manager.fileName];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    [manager.notificationList removeAllObjects];
    [manager.notificationList addObjectsFromArray:array];
    
    manager.unreadCount = 0;
    for (SSNotificationModel *model in manager.notificationList) {
        if (model.isRead == NO){
            ++ manager.unreadCount;
        }
    }
}

//归档保存数据 刷新tabBarItem
- (void)setLocalDatas{
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:manager.fileName];
    [NSKeyedArchiver archiveRootObject:manager.notificationList toFile:file];
    [self didNotificationsUnreadCountUpdate];
}

//设置全部已读并归档
- (void)setAllRead{
    
    for (SSNotificationModel *model in manager.notificationList) {
        model.isRead = YES;
    }
    manager.unreadCount = 0;
    [self setLocalDatas];
}

//消息未读展示红点
-(void)didNotificationsUnreadCountUpdate{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiUnreadCount object:makeStrWithInt(manager.unreadCount)];
    
    UITabBarController *tabBarController = (UITabBarController *)[AppDelegate sharedAppDelegate].window.rootViewController;
    UINavigationController *nav = tabBarController.viewControllers[1];
    if( manager.unreadCount>0){
        nav.tabBarItem.badgeValue = makeStrWithInt(manager.unreadCount);
    }else{
        nav.tabBarItem.badgeValue = nil;
    }
    
    
    NSInteger count = 0;
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];

    for(int i=0;i<conversations.count;++i){
        EMConversation *conv = conversations[i];
        count += conv.unreadMessagesCount;
    }
    
    UINavigationController *nav2 = tabBarController.viewControllers[0];
    if(count>0){
        nav2.tabBarItem.badgeValue = makeStrWithInt(count);
    }else{
        nav2.tabBarItem.badgeValue = nil;
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = count + manager.unreadCount;
    
}


@end

