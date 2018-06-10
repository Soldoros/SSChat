//
//  SSChatLocationController.m
//  htcm1
//
//  Created by soldoros on 2018/5/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatLocationController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface SSChatLocationController ()<AMapLocationManagerDelegate>

@property(nonatomic,strong)AMapLocationManager *locationManager;

@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property(nonatomic,strong)NSString *address;

@end

@implementation SSChatLocationController

-(instancetype)init{
    if(self = [super init]){
        _latitude = 0;
        _longitude = 0;
        _address = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"位置"];
    [self setRightOneBtnTitle:@"发送"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ///初始化地图
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height)];
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    _locationManager.distanceFilter = 20;
    [self.locationManager startUpdatingLocation];
    
}

//接收位置更新,实现AMapLocationManagerDelegate代理的amapLocationManager:didUpdateLocation方法，处理位置更新
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode){
        NSLog(@"reGeocode:%@", reGeocode);
        
        _latitude = location.coordinate.latitude;
        _longitude = location.coordinate.longitude;
        _address = makeMoreStr(reGeocode.formattedAddress,reGeocode.country,reGeocode.province,reGeocode.city,reGeocode.district,reGeocode.street,reGeocode.number,nil);
    }
}


//取消
-(void)leftBtnCLick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//发送
-(void)rightBtnClick{
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatLocationControllerSendLatitude:longitude:address:)]){
        [_delegate SSChatLocationControllerSendLatitude:_latitude longitude:_longitude address:_address];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}









@end
