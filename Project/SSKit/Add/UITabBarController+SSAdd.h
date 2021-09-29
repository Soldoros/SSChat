//
//  UITabBarController+SSAdd.h
//  FuWan
//
//  Created by soldoros on 2021/8/4.
//

#import <UIKit/UIKit.h>




@interface UITabBarController (SSAdd)


-(RootNavigationController *)getNavgationController:(UIViewController *)vc title:(NSString *)title nomImg:(NSString *)nomImg selImg:(NSString *)selImg;


@end



