//
//  UIControl+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "UIControl+SSAdd.h"
#import "EXTSynthesize.h"

@implementation UIControl (DEAdd)


@synthesizeAssociation(UIControl,action);


-(void)addTarget:(id)target touchUpInsideActionBlock:(ControlAction)action{
    self.action = action;
    [self addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addTarget:(id)target editingActionBlock:(ControlAction)action{
    self.action = action;
    [self addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventEditingChanged];
}

- (void)addTarget:(id)target eventValueChangedActionBlock:(ControlAction)action{
    self.action = action;
    [self addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventValueChanged];
}


-(void)addTarget:(id)target actionBlock:(ControlAction)action forControlEvents:(UIControlEvents)controlEvents{
    self.action = action;
    [self addTarget:self action:@selector(controlAction:) forControlEvents:controlEvents];
}






//控制的事件  换成了代码块
-(void)controlAction:(id)control{
    self.action(control);
}



@end
