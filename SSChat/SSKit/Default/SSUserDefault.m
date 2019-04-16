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

+(SSUserDefault *)shareCKUserDefault{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        user = [[SSUserDefault alloc]init];
        
        user.tabBarColor   =  makeColorHex(@"#e84154");
        user.titleColor    = makeColorRgb(33, 46, 59);
        user.netStatus     = 2;
        user.canNetWorking = YES;
        user.cartNumber    = nil;
        user.userImage     = [UIImage imageNamed:@"默认头像"];
        user.msgNumber     = @"0";
        
    });
    return user;
}





@end
