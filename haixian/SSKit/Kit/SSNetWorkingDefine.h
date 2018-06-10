//
//  SSNetWorkingDefine.h
//  DEShop
//
//  Created by soldoros on 2017/5/8.
//  Copyright © 2017年 soldoros. All rights reserved.



#ifndef SSNetWorkingDefine_h
#define SSNetWorkingDefine_h

//输入框的限制输入
#define SHURUMIMA @"1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
#define SHURUSHOUJIHAO @"1234567890"


//个人信息状变化后的通知
#define NotiMyMsgChange               @"NotiMyMsgChange"

//通知控制器显示提示信息
#define NotiShowMessage           @"NotiShowMessage"
//微信支付
#define NotiWXPay                 @"NotiWXPay"
//微信支付结果
#define NotiWXPayOver             @"NotiWXPayOver"
//支付宝支付
#define NotiALiPay                @"NotiALiPay"
//支付支付结果
#define NotiALiPayOver            @"NotiALiPayOver"

//htcm家人管理列表刷新
#define NotiFamilyListChange      @"NotiFamilyListChange"
//htcm家人管理详情刷新
#define NotiFamilyDetChange      @"NotiFamilyDetChange"



//测试服和正式服
#define URLTestStr        @"http://192.168.1.193:81/"
#define URLFormalStr      @"http://192.168.1.193:81/"
#define URLFormalStrNew   @"http://192.168.1.193:81/"

//当前使用地址
#define URLStrUse          URLFormalStr
#define URLStr              URLStrUse

#define URLHeaderUrl       [[NSUserDefaults standardUserDefaults] valueForKey:USER_HeaderUrl]



//htcm注册用户-发送短信验证码
#define URLRegisterCode           @"api/auth/accounts/register/sms-validation-code"
//htcm忘记密码-发送短信验证码
#define URLFindPasswordCode       @"api/auth/accounts/forgot-password/sms-validation-code"
//htcm修改手机号密码验证
#define URLChangePhoneToMima      @"api/auth/accounts/mobile/password-validation"
//htcm修改手机号旧手机号发送验证码
#define URLChangePhoneOldCode     @"api/auth/accounts/mobile/sms-validation-code/identification"
//htcm修改手机号验证旧手机号验证码
#define URLCheckOldPhoneCode         @"api/auth/accounts/mobile/sms-validation"
//htcm更换手机号新手机号验证码
#define URLChangeNewPhoneCode        @"api/auth/accounts/mobile/sms-validation-code/bind"
//htcm更换手机号新手机号验证码
#define URLChangeAddFamilyCode        @"api/family/family-members/sms-validation-code"
//htcm家人修改手机号发送验证码
#define URLChangeFamilyChangePhoneCode        @"api/family/family-members/30/mobile/sms-validation-code"


//htcm更换新手机号
#define URLChangeNewPhone          @"api/auth/accounts/mobile/change"


//htcm注册用户
#define URLRegister            @"api/auth/accounts"
//htcm登录获取token
#define URLLogin               @"api/auth/accounts/access-token"
//htcm修改密码
#define URLChangePassword      @"api/auth/accounts/password"
//htcm忘记密码
#define URLRetrievePassword    @"api/auth/accounts/forgot-password"


//htcm请求个人信息获取账号信息
#define URLGetpersonalMessage        @"api/auth/accounts"
//htcm更换头像设置账号头像
#define URLPersonalChangeHedaerImg   @"api/auth/accounts/avatar"
//htcm更新昵称
#define URLPersonalChangeNikename    @"api/auth/accounts/nickname"




//htcm获取家人管理列表
#define URLFamilyManagement       @"api/family/family-members"
//htcm添加加人上传头像
#define URLFamilyAddForHeaderImg  @"api/family/family-members/avatar"
//htcm添加家庭成员
#define URLFamilyAddmembers       @"api/family/family-members"
//htcm家人认证
#define URLFamilyCertification    @"api/family/family-members/30/authentication"

//htcm家人解除绑定
#define URLFamilyRemoveBinding    @"api/family/family-members/"

//htcm家人详情修改家人信息
#define URLFamilyEditMsg       @"api/family/family-members/"












#endif /* SSNetWorkingDefine_h */
