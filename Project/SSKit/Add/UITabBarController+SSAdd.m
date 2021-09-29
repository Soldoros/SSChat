//
//  UITabBarController+SSAdd.m
//  FuWan
//
//  Created by soldoros on 2021/8/4.
//

#import "UITabBarController+SSAdd.h"

@implementation UITabBarController (SSAdd)

 
-(RootNavigationController *)getNavgationController:(UIViewController *)vc title:(NSString *)title nomImg:(NSString *)nomImg selImg:(NSString *)selImg {
    
    
    UIImage *nom = [[UIImage imageNamed:nomImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sel = [[UIImage imageNamed:selImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [nom imageWithColor:TabBarTintDefaultColor];
    vc.tabBarItem.selectedImage = [sel imageWithColor:TabBarTintSelectColor];
    
    
//    //配置tabBarItem文字在普通状态和选中状态下的颜色
//    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:TabBarTintDefaultColor} forState:UIControlStateNormal];
//    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:TabBarTintSelectColor} forState:UIControlStateSelected];
    

    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
    return nav;
}

@end
