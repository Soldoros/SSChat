//
//  UIControl+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ControlAction)(id control);

@interface UIControl (DEAdd)


@property(nonatomic,assign)ControlAction action;


//默认是TouchUpInside
- (void)addTarget:(id)target touchUpInsideActionBlock:(ControlAction)action;

//默认是Editing
- (void)addTarget:(id)target editingActionBlock:(ControlAction)action;

//默认是EventValueChanged
- (void)addTarget:(id)target eventValueChangedActionBlock:(ControlAction)action;


//主动设置交互
- (void)addTarget:(id)target actionBlock:(ControlAction)action forControlEvents:(UIControlEvents)controlEvents;



@end
