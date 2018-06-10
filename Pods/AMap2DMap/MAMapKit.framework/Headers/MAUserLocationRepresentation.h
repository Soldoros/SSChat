//
//  MAUserLocationRepresentation.h
//  MAMapKitNew
//
//  Created by AutoNavi.
//  Copyright (c) 2014年 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///用户位置显示样式控制
@interface MAUserLocationRepresentation : NSObject

///标注图片。若设置为nil，则为默认图片。
@property (nonatomic, strong) UIImage *image;

///是否显示精度圈。默认为YES
@property (nonatomic, assign) BOOL showsAccuracyRing;

///是否显示方向指示( MAUserTrackingModeFollowWithHeading 模式开启)。默认为YES
@property (nonatomic, assign) BOOL showsHeadingIndicator;

///精度圈边线宽度,默认是2
@property (nonatomic, assign) CGFloat lineWidth;

///精度圈填充颜色
@property (nonatomic, strong) UIColor *fillColor;

///精度圈边线颜色
@property (nonatomic, strong) UIColor *strokeColor;

///边线虚线样式, 默认是nil
@property (nonatomic, copy) NSArray *lineDashPattern;

@end
