//
//  AccountSettingPasswordController.h
//  QuFound
//
//  Created by soldoros on 2020/5/14.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountSettingPasswordController : BaseViewController
//修改登录密码的code  手机号
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *phone;

//注册设置密码1  修改登录密码2  忘记密码3
@property(nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
