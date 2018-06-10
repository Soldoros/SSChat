//
//  AC_ProgressSlider.h
//  AC_AVPlayer
//
//  Created by FM-13 on 16/6/12.
//  Copyright © 2016年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef NS_ENUM(NSInteger, AC_SliderDirection){
    AC_SliderDirectionHorizonal  =   0,
    AC_SliderDirectionVertical   =   1
};


@interface AC_ProgressSlider : UIControl


@property (nonatomic, assign) CGFloat minValue;//最小值
@property (nonatomic, assign) CGFloat maxValue;//最大值
@property (nonatomic, assign) CGFloat value;//滑动值
@property (nonatomic, assign) CGFloat sliderPercent;//滑动百分比
@property (nonatomic, assign) CGFloat progressPercent;//缓冲的百分比

@property (nonatomic, assign) BOOL isSliding;//是否正在滑动  如果在滑动的是偶外面监听的回调不应该设置sliderPercent progressPercent 避免绘制混乱

@property (nonatomic, assign) AC_SliderDirection direction;//方向

- (id)initWithFrame:(CGRect)frame direction:(AC_SliderDirection)direction;

@end
