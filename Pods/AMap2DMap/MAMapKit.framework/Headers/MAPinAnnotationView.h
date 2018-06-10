//
//  MAPinAnnotationView.h
//  MAMapKit
//
//  Created by AutoNavi.
//  Copyright (c) 2013年 Amap. All rights reserved.
//

#import "MAAnnotationView.h"

///大头针颜色
typedef NS_ENUM(NSInteger, MAPinAnnotationColor) {
    MAPinAnnotationColorRed = 0,    ///< 红色大头针
    MAPinAnnotationColorGreen,      ///< 绿色大头针
    MAPinAnnotationColorPurple      ///< 紫色大头针
};

///提供类似大头针效果的annotation view
@interface MAPinAnnotationView : MAAnnotationView

///大头针的颜色，有MAPinAnnotationColorRed, MAPinAnnotationColorGreen, MAPinAnnotationColorPurple三种
@property (nonatomic) MAPinAnnotationColor pinColor;

///动画效果
@property (nonatomic) BOOL animatesDrop;

@end
