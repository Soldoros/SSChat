//
//  AC_ProgressSlider.m
//  AC_AVPlayer
//
//  Created by FM-13 on 16/6/12.
//  Copyright © 2016年 cong. All rights reserved.
//

#import "AC_ProgressSlider.h"

#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface AC_ProgressSlider ()

@property (nonatomic, strong) UIColor *lineColor;//整条线的颜色
@property (nonatomic, strong) UIColor *slidedLineColor;//滑动过的线的颜色
@property (nonatomic, strong) UIColor *progressLineColor;//预加载线的颜色
@property (nonatomic, strong) UIColor *circleColor;//圆的颜色

@property (nonatomic, assign) CGFloat lineWidth;//线的宽度
@property (nonatomic, assign) CGFloat circleRadius;//圆的半径


@end

@implementation AC_ProgressSlider

- (id)initWithFrame:(CGRect)frame direction:(AC_SliderDirection)direction{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _minValue = 0;
        _maxValue = 1;
        
        _direction = direction;
        _lineColor = [UIColor whiteColor];
        _slidedLineColor = RGBColor(254, 64, 22, 1);
        _circleColor = RGBColor(254, 64, 22, 1);
        _progressLineColor = [UIColor grayColor];
        
        _sliderPercent = 0.0;
        _lineWidth = 2;
        _circleRadius = 8;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画总体的线
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);//画笔颜色
    CGContextSetLineWidth(context, _lineWidth);//线的宽度
    
    CGFloat startLineX = (_direction == AC_SliderDirectionHorizonal ? _circleRadius : (self.frame.size.width - _lineWidth) / 2);
    CGFloat startLineY = (_direction == AC_SliderDirectionHorizonal ? (self.frame.size.height - _lineWidth) / 2 : _circleRadius);//起点
    
    CGFloat endLineX = (_direction == AC_SliderDirectionHorizonal ? self.frame.size.width - _circleRadius : (self.frame.size.width - _lineWidth) / 2);
    CGFloat endLineY = (_direction == AC_SliderDirectionHorizonal ? (self.frame.size.height - _lineWidth) / 2 : self.frame.size.height- _circleRadius);//终点
    
    CGContextMoveToPoint(context, startLineX, startLineY);
    CGContextAddLineToPoint(context, endLineX, endLineY);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    
    //绘制缓冲进度的线
    CGContextSetStrokeColorWithColor(context, _progressLineColor.CGColor);//画笔颜色
    CGContextSetLineWidth(context, _lineWidth);//线的宽度
    
    CGFloat progressLineX = (_direction == AC_SliderDirectionHorizonal ? MAX(_circleRadius, (_progressPercent * self.frame.size.width - _circleRadius)) : startLineX);
    
    CGFloat progressLineY = (_direction == AC_SliderDirectionHorizonal ? startLineY : MAX(_circleRadius, (_progressPercent * self.frame.size.height - _circleRadius)));
    
    CGContextMoveToPoint(context, startLineX, startLineY);
    CGContextAddLineToPoint(context, progressLineX, progressLineY);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    
    //画已滑动进度的线
    CGContextSetStrokeColorWithColor(context, _slidedLineColor.CGColor);//画笔颜色
    CGContextSetLineWidth(context, _lineWidth);//线的宽度
    
    CGFloat slidedLineX = (_direction == AC_SliderDirectionHorizonal ? MAX(_circleRadius, (_sliderPercent * (self.frame.size.width - 2*_circleRadius) + _circleRadius)) : startLineX);
    
    CGFloat slidedLineY = (_direction == AC_SliderDirectionHorizonal ? startLineY : MAX(_circleRadius, (_sliderPercent * self.frame.size.height - _circleRadius)));
    
    CGContextMoveToPoint(context, startLineX, startLineY);
    CGContextAddLineToPoint(context, slidedLineX, slidedLineY);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //外层圆
    CGFloat penWidth = 1.f;
    CGContextSetStrokeColorWithColor(context, _circleColor.CGColor);//画笔颜色
    CGContextSetLineWidth(context, penWidth);//线的宽度
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);//填充颜色
    
    CGContextSetShadow(context, CGSizeMake(1, 1), 1.f);//阴影
    
    CGFloat circleX = (_direction == AC_SliderDirectionHorizonal ? MAX(_circleRadius + penWidth, slidedLineX - penWidth ) : startLineX);
    CGFloat circleY = (_direction == AC_SliderDirectionHorizonal ? startLineY : MAX(_circleRadius + penWidth, slidedLineY - penWidth));
    CGContextAddArc(context, circleX, circleY, _circleRadius, 0, 2 * M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    
    
    //内层圆
    CGContextSetStrokeColorWithColor(context, nil);
    CGContextSetLineWidth(context, 0);
    CGContextSetFillColorWithColor(context, _circleColor.CGColor);
    CGContextAddArc(context, circleX, circleY, _circleRadius / 2, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

#pragma mark 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enabled) {
        return;
    }
    [self updateTouchPoint:touches];
    [self callbackTouchEnd:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enabled) {
        return;
    }
    [self updateTouchPoint:touches];
    [self callbackTouchEnd:NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enabled) {
        return;
    }
    [self updateTouchPoint:touches];
    [self callbackTouchEnd:YES];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enabled) {
        return;
    }
    [self updateTouchPoint:touches];
    [self callbackTouchEnd:YES];
}


- (void)updateTouchPoint:(NSSet*)touches {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    self.sliderPercent = (_direction == AC_SliderDirectionHorizonal ? touchPoint.x : touchPoint.y) / (_direction == AC_SliderDirectionHorizonal ? self.frame.size.width : self.frame.size.height);
}

- (void)setSliderPercent:(CGFloat)sliderPercent {
    if (_sliderPercent != sliderPercent) {
        _sliderPercent = sliderPercent;
        
        self.value = _minValue + sliderPercent * (_maxValue - _minValue);
    }
}

- (void)setProgressPercent:(CGFloat)progressPercent
{
    if (_progressPercent != progressPercent) {
        _progressPercent = progressPercent;
        [self setNeedsDisplay];
    }
}

- (void)setValue:(CGFloat)value {
    
    if (value != _value) {
        if (value < _minValue) {
            _value = _minValue;
            return;
        } else if (value > _maxValue) {
            _value = _maxValue;
            return;
        }
        _value = value;
        _sliderPercent = (_value - _minValue)/(_maxValue - _minValue);
        [self setNeedsDisplay];
    }
}


- (void)callbackTouchEnd:(BOOL)isTouchEnd {
    _isSliding = !isTouchEnd;
    if (isTouchEnd == YES) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
