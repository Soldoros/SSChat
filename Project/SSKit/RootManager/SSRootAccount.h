//
//  SSRootAccount.h
//  FuWan
//
//  Created by soldoros on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "AccountLoginController.h"

#define Share_Info    @"Share_Info"
#define USER_Login    @"USER_Login"
#define User_Phone    @"User_Phone"
#define User_Token    @"User_Token"
#define User_Info     @"User_Info"

@interface SSRootAccount : NSObject

//跳转到登录界面
+(void)loginJumpToController;

//设置综合数据
+(void)setShareInfo:(NSDictionary *)dic;
+(NSDictionary *)getShareInfo;


//设置和获取登录状态
+(void)setUserLogin:(NSString *)status;
+(NSString *)getUserLogin;

//设置和获取账号
+(void)setUserPhone:(NSString *)phone;
+(NSString *)getUserPhone;

//存储和获取token
+(void)setUserToken:(NSDictionary *)token;
+(NSDictionary *)getUserToken;

//存储和获取用户信息
+(void)setUserInfo:(NSDictionary *)dic;
+(NSDictionary *)getUserInfo;

@end


