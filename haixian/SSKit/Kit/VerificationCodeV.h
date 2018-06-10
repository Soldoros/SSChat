//
//  VerificationCodeV.h
//  BJLT
//
//  Created by chou on 15/8/6.
//  Copyright (c) 2015年 Soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  TIMER   60
#define  BmobSMSTemplate   @"HelloAPP通讯"

/**
 区分是注册还是其他 1用户注册 2找回密码 3修改密码 4修改手机
 */


/**
 区分验证码的功能

 - GetCodeWithRegister: 注册 1
 - GetCodeWithFind: 忘记密码 2
 - GetCodeWithChangePassword: 修改密码 3
 - GetCodeWithChangZhifuMima: 修改支付密码 4
 - GetCodeWithChangePhone: 验证用户手机号 5
 - GetCodeWithChangeNewPhone: 验证用户新手机号 6
 - GetCodeWithChangeEmail: 修改邮箱
 - GetCodeWithChangePhoneOver: 手机号修改完成
 - GetCodeWithAddFamliy: 添加家人
 - GetCodeWithFamliyChangePhone: 家人修改手机号
 - GetCodeWithBangDingEmail: 绑定邮箱
 - GetCodeWithBangChangeEmail: 修改绑定邮箱
 */
typedef NS_ENUM(NSInteger, getCodeStyle) {
    GetCodeWithRegister = 1,
    GetCodeWithFind = 2,
    GetCodeWithChangePassword = 3,
    GetCodeWithChangZhifuMima = 4,
    GetCodeWithChangePhone = 5,
    GetCodeWithChangeNewPhone = 6,
    GetCodeWithChangeEmail = 7,
    GetCodeWithChangePhoneOver = 8,
    GetCodeWithAddFamliy = 9,
    GetCodeWithFamliyChangePhone = 10,
    GetCodeWithBangDingEmail=101,
    GetCodeWithBangChangeEmail=102,
};


@protocol VerificationCodeVDelegate <NSObject>

-(NSString *)phoneNum;
-(void)netResultError:(NSError *)error  dict:(NSDictionary *)dict;


@end


@interface VerificationCodeV : UIView

@property(nonatomic,assign)getCodeStyle getCodeStyle;

//点击获取
-(void)btnPressed;

//获取验证码
@property(nonatomic,strong)UILabel *mBtnLab;
@property(nonatomic,strong)UIButton *mGetPassBtn;

@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,strong)NSDictionary *dic;


@property(nonatomic,assign)id<VerificationCodeVDelegate>delegate;

@end
