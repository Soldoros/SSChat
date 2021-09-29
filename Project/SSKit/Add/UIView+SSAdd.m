//
//  UIView+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "UIView+SSAdd.h"

@implementation UIView (DEAdd)


//根据响应链找到控制器（视图必须依附在一个控制器上）
-(UIViewController *)getViewController{
    id next = [self nextResponder];
    int number = 0;
    while(![next isKindOfClass:[UIViewController class]] && number < 2000){
        next = [next nextResponder];
        number ++;
    }
    if ([next isKindOfClass:[UIViewController class]]){
        return (UIViewController *)next;
    }else{
        return nil;
    }
}

//出场动画
+(void)animateIn:(UIView *)animateView
{
    animateView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.2 animations:^{
        animateView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0/15.0 animations:^{
            animateView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1.0/7.5 animations:^{
                animateView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}


//入场动画
+(void)animateOut:(UIView *)animateView
{
    [UIView animateWithDuration:1.0/7.5 animations:^{
        animateView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0/15.0 animations:^{
            animateView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                animateView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished)
             {
                 [animateView removeFromSuperview];
             }];
        }];
    }];
}



//给按钮设置菊花展示
-(void)addActivityOnBtn{
    [self addActivityOnBtn:[UIColor whiteColor] scale:0.85];
}

-(void)addActivityOnBtn:(UIColor *)color scale:(CGFloat)scale{
    
    UIButton *button;
    if([self isKindOfClass:[UIButton class]]){
        button = (UIButton *)self;
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }
    

    UIActivityIndicatorView *addFriendActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:button.bounds];
    [addFriendActivityIndicator setUserInteractionEnabled:YES];
    [addFriendActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [addFriendActivityIndicator setColor:color];
    [button addSubview:addFriendActivityIndicator];
    [addFriendActivityIndicator startAnimating];

    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    addFriendActivityIndicator.transform = transform;
    
}

//按钮菊花停止展示 并显示文字
-(void)closeActivityByBtn:(NSString *)title{
    
    if([self isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)self;
        button.titleLabel.hidden = NO;
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[UIActivityIndicatorView class]]){
            UIActivityIndicatorView *act = (UIActivityIndicatorView *)view;
            [act stopAnimating];
            [act removeFromSuperview];
            act = nil;
        }
    }
}


//按钮菊花停止展示 并显示图片
-(void)closeActivityByBtnImg:(NSString *)img{
    
    if([self isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)self;
        button.titleLabel.hidden = NO;
        [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    }
    
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[UIActivityIndicatorView class]]){
            UIActivityIndicatorView *act = (UIActivityIndicatorView *)view;
            [act stopAnimating];
            [act removeFromSuperview];
            act = nil;
        }
    }
}


//=========================================
//显示部分
//=========================================


//默认选择了系统的 时间为1秒
-(void)showTime:(NSString *)message{
    [self showTimeBlack:message];
    
}


//显示黑色半透明提示
-(void)showTimeBlack:(NSString *)string{
    
    UIImageView *imgView = [UIImageView new];
    imgView.bounds = makeRect(0, 0, SCREEN_Width*0.55, SCREEN_Width*0.55*0.3);
    imgView.centerX = SCREEN_Width * 0.5;
    imgView.bottom = self.height * 0.5;
    imgView.image = [UIImage imageNamed:@"showtime"];
    [self addSubview:imgView];
    
    UILabel *lab = [UILabel new];
    lab.frame = imgView.bounds;
    lab.width = imgView.width - 20;
    lab.centerX = imgView.width*0.5;
    [imgView addSubview:lab];
    lab.font = makeFont(14);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 2;
    lab.text = string;
    
    [UIView animateIn:imgView];
    
    
    double time = 1.5;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            imgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [imgView removeFromSuperview];
        }];
        
    });
    
}

//全部阴影0  上1  下2  左3  右4
-(void)setShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius option:(NSInteger)option{
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    
    float shadowSize = self.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(-shadowSize/2, - shadowSize/2, self.bounds.size.width + shadowSize, self.bounds.size.height + shadowSize);
    
    //上面阴影
    if(option == 1){
        shadowRect = CGRectMake(0, 0, self.bounds.size.width, shadowSize);
    }
    //下面阴影
    if(option == 2){
        shadowRect = CGRectMake(0, 0 - shadowSize/2.0, self.bounds.size.width, shadowSize);
    }
    //左边阴影
    if(option == 3){
        shadowRect = CGRectMake(0, 0 - shadowSize/2.0, self.bounds.size.width, shadowSize);
    }
    //右边阴影
    if(option == 4){
        shadowRect = CGRectMake(0, 0 - shadowSize/2.0, self.bounds.size.width, shadowSize);
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
    
//        switch type {
//                case .all:
//                    shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
//                case .top:
//                    shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
//                case .bottom:
//                    shadowRect = CGRect.init(x: -shadowSize, y: bounds.size.height - shadowSize, width: bounds.size.width + 2 * shadowSize, height: 2 * shadowSize)
//                case .left:
//                    shadowRect = CGRect.init(x: -shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
//                case .right:
//                    shadowRect = CGRect.init(x: bounds.size.width - shadowSize, y: -shadowSize, width: 2 * shadowSize, height: bounds.size.height + 2 * shadowSize)
//                }
}


-(void)layerWith:(CGRect)frame color:(UIColor *)color1 color2:(UIColor *)color2 point1:(CGPoint)point1 point2:(CGPoint)point2{
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = point1;
    gl.endPoint = point2;
    gl.colors = @[(__bridge id)color1.CGColor,(__bridge id)color2.CGColor];
    gl.locations = @[@(0),@(1.0f)];
    [self.layer addSublayer:gl];
}

@end
