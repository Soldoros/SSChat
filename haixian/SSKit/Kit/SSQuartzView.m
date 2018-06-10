//
//  DEQuartzView.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "SSQuartzView.h"

@implementation DEQuartzView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _width = frame.size.width;
        _height = frame.size.height;
    }
    return self;
}

-(void)setPolygonColor:(UIColor *)polygonColor{
    NSDictionary *colorDic = [polygonColor getRGB];
    _R = [colorDic[@"R"] doubleValue];
    _G = [colorDic[@"G"] doubleValue];
    _B = [colorDic[@"B"] doubleValue];
}


- (void)drawRect:(CGRect)rect
{
    switch (_polygonViewStyle) {
        case PolygonViewTrilateral:
            [self drawTrilateral:rect];
            break;
        case PolygonViewQuadrilateral:
            [self drawTrilateral:rect];
            break;
        case PolygonViewPentagon:
            [self drawTrilateral:rect];
            break;
        case PolygonViewHexagon:
            [self drawHexagon:rect];
            break;
        case PolygonViewOctagon:
            [self drawOctagon:rect];
            break;
        case PolygonViewCircular:
            [self drawCircular:rect];
            break;
        case PolygonViewEllipse:
            [self drawEllipse:rect];
            break;
        default:
            break;
    }
}

//正三边形
-(void)drawTrilateral:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, _R, _G, _B, 1);
    CGContextSetRGBFillColor(ctx, _R, _G, _B, 1);
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, _width / 4, 0);
    CGContextAddLineToPoint(ctx, _width*3/4, 0);
    CGContextAddLineToPoint(ctx, _width, _height/2);
    CGContextAddLineToPoint(ctx, _width*3/4, _height);
    CGContextAddLineToPoint(ctx, _width/4, _height);
    CGContextAddLineToPoint(ctx, 0, _height/2);
    CGContextAddLineToPoint(ctx, _width/4, 0);
    
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

//正方形
-(void)drawQuadrilateral:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, _R, _G, _B, 1);
    CGContextSetRGBFillColor(ctx, _R, _G, _B, 1);
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, _width / 4, 0);
    CGContextAddLineToPoint(ctx, _width*3/4, 0);
    CGContextAddLineToPoint(ctx, _width, _height/2);
    CGContextAddLineToPoint(ctx, _width*3/4, _height);
    CGContextAddLineToPoint(ctx, _width/4, _height);
    CGContextAddLineToPoint(ctx, 0, _height/2);
    CGContextAddLineToPoint(ctx, _width/4, 0);
    
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}


//正五边形
-(void)drawPentagon:(CGRect)rect{
    
}

//正六边形
-(void)drawHexagon:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, _R, _G, _B, 1);
    CGContextSetRGBFillColor(ctx, _R, _G, _B, 1);
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, _width / 4, 0);
    CGContextAddLineToPoint(ctx, _width*3/4, 0);
    CGContextAddLineToPoint(ctx, _width, _height/2);
    CGContextAddLineToPoint(ctx, _width*3/4, _height);
    CGContextAddLineToPoint(ctx, _width/4, _height);
    CGContextAddLineToPoint(ctx, 0, _height/2);
    CGContextAddLineToPoint(ctx, _width/4, 0);
    
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

//正八边形
-(void)drawOctagon:(CGRect)rect{
    
}

//圆形
-(void)drawCircular:(CGRect)rect{
    
}

//椭圆
-(void)drawEllipse:(CGRect)rect{
    
}


@end
