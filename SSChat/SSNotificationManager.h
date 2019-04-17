//
//  SSNotificationManager.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 消息通知的类型
 
 - SSNotificationTypeContact: 好友请求
 - SSNotificationTypeGroupInvite: 群组邀请
 - SSNotificationTypeGroupJoin: 加入群组
 */
typedef NS_ENUM(NSInteger,SSNotificationType) {
    SSNotificationTypeContact = 0,
    SSNotificationTypeGroupInvite,
    SSNotificationTypeGroupJoin,
};


/**
 消息通知处理的状态
 
 - SSNotificationDefault: 默认不处理
 - SSNotificationAgreed: 同意
 - SSNotificationDeclined: 拒绝
 - SSNotificationExpired: 消息过期
 */
typedef NS_ENUM(NSInteger,SSNotificationStatus) {
    SSNotificationDefault = 1,
    SSNotificationAgreed,
    SSNotificationDeclined,
    SSNotificationExpired,
};


/**
 聊天中消息和通知的对象归档(好友申请，群组邀请，聊天室邀请...)
 */

@interface SSNotificationModel : NSObject<NSCoding>

@property (nonatomic, assign) SSNotificationType type;
@property (nonatomic, assign) SSNotificationStatus status;

@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *receiver;

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *time;
@property (nonatomic) BOOL isRead;

@end



/**
 消息通知中心 好友添加 群组邀请 聊天室邀请 群组加入
 */
@interface SSNotificationManager : NSObject

+(instancetype)shareSSNotificationManager;

//数据持久化——归档
- (void)dataLocalPersistence;

//全部已读
- (void)markAllAsRead;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSMutableArray *notificationList;

@property (nonatomic, assign) BOOL isCheckUnreadCount;
@property (nonatomic, assign) NSInteger unreadCount;


@end

