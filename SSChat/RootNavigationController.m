//
//  RootNavigationController.m
//  SSChat
//
//  Created by soldoros on 2019/5/12.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController


-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
