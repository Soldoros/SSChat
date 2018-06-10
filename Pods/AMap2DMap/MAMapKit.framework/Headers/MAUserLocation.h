//
//  MAUserLocation.h
//  MAMapKit
//
//  Created by AutoNavi.
//  Copyright (c) 2012年 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAAnnotation.h"

@class CLLocation;
@class CLHeading;

///定位信息类
@interface MAUserLocation : NSObject<MAAnnotation>

///位置更新状态，如果正在更新位置信息，则该值为YES.
@property (nonatomic, readonly, getter = isUpdating) BOOL updating;

///位置信息, 如果MAMapView的showsUserLocation为NO, 或者尚未定位成功, 则该值为nil.
@property (nonatomic, readonly) CLLocation *location;

///heading信息.
@property (nonatomic, readonly) CLHeading *heading;

///定位标注点要显示的标题信息.
@property (nonatomic, copy) NSString *title;

///定位标注点要显示的子标题信息.
@property (nonatomic, copy) NSString *subtitle;

@end

