//
//  SSChatMapCell.h
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SSChatMapCell : SSChatBaseCell<MKMapViewDelegate,CLLocationManagerDelegate>

//顶部地理位置
@property(nonatomic,strong)UIView *mTopView;
@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UILabel *mDetaiLLab;

//分割线
@property(nonatomic,strong)UIView  *mLine;

//底部地图 定位
@property(nonatomic,strong)MKMapView *mMapView;
@property(nonatomic,strong)CLLocationManager *locationManager;


//覆盖按钮
@property(nonatomic,strong)UIButton *mMapButton;

@end



