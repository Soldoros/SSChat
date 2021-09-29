//
//  SSGestureLockerView.h
//  htcm
//
//  Created by soldoros on 2018/5/7.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//手势密码
#import <UIKit/UIKit.h>



/**
 小型九宫格圆点显示
 */
@interface SSLockerView : UIView

//圆点数组
@property (strong, nonatomic) NSArray *rounds;

@end







//3*3的密码视图
#define Number   3

@protocol SSGestureLockerViewDelegate <NSObject>

- (void)SSGestureLockerViewDidSetFinished:(NSArray *)array;
@end

@interface SSGestureLockerView : UIView

@property(nonatomic,assign)id<SSGestureLockerViewDelegate>delegate;


//圆点数组
@property (strong, nonatomic) NSMutableArray* buttons;
//最后一个点 用于连接
@property (assign, nonatomic) CGPoint curlastPoint;


@end





