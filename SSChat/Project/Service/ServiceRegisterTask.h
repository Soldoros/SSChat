//
//  ServiceRegisterTask.h
//  SSChat
//
//  Created by soldoros on 2019/5/20.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 注册回调

 @param error 返回错误信息 nil为注册成功
 @param errorMsg 返回错误说明
 */
typedef void(^ServiceRegisterHandler)(NSError *error, NSString *errorMsg);



/**
 账号注册用的模型，此处需要账号 昵称 和密码
 */
@interface ServiceRegisterUser : NSObject

@property (nonatomic, copy)    NSString   *account;
@property (nonatomic, copy)    NSString   *token;
@property (nonatomic, copy)    NSString   *nickname;

@end



/**
 账号注册服务
 */
@interface ServiceRegisterTask : NSObject

+ (void)registerUser:(ServiceRegisterUser *)user
          completion:(ServiceRegisterHandler)completion;

@end


