//
//  UINavigationController+Add.h
//  haixian
//
//  Created by soldoros on 2017/11/6.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Add)

@property(nonatomic,strong)NSString *hengping;

//跳转到首页
-(void)jumpToHomeVc;

//登录
-(void)navLoginAnimation:(BOOL)animation;


@end
