//
//  UIViewController+SSAdd.h
//  AlarmClock
//
//  Created by soldoros on 2019/6/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (SSAdd)

//获取当前展示的控制器
+(UIViewController *)getCurrentController;

//跳转到当前控制器
+(void)jumpToController:(NSString *)classString;

@end


