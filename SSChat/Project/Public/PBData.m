//
//  PBData.m
//  SSChat
//
//  Created by soldoros on 2019/6/5.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "PBData.h"



@implementation PBData

//展示用户的名字（备注、昵称、账号）
+(NSString *)getUserNameWithUser:(NIMUser *)user{
    
    NSString *current = [NIMSDK sharedSDK].loginManager.currentAccount;
    
    NSString *name = user.alias;
    if([user.userId isEqualToString:current]){
        name = @"";
    }
    if(name == nil || name.length == 0){
        name = user.userInfo.nickName;
    }
    if(name == nil || name.length == 0){
        name = user.userId;
    }
    
    return name;
}

@end
