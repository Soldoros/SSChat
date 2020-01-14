//
//  BaseController.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//


#import "BaseController.h"


@interface BaseController ()

@end

@implementation BaseController


-(instancetype)init{
    if(self = [super init]){
        self.isRoot = NO;
    }
    return self;
}
    
-(instancetype)initWithRoot:(BOOL)root{
    if([super init]){
        self.isRoot = root;
    }
    return self;
}
    
-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if([super init]){
        self.isRoot = root;
        self.titleString = title;
        self.navigationItem.title = title;
    }
    return self;
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    //适配ios 11  滚动视图返回时有偏移
    for (UIView* subView in self.view.subviews){
        if([subView isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)subView;
            
            if (@available(iOS 11.0, *)){
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                tableView.scrollIndicatorInsets = tableView.contentInset;
                //reloadData的时候，会重新计算contentSize，就有可能会引起contentOffset的变化 在这里关闭
                tableView.estimatedRowHeight = 0;
                tableView.estimatedSectionHeaderHeight = 0;
                tableView.estimatedSectionFooterHeight = 0;
            }
            UIScrollView *scro = (UIScrollView *)subView;
            scro.scrollIndicatorInsets = tableView.contentInset;
        }
    }
    
    
    self.navigationController.tabBarController.tabBar.hidden = !_isRoot;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
  
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//回车键回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}







@end
