//
//  SSRootAccount.m
//  FuWan
//
//  Created by soldoros on 2021/8/4.
//

#import "SSRootAccount.h"

@implementation SSRootAccount

+(void)loginJumpToController{
    AccountLoginController *vc = [AccountLoginController new];
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIViewController getCurrentController].navigationController presentViewController:nav animated:YES completion:nil];
}

//设置综合数据
+(void)setShareInfo:(NSDictionary *)dic{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:dic forKey:Share_Info];
}

+(NSDictionary *)getShareInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return  [user valueForKey:Share_Info];
}

//设置和获取登录状态
+(void)setUserLogin:(NSString *)status{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:status forKey:USER_Login];
}

+(NSString *)getUserLogin{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user valueForKey:USER_Login] == nil){
        return @"0";
    }
    else return [user valueForKey:USER_Login];
}

//设置和获取账号
+(void)setUserPhone:(NSString *)phone{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:phone forKey:User_Phone];
}
+(NSString *)getUserPhone{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return  [user valueForKey:User_Phone];
}

//存储和获取token
//存储和获取用户信息
//"F2C224D4-2BCE-4C64-AF9F-A6D872000D1A" = 1;
//code = 0;
//mid = 1032221112;
//phone = 13333333333;
//session =     {
//    id = "app_13333333333";
//    skey = a7cfc740442f4bc18a4dd2061c6f1022;
//    userId = 103223;
//};
//wxmpNo = 200;
+(void)setUserToken:(NSDictionary *)token{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:token forKey:User_Token];
}


+(NSDictionary *)getUserToken{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def valueForKey:User_Token];
}


+(void)setUserInfo:(NSDictionary *)dic{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:dic forKey:User_Info];
}

+(NSDictionary *)getUserInfo{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def valueForKey:User_Info];
}



@end
