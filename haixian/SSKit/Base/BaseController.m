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



//=====================================
//控制器初始化相关设置
//=====================================
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


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.hengping = @"0";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
  
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
        }
    }
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = !_isRoot;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
   
  
    _changeHeight = 0;
    _changeTime   = 2.5;
    NSNotificationCenter *nc =[NSNotificationCenter defaultCenter];
    //监听键盘弹出
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘收起
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


//网络变化了
-(void)updateNetWorking{
    
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


//=====================================
//键盘显示监听事件
//=====================================
- (void)keyboardWillShow:(NSNotification *)noti{
    
    NSDictionary *userInfo = [noti userInfo];
    _changeTime = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSValue* value1 = userInfo[UIKeyboardFrameBeginUserInfoKey];
    NSValue* value2 = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGFloat height1 = [value1 CGRectValue].size.height;
    CGFloat height2 = [value2 CGRectValue].size.height;
    
    if(height1 !=0 || height2 != 0){
        _changeHeight = height1>=height2?height1:height2;
    }
}


//回收键盘的监听事件
- (void)keyboardWillHide:(NSNotification *)noti{
    
    NSDictionary *userInfo = [noti userInfo];
    _changeTime = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSValue* value2 = userInfo[UIKeyboardFrameEndUserInfoKey];
    _changeHeight = [value2 CGRectValue].size.height;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//回车键回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}


//添加网络请求时的覆盖视图
-(void)addLoadingStatus:(HtmcNetworkingStatus)style{
    if(self.noneStatus == nil){
        self.noneStatus = [[SSNoneStatus alloc]initWithFrame:makeRect(0, 64, SCREEN_Width, SCREEN_Height-64)];
        self.noneStatus.delegate = self;
    }
    self.noneStatus.noneStyle = style;
}

//移除覆盖视图
-(void)deleteStatus{
    [self.noneStatus removeFromSuperview];
    self.noneStatus = nil;
}

//每种状态下按钮点击回调
-(void)SSNoneStatusBtnClick:(HtmcNetworkingStatus)style{

    
    
}




//返回按钮
-(void)leftBtnCLick{
    [self.navigationController popViewControllerAnimated:YES];
}


//操作提示弹框
-(void)systemAlert:(NSString *)title msg:(NSString *)msg okButton:(NSString *)ok cancelButton:(NSString *)cancel{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
           [self sysAlertBtnClickAction:action];
       }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel
        handler:^(UIAlertAction * action) {
        [self sysAlertBtnClickAction:action];
        
        }];
   
    [defaultAction setValue:TitleColor forKey:@"_titleTextColor"];
    [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIAlertControllerDelegate methods
-(void)sysAlertBtnClickAction:(UIAlertAction *)action{
    
}


//提示选择视图
-(void)showChoice:(NSString *)title message:(NSString *)message {
    coverView = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SCREEN_Height)];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
    [coverView addGestureRecognizer:tapGesture];
    
    choiceView = [[SSChoiceView alloc]initWith:title message:message];
    choiceView.delegate = self;
    choiceView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [[AppDelegate sharedAppDelegate].window addSubview:coverView];
    [[AppDelegate sharedAppDelegate].window addSubview:choiceView];
    
    [UIView animateIn:choiceView];
    
}


-(void)deleteChoiceView{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        choiceView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        coverView.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        [choiceView removeFromSuperview];
        choiceView = nil;
        [coverView removeFromSuperview];
        coverView = nil;
    }];
}

//按钮点击回调 10  11
-(void)SSChoiceViewBtnClick:(NSInteger)index{
    if(index==11){
        [self choiceOKBtnClick];
    }
    [self deleteChoiceView];
}

-(void)viewClick{
    [self deleteChoiceView];
}

//按钮点击后的操作
-(void)choiceOKBtnClick{
    
}





@end
