//
//  UIButton+SSAdd.m
//  DEShop
//
//  Created by soldoros on 2017/4/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "UIButton+SSAdd.h"

@implementation UIButton (SSAdd)






//按钮图文垂直居中分布
-(void)setBtnCenterHeight:(CGFloat)heightSpace distTance:(CGFloat)distance{
    
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    imgViewSize = self.imageView.bounds.size;
    titleSize = self.titleLabel.bounds.size;
    btnSize = self.bounds.size;

    
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width + distance*0.5);
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    [self setImageEdgeInsets:imageViewEdge];
    [self setTitleEdgeInsets:titleEdge];
}



//文字居左 图片居右
+(void)textImage:(UIButton *)button{
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.size.width, 0, button.imageView.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width+5, 0, -button.titleLabel.bounds.size.width)];
}



//设置按钮图片的拉伸保护区域
-(void)setButtonTensileImage:(NSString *)imgString width:(CGFloat)width state:(UIControlState)state{
 
    UIImage *image = [UIImage imageWithImage:imgString width:width];
    [self setBackgroundImage:image forState:state];
}








@end
