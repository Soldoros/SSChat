//
//  SSUserDefault.m
//  2048
//
//  Created by soldoros on 2017/3/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSUserDefault.h"


static SSUserDefault* user = nil;

@implementation SSUserDefault

+(SSUserDefault *)shareCKUserDefault
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        user = [[SSUserDefault alloc]init];
        [user initData];
        
    });
    return user;
}


-(void)initData{
  
    
    //更新版本
    user.notMustUpdate = YES;
    user.mustUpdate = YES;
    
    
    user.showChance = YES;
    user.showRedDict = [NSMutableDictionary new];
    
    user.tabBarColor    =  makeColorHex(@"#e84154"); 
    user.titleColor     = makeColorRgb(33, 46, 59);
    user.netStatus     = 2;
    user.canNetWorking = YES;
    user.cartNumber = nil;
    user.userImage = [UIImage imageNamed:@"默认头像"];
    user.msgNumber = @"0";
    

    user.owner_relationship = @{@"本人":@"self",
                                @"父亲":@"father",
                                @"母亲":@"mother",
                                @"儿子":@"children",
                                @"女儿":@"daughter",
                                @"妻子":@"wife",
                                @"丈夫":@"husband"};
    
    
    NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
    NSString *uSex = [userDf valueForKey:USER_Sex];
    if([userDf boolForKey:USER_Login] == NO){
        user.sex = 3;
    }else if(uSex == nil){
        user.sex = 3;
    }else{
        user.sex = uSex.integerValue;
    }
    
}






@end
