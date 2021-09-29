//
//  UIViewController+SSAdd.m
//  AlarmClock
//
//  Created by soldoros on 2019/6/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "UIViewController+SSAdd.h"


@implementation UIViewController (SSAdd)


+(UIViewController *)getCurrentController{
    
    UIViewController *result = nil;
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)rootVC;
            UIViewController *vc = [navi.viewControllers lastObject];
            result = vc;
            rootVC = vc.presentedViewController;
            continue;
        } else if([rootVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)rootVC;
            result = tab;
            rootVC = [tab.viewControllers objectAtIndex:tab.selectedIndex];
            continue;
        } else if([rootVC isKindOfClass:[UIViewController class]]) {
            result = rootVC;
            rootVC = nil;
        }
    } while (rootVC != nil);
    
    return result;
}


//跳转到当前控制器
+(void)jumpToController:(NSString *)classString{
    
    UIViewController *controller = [UIViewController getCurrentController];
    UIViewController *vc = nil;
    cout(controller.navigationController.viewControllers);
    for(UIViewController *con in controller.navigationController.viewControllers){
        if([con.className isEqualToString:classString]){
            vc = con;
            break;
        }
    }
    if(vc){
        [controller.navigationController popToViewController:vc animated:YES];
    }else{
        vc = [NSClassFromString(classString) new];
        [controller.navigationController pushViewController:vc animated:YES];
    }

}

@end
