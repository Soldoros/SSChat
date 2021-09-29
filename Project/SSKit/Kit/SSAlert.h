//
//  SSAlert.h
//  SSChat
//
//  Created by soldoros on 2019/4/14.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 系统提示框按钮点击回调代码块
 
 @param action 点击的action
 */
typedef void (^AlertBlock)(UIAlertAction * action);

typedef void (^AlertTextBlock)(UIAlertAction * action, NSString *string);

@interface SSAlert : NSObject

//弹窗确认取消
+(void)pressentAlertControllerWithTitle:(NSString *)title message:(NSString *)message okButton:(NSString *)ok cancelButton:(NSString *)cancel alertBlock:(AlertBlock)alertBlock;

//带输入框的弹窗
+(void)pressentAlertWithTextPlaceHoder:(NSString *)placeholder title:(NSString *)title textBlock:(AlertTextBlock)textBlock;


//返回一个红色小圆点 传给圆点直径
+(UIView *)redRoundView:(CGFloat)size;

//返回一个红色数字圆点
+(UILabel *)redNumber:(NSInteger)number;


//系统分享
+(void)shareWithSystemController:(UIViewController *)controller url:(NSString *)url;


@end

