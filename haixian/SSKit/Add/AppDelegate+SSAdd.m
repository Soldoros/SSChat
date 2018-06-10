//
//  AppDelegate+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "AppDelegate+SSAdd.h"




@implementation AppDelegate (SSAdd)





+(AppDelegate *)sharedAppDelegate{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}








//监测网络状态
-(void)checkNetWorkStatus{
    
    
    
    
}







//监测网络状态
-(void)checkNetWorkStatus2{
    
    SSUserDefault *udf = [SSUserDefault shareCKUserDefault];
    [SSRequest startCheckNetStatus:^(NSInteger status) {
        udf.netStatus = (NSInteger)status;
        switch (status) {
            case -1:
                udf.canNetWorking = NO;
                break;
            case 0:
                udf.canNetWorking = NO;
                break;
            case 1:
                udf.canNetWorking = YES;
                break;
            case 2:
                udf.canNetWorking = YES;
                break;
            default:
                break;
        }
    }];
    
}








@end
