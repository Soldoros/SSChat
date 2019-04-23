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
    }
    return self;
    
}

-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    //适配ios 11  滚动视图返回时有偏移
    for (UIView* subView in self.view.subviews){
        if([subView isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)subView;
            
            if (@available(iOS 11.0, *)){
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                tableView.scrollIndicatorInsets = tableView.contentInset;

                tableView.estimatedRowHeight = 0;
                tableView.estimatedSectionHeaderHeight = 0;
                tableView.estimatedSectionFooterHeight = 0;
                
            }
            UIScrollView *scro = (UIScrollView *)subView;
            scro.scrollIndicatorInsets = tableView.contentInset;
        }
    }
    
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = !_isRoot;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
  
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavgationBarColorImg:[UIColor whiteColor]];
    [self setNavgationBarLine:BackGroundColor];
    [self setNavgationTitleFont:makeBlodFont(18) color:makeColorHex(@"333333")];
    if(!_isRoot){
        [self setLeftOneBtnImg:@"fanhui"];
    }
}


//返回按钮
-(void)leftBtnCLick{
    [self.navigationController popViewControllerAnimated:YES];
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
