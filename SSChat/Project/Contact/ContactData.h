//
//  ContactData.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 消息通知处理的状态
 
 - SSNotificationDefault: 默认不处理
 - SSNotificationAgreed: 同意
 - SSNotificationDeclined: 拒绝
 - SSNotificationExpired: 消息过期
 */
typedef NS_ENUM(NSInteger,SSNotificationStatus) {
    SSNotificationDefault = 0,
    SSNotificationAgreed,
    SSNotificationDeclined,
    SSNotificationExpired,
};
