//
//  SSAccountManager.h
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

/*
 账号模型，包括存储登录状态、、账号、密码，登录后的用户信息等
 */
#import <Foundation/Foundation.h>


@interface SSAccountModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;

@end



/**
 账号管理器
 */
@interface SSAccountManager : NSObject

+(instancetype)shareSSAccountManager;

@property(nonatomic,strong)NSString *filePath;

@property(nonatomic,strong)SSAccountModel *accountModel;

@end

