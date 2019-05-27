//
//  SSApplicationHelper.h
//  SSChat
//
//  Created by soldoros on 2019/5/20.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

//网易即时通讯key+secret
#define NIM_APPKey       @"45c6af3c98409b18a84451215d0bdd6e"
#define NIM_APPSecret    @"099b6720b1c9"

//BMOBkey
#define BOMB_APPKey      @"f4542e53f2fa794032d8a7641438082a"
#define BMOB_APPSecret   @"9658c2402e63c2e8"
#define BmobSMSTemplate  @"HelloAPP"


@interface SSApplicationHelper : NSObject

+(SSApplicationHelper *)shareApplicationHelper;

+(void)applicationRegister;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end



