//
//  UINavigationController+Add.m
//  haixian
//
//  Created by soldoros on 2017/11/6.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "UINavigationController+Add.h"
#import "EXTSynthesize.h"

@implementation UINavigationController (Add)

@synthesizeAssociation(UINavigationController,hengping);


//跳转到首页
-(void)jumpToHomeVc{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}



//登录
-(void)navLoginAnimation:(BOOL)animation{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user boolForKey:USER_Login]==NO){
        
        [self popToRootViewControllerAnimated:NO];
        
    }
}






@end
