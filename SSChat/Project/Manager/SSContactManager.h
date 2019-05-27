//
//  SSContactManager.h
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

/*
 处理好友获取群组的请求、删除、移除、同意等消息，并做数据持久化
 */
#import <Foundation/Foundation.h>


/**
 好友群组请求类型
 
 - SSContactTypeContact: 好友请求
 - SSContactTypeGroupInvite: 群组邀请
 - SSContactTypeGroupJoin: 加入群组
 */
typedef NS_ENUM(NSInteger,SSContactType) {
    SSContactTypeContact = 0,
    SSContactTypeGroupInvite,
    SSContactTypeGroupJoin,
};


/**
 请求消息通知处理的状态
 
 - SSContactStatusDefault: 默认不处理
 - SSContactStatusAgreed: 同意
 - SSContactStatusDeclined: 拒绝
 - SSContactStatusExpired: 消息过期
 */
typedef NS_ENUM(NSInteger,SSContactStatus) {
    SSContactStatusDefault = 1,
    SSContactStatusAgreed,
    SSContactStatusDeclined,
    SSContactStatusExpired,
};



/**
 好友或群组消息的对象归档(好友申请，群组邀请，聊天室邀请...)
 */

@interface SSContactModel : NSObject<NSCoding>

@property (nonatomic, assign) SSContactType type;
@property (nonatomic, assign) SSContactStatus status;

@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *receiver;

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) BOOL isRead;

@end



/**
 好友群组消息管理器
 */
@interface SSContactManager : NSObject

+(instancetype)shareSSContactManager;

//解档
-(void)readLocalDatas;
//归档
-(void)saveLocalDatas;

//设置全部已读
-(void)setAllRead;

//刷新tabBarItem
-(void)updateUnreadMessageCount;

//文件路径 时间 模型数组 未读数量
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableArray *modelList;
@property (nonatomic, assign) NSInteger unreadCount;

@end




