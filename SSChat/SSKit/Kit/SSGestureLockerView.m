//
//  SSGestureLockerView.m
//  htcm
//
//  Created by soldoros on 2018/5/7.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//手势密码
#import "SSGestureLockerView.h"



@implementation SSLockerView{
    UIButton *button[9];
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        //tag值从1开始   1-9
        for(int i=0;i<Number;++i){
            for(int j=0;j<Number;++j){
                
                button[i*Number+j] = [UIButton buttonWithType:UIButtonTypeCustom];
                button[i*Number+j].bounds = makeRect(0, 0, 5, 5);
                [self addSubview:button[i*Number+j]];
                button[i*Number+j].tag = i*Number+j+1;
                button[i*Number+j].userInteractionEnabled = NO;
                button[i*Number+j].selected = NO;
                [button[i*Number+j] setBackgroundImage:[UIImage imageNamed:@"dian_huise"] forState:UIControlStateNormal];
                [button[i*Number+j] setBackgroundImage:[UIImage imageNamed:@"dian_lvse"] forState:UIControlStateSelected];
                
                if(j==0)button[i*Number+j].left=0;
                else if (j==1)button[i*Number+j].centerX = self.width*0.5;
                else button[i*Number+j].right = self.width;
                
                if(i==0)button[i*Number+j].top=0;
                else if (i==1)button[i*Number+j].centerY = self.height*0.5;
                else button[i*Number+j].bottom = self.height;
                
            }
        }
        
    }
    return self;
}


-(void)setRounds:(NSArray *)rounds{
    cout(rounds);
    for(int i=0;i<9;++i){
        button[i].selected = NO;
    }
    for (int i=0;i<rounds.count;++i){
        NSInteger index = [rounds[i]integerValue];
        button[index-1].selected = YES;
    }
}


@end






@implementation SSGestureLockerView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        _buttons = [NSMutableArray new];
        
        UIView *line = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, 1)];
        line.backgroundColor = self.backgroundColor;
        [self addSubview:line];

        //tag值从1开始   1-9
        for(int i=0;i<Number;++i){
            for(int j=0;j<Number;++j){
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.bounds = makeRect(0, 0, 60, 60);
                [self addSubview:btn];
                btn.tag = i*Number+j+1;
                btn.userInteractionEnabled = NO;
                btn.selected = NO;
                [btn setBackgroundImage:[UIImage imageNamed:@"fuxuan_weixuanzhong"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"erbihou"] forState:UIControlStateSelected];
                
                if(j==0)btn.left=30;
                else if (j==1)btn.centerX = SCREEN_Width*0.5;
                else btn.right = SCREEN_Width-30;
                
                if(i==0)btn.top=20;
                else if (i==1)btn.centerY = 20+SCREEN_Width*0.5-30;
                else btn.bottom = 20+SCREEN_Width-60;
                
            }
        }
        
    }
    return self;
}

//判断手势的触点位置有没有按钮存在
- (UIButton*)circleButtonInPoint:(CGPoint)point{
    for (UIButton* button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}

//返回手势触点坐标
- (CGPoint)touchPoint:(NSSet*)touches{
    UITouch* touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

//所有按钮初始化为默认状态
- (void)clearLastSelected{
    for (UIButton* button in _buttons) {
        button.selected = NO;
    }
    [_buttons removeAllObjects];
    [self setNeedsDisplay];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self clearLastSelected];
    self.curlastPoint = CGPointMake(-10.0f, -10.0f);
    CGPoint point = [self touchPoint:touches];
    UIButton* button = [self circleButtonInPoint:point];
    if (button) {
        if (!button.selected) {
            button.selected = YES;
            [_buttons addObject:button];
        }
    }
    [self setNeedsDisplay];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self touchPoint:touches];
    UIButton* button = [self circleButtonInPoint:point];
    if (button && !button.selected) {
        button.selected = YES;
        [_buttons addObject:button];
    }
    else{
        self.curlastPoint = point;
    }
    [self setNeedsDisplay];
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self touchPoint:touches];
    UIButton* button = [self circleButtonInPoint:point];
    if (button) {
        if (button && !button.selected) {
            button.selected = YES;
            [_buttons addObject:button];
        }
    }
    [self notiDelegate];
    [self clearLastSelected];
}


//绘制线条
- (void)drawRect:(CGRect)rect {
    if (_buttons.count==0) return;

    UIBezierPath* bezierPath = [UIBezierPath new];
    UIButton *btn = (UIButton *)[_buttons firstObject];
    [bezierPath moveToPoint: [btn center]];
    for (NSUInteger i = 1; i < _buttons.count; ++i) {
        [bezierPath addLineToPoint:[(UIButton *)[_buttons objectAtIndex:i] center]];
    }
    
    if (NO == CGPointEqualToPoint(self.curlastPoint, CGPointMake(-10.0f, -10.0f))) {
        [bezierPath addLineToPoint:self.curlastPoint];
    }
    // 绘图
    bezierPath.lineWidth = 1;
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    [TitleColor set];
    [bezierPath stroke];
}

//代理回调
-(void)notiDelegate{
    
    NSMutableArray *arr = [NSMutableArray new];
    for (UIButton *button in _buttons) {
        if(button.selected==YES){
            NSString *num = makeStrWithInt(button.tag);
            [arr addObject:num];
        }
    }
    if(_delegate && [_delegate respondsToSelector:@selector(SSGestureLockerViewDidSetFinished:)]){
        [_delegate SSGestureLockerViewDidSetFinished:arr];
    }
}








@end
