//
//  BaseController.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.

/*
 
 基类不要处理太多的东西  核心的可以放在基类 比如状态栏 视图控制器的基本显示  键盘的呼起和收回  继承帮我们解决了代码臃肿的问题  这是很棒的
 
 */

#import "BaseVirtualController.h"


@interface BaseController : BaseVirtualController<UITextFieldDelegate,UIAlertViewDelegate>


//是不是根控制器
@property(nonatomic,assign)BOOL isRoot;
//标题
@property(nonatomic,strong)NSString *titleString;
    
-(instancetype)initWithRoot:(BOOL)root;
-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title;






@end
