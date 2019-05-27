//
//  SSSMSView.h
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


#define  TIMER   60


/**
 确认手机号或者邮箱
 */
typedef BOOL (^SMSConfirmPEBlock)(void);

/**
 发送验证码 进入倒计时
 */
typedef void (^SMSConfirmSendBlock)(void);


@interface SSSMSView : UIView

//验证短信和发送验证码
-(void)confirmPEBlock:(SMSConfirmPEBlock)peBlock sendBlock:(  SMSConfirmSendBlock)sendBlock;

//确认手机号或者邮箱的代码块
@property(nonatomic, copy) SMSConfirmPEBlock     peBlock;
//验证码发送完毕后的代码块
@property(nonatomic, copy) SMSConfirmSendBlock   sendBlock;
//获取验证码的类型
@property(nonatomic,assign) BOOL                 peConfirm;

//相关参数
@property(nonatomic,strong)NSTimer      *timer;
@property(nonatomic,assign)NSInteger    time;
//获取验证码
@property(nonatomic,strong)UIButton     *mGetPassBtn;

@property(nonatomic,copy)NSString       *urlString;
@property(nonatomic,strong)NSDictionary *dic;



@end
