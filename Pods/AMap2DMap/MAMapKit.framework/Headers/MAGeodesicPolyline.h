//
//  MAGeodesicPolyline.h
//  MapKit_static
//
//  Created by AutoNavi.
//  Copyright (c) 2013年 Amap. All rights reserved.
//

#import "MAPolyline.h"

///大地曲线
@interface MAGeodesicPolyline : MAPolyline

/**
 * @brief 根据map point数据生成Geodesic
 * @param points mapPoint数据,points对应的内存会拷贝,调用者负责该内存的释放
 * @param count mapPoint个数
 * @return 生成的Geodesic
 */
+ (instancetype)polylineWithPoints:(MAMapPoint *)points count:(NSUInteger)count;

/**
 * @brief 根据经纬度坐标数据生成Geodesic
 * @param coords 经纬度坐标数据,coords对应的内存会拷贝,调用者负责该内存的释放
 * @param count 经纬度坐标个数
 * @return 生成的Geodesic
 */
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;

@end
