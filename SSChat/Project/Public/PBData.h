//
//  PBData.h
//  SSChat
//
//  Created by soldoros on 2019/6/5.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 编辑相关字段
 
 - PBEditTypeNikckname: 昵称
 - PBEditTypeNote: 备注
 - PBEditTypeSignature: 签名
 - PBEditTypeMobile: 电话
 - PBEditTypeEmail: 邮箱
 */
typedef NS_ENUM(NSInteger,PBEditType) {
    PBEditTypeNikckname = 1,
    PBEditTypeNote,
    PBEditTypeSignature,
    PBEditTypeMobile,
    PBEditTypeEmail,
};


/**
 编辑结果回调
 
 @param error 返回错误信息
 @param string 返回编辑文本
 @param type 编辑字段类型
 */
typedef void (^PBEditHandle)(NSError *error, NSString *string, PBEditType type);



/**
 搜索类型
 
 - PBSearchAllType1: 会话搜索
 - PBSearchAllType2: 添加好友搜索
 - PBSearchAllType3: 好友搜索
 - PBSearchAllType4: 黑名单搜索
 */
typedef NS_ENUM(NSInteger,PBSearchAllType) {
    PBSearchAllType1=1,
    PBSearchAllType2,
    PBSearchAllType3,
    PBSearchAllType4,
};



/**
 搜索结果的排序
 
 - SearchResultStateUp: 每个属性的升序
 - SearchResultStateDown: 每个属性的降序
 */
typedef NS_ENUM(NSInteger, SearchResultState){
    SearchResultStateUp,
    SearchResultStateDown,
};




/**
 封装公共方法
 */
@interface PBData : NSObject

+(NSString *)getUserNameWithUser:(NIMUser *)user;

@end

