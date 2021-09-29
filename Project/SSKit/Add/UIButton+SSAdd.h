//
//  UIButton+SSAdd.h
//  DEShop
//
//  Created by soldoros on 2017/4/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SSAdd)



/**
 按钮图文垂直居中

 @param heightSpace 图片离按钮顶部距离
 @param distance 距离
 
 这里是批量处理按钮排版  因为按钮默认是从第一个开始排布 后面如果文字长度不一致 会导致图片偏离
 */
-(void)setBtnCenterHeight:(CGFloat)heightSpace distTance:(CGFloat)distance;



/**
 文字居左 图片居右

 @param button 需要调整的按钮
 */
+(void)textImage:(UIButton *)button;




//设置按钮图片的拉伸保护区域 添加的状态
-(void)setButtonTensileImage:(NSString *)imgString width:(CGFloat)width state:(UIControlState)state;







@end
