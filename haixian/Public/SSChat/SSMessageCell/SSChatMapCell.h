//
//  SSChatMapCell.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface SSChatMapCell : SSChatBaseCell

@property(nonatomic,strong) UIButton *mMapBtn;
@property(nonatomic,strong) MAMapView *mapView;

@end
