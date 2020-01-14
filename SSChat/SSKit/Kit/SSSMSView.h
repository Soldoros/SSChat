//
//  SSSMSView.h
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


#define  TIMER   60
#define  BmobSMSTemplate   @"HelloAPP通讯"
#define  NomerString   @"获取验证码"


/**
 请求验证码的方式

 - SMSGetCodeTypePhone: 通过手机获取验证码
 - SMSGetCodeTypeEmail: 通过邮箱获取验证码
 */
typedef NS_ENUM(NSInteger, SMSViewGetCodeType) {
    SMSGetCodeTypePhone = 1,
    SMSGetCodeTypeEmail = 2,
};

/**
 发送短信验证码的功能类型

 - SMSGetCodeRegister: 注册
 - SMSGetCodeFind: 找回密码
 - SMSGetCodeChangePassword: 修改密码
 - SMSGetCodeChangeOldPhone: 修改手机号发送给旧手机
 - SMSGetCodeChangeNewPhone: 修改手机号发送给新手机
 - SMSGetCodeAddFamliy: 添加家人
 - SMSGetCodefamliyChanePhone: 家人修改手机号
 */
typedef NS_ENUM(NSInteger, SMSViewGetCodeStyle) {
    SMSGetCodeRegister = 1,
    SMSGetCodeFind = 2,
    SMSGetCodeChangePassword = 3,
    SMSGetCodeChangeOldPhone = 4,
    SMSGetCodeChangeNewPhone = 5,
    SMSGetCodeAddFamliy = 7,
    SMSGetCodefamliyChanePhone = 8,
};



/**
 获取手机号或者邮箱

 @return 返回手机号或者邮箱
 */
typedef NSString *(^SSStringBlock)();

/**
 发送短信回调代码块

 @param type 获取验证码的途径（手机号 邮箱）
 @param style 发送短信的功能
 @param error 网络请求错误信息
 @param dic 后台返回数据
 */
typedef void (^SSSMSBlock)(SMSViewGetCodeType type ,SMSViewGetCodeStyle style , NSError *error, NSDictionary *dic);


@interface SSSMSView : UIView


//返回手机号或邮箱的代码块
@property(nonatomic,copy)SSStringBlock   stringBlock;
//验证码发送完毕后的代码块
@property(nonatomic,copy)SSSMSBlock      smsBlock;
//获取验证码的类型
@property(nonatomic,assign)SMSViewGetCodeType type;
//验证码的功能
@property(nonatomic,assign)SMSViewGetCodeStyle style;


//相关参数
@property(nonatomic,strong)NSTimer      *timer;
@property(nonatomic,assign)NSInteger    time;

//邮箱或者手机号
@property(nonatomic,strong)NSString     *peString;

//获取验证码
@property(nonatomic,strong)UIButton     *mGetPassBtn;

@property(nonatomic,copy)NSString       *urlString;
@property(nonatomic,strong)NSDictionary *dic;


/**
 通过类型初始化
 
 @param frame 当前对象的frame
 @param type 获取验证码的渠道
 @return 返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame type:(SMSViewGetCodeType)type;

/**
 初始化对象

 @param frame 当前对象的frame
 @param style 验证码的功能类型
 @return 返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame style:(SMSViewGetCodeStyle)style;



/**
 初始化对象

 @param frame 当前对象的frame
 @param type 获取验证码的途径
 @param style 验证码的功能类型
 @return 返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame type:(SMSViewGetCodeType)type style:(SMSViewGetCodeStyle)style;




/**
 获取手机号或者邮箱

 @param stringBlock 返回手机号邮箱的代码块
 @param smsBlock 验证码代码块回调
 */
-(void)getPEStringWithBlock:(SSStringBlock)stringBlock smsBlock:(SSSMSBlock)smsBlock;





@end
