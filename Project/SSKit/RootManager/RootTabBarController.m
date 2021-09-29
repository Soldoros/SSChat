//
//  RootTabBarController.m
//  SSChat
//
//  Created by soldoros on 2019/5/12.
//  Copyright © 2019 soldoros. All rights reserved.
//


#import "RootTabBarController.h"
#import "MessageController.h"
#import "ContactController.h"
#import "MineController.h"


@interface RootTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarController

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.selectedViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = TabbarColor;
    self.tabBar.backgroundImage = [UIImage imageFromColor:TabbarColor];
    
    
    MessageController  *vc1 = [[MessageController alloc]initWithRoot:YES];
    ContactController  *vc2 = [[ContactController alloc]initWithRoot:YES];
    MineController     *vc3 = [[MineController alloc]initWithRoot:YES];
    
    RootNavigationController *nav1 = [self  getNavgationController:vc1 title:@"消息" nomImg:@"Tab_message_nol" selImg:@"Tab_message_sel"];
    RootNavigationController *nav2 = [self  getNavgationController:vc2 title:@"联系人" nomImg:@"Tab_contact_nol" selImg:@"Tab_contact_sel"];
    RootNavigationController *nav3 = [self  getNavgationController:vc3 title:@"我的" nomImg:@"Tab_wode_nol" selImg:@"Tab_wode_sel"];
    
    self.viewControllers = @[nav1,nav2,nav3];
    self.tabBar.unselectedItemTintColor = TabBarTintDefaultColor;
    self.tabBar.tintColor = TabBarTintSelectColor;
    
}


@end
