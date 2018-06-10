//
//  BaseController.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.


#import <UIKit/UIKit.h>

@interface BaseController : UIViewController<UITextFieldDelegate,SSNoneStatusDelegate,UIAlertViewDelegate,SSChoiceViewDelegate>{
    
    //提示确认视图
    UIView *coverView;
    SSChoiceView *choiceView;
}

//是不是根控制器
@property(nonatomic,assign)BOOL isRoot;
//标题
@property(nonatomic,strong)NSString *titleString;
    
-(instancetype)initWithRoot:(BOOL)root;
-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title;


//表单数据
@property(nonatomic,assign)CGFloat tableViewH;
@property(nonatomic,strong)UITableView *mTableView;
@property(nonatomic,strong)NSMutableArray *datas;

//网络请求的加载视图
@property(nonatomic,strong)SSNoneStatus *noneStatus;
@property(nonatomic,assign)NSInteger page;
//添加网络请求时的覆盖视图 移除覆盖视图
-(void)addLoadingStatus:(HtmcNetworkingStatus)style;
-(void)deleteStatus;


//检测网络变化
@property(nonatomic,strong)SSUserDefault *udf;
-(void)updateNetWorking;


//红色圆点
@property(nonatomic, strong)UIView     *redView;


//键盘弹起的高度 耗时
@property (assign, nonatomic) CGFloat changeHeight;
@property (assign, nonatomic) CGFloat changeTime;
//键盘显示、回收监听事件
- (void)keyboardWillShow:(NSNotification *)noti;
- (void)keyboardWillHide:(NSNotification *)noti;


//操作提示弹框
-(void)systemAlert:(NSString *)title msg:(NSString *)msg okButton:(NSString *)ok cancelButton:(NSString *)cancel;
-(void)sysAlertBtnClickAction:(UIAlertAction *)action;

//显示提示信息 点击按钮回调
-(void)showChoice:(NSString *)title message:(NSString *)message;
-(void)choiceOKBtnClick;




@end
