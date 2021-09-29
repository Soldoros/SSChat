//
//  AccountCodeController.h
//  QuFound
//
//  Created by soldoros on 2020/7/15.
//  Copyright © 2020 soldoros. All rights reserved.
//

//发送验证码
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountCodeController : BaseViewController

//修改登录密码1
//设置支付密码2
//修改支付密码3
//忘记支付密码4
//忘记支付密码5
//电话绑定6
@property(nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
