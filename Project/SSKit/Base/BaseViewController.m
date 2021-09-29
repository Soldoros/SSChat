//
//  BaseViewController.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//


#import "BaseViewController.h"


@interface BaseViewController ()

@property(nonatomic,assign)CGFloat firstResponderTop;


@end

@implementation BaseViewController


-(instancetype)init{
    if(self = [super init]){
        self.isRoot = NO;
         [self initUserDatas];
    }
    return self;
}
    
-(instancetype)initWithRoot:(BOOL)root{
    if([super init]){
        self.isRoot = root;
        [self initUserDatas];
    }
    return self;
}
    
-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if([super init]){
        self.isRoot = root;
        self.titleString = title;
        [self initUserDatas];
    }
    return self;
}

-(void)initUserDatas{
    _config = [SSConfigManager shareManager];
    _barStyle = _config.barStyle;
    _user = [NSUserDefaults standardUserDefaults];
    _firstResponderTop = 0;
}

-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//UIStatusBarStyleDefault
- (UIStatusBarStyle)preferredStatusBarStyle{
    return _barStyle;
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidLoad{
    
    cout(NavBarColor);
    [super viewDidLoad];
    
    
    
    [self setNavgationBarColorImg:NavBarColor];
    [self setNavgationBarLine:[UIColor clearColor]];
    [self setNavgationTitleFont:makeFont(18) color:NavBarTitColor];
    if(!_isRoot){
        [self setLeftOneBtnImg:_config.leftBtnImg];
    }
    
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
            }
            UIScrollView *scro = (UIScrollView *)subView;
            scro.scrollIndicatorInsets = tableView.contentInset;
            
            if (@available(iOS 13.0, *)) {
//                tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
                
            }
        }
    }
    
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = !_isRoot;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    
    [self updateAppAttbuteInterface];
    
}


//刷新界面主题
-(void)updateAppAttbuteInterface{
    
    if(self.navtionBar){
        [self setNavgationBarColorImg:NavBarColor];
        [self setNavgationBarLine:_config.navLineColor];
        [self setNavgationTitleFont:makeBlodFont(18) color:NavBarTitColor];
    }
    
    if(_isRoot == NO){
        [self setLeftOneBtnImg:_config.leftBtnImg];
    }
    _barStyle = _config.barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
    
}


//返回按钮
-(void)navgationButtonPressed:(UIButton *)sender{
    if([sender isEqual:self.leftBtn1]){
        [self.navigationController popViewControllerAnimated:YES];
    }
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
