//
//  SSAppleLogin.h
//  FuWan
//
//  Created by soldoros on 2021/9/1.
//

//苹果登录
#import <Foundation/Foundation.h>

//code=0 版本问题  1成功 2授权信息不符  3其他错误
typedef void(^SSAppleLoginBlock)(NSDictionary *dic);

@interface SSAppleLogin : NSObject

@property(nonatomic,copy)SSAppleLoginBlock handle;

// 处理授权
- (void)appleLoginBlock:(SSAppleLoginBlock)handle;

// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
- (void)perfomExistingAccountSetupFlows;

@end


