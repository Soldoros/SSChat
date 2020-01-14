//
//  SSAttributeDefault.h
//  caigou
//
//  Created by soldoros on 2018/4/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSAttributeDefault : NSObject

+(SSAttributeDefault *)shareCKAttributeDefault;
-(void)initData;


//主题色
@property(nonatomic, strong)UIColor   *titleColor;
//导航栏+状态栏背景颜色
@property(nonatomic, strong)UIColor   *navBarColor;
//标签栏背景颜色
@property(nonatomic, strong)UIColor   *tabBarColor;
//导航栏图标颜色
@property(nonatomic, strong)UIColor   *navTintColor;
//标签栏图标默认状态颜色
@property(nonatomic, strong)UIColor   *tabBarTintDefaultColor;
//标签栏图标选中状态颜色
@property(nonatomic, strong)UIColor   *tabBarTintSelectColor;
//视图背景色
@property(nonatomic, strong)UIColor   *backGroundColor;
//线条颜色
@property(nonatomic, strong)UIColor   *lineColor;





@end
