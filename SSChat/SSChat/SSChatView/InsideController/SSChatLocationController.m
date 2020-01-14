//
//  SSChatLocationController.m
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SSChatLocationController ()<CLLocationManagerDelegate,MKMapViewDelegate>

//地图
@property(nonatomic,strong)MKMapView *mMapView;

//定位
@property(nonatomic,strong)CLLocationManager *locationManager;

//返回数据
@property(nonatomic,strong)NSDictionary *locationDic;
@property(nonatomic,strong)NSError *error;


@end

@implementation SSChatLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"定位";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.bounds = CGRectMake(0, 0, 50, 35);
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    //初始化地图
    _mMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, SafeAreaTop_Height , SCREEN_Width, SCREEN_Height-SafeAreaTop_Height)];
    _mMapView.delegate = self;
    _mMapView.mapType = MKMapTypeStandard;
    _mMapView.showsUserLocation = YES;
    _mMapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:_mMapView];

    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager requestAlwaysAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10.0;
    _locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];
    
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    //获取最新位置
    CLLocation *location = [locations lastObject];
    
    //根据最新位置,进行地理反编码
    CLGeocoder *gecoder = [CLGeocoder new];
    
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //获取用户当前位置信息
        NSString *userLocationInfo = [[placemarks lastObject] name];
        NSLog(@"%@",userLocationInfo);
        
        self.error = error;
        self.locationDic = @{@"lat":@(location.coordinate.latitude),
                         @"lon":@(location.coordinate.longitude),
                         @"address":userLocationInfo};

        [self.mMapView setCenterCoordinate:location.coordinate animated:YES];
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
    
}



//确定
-(void)rightBtnClick{
    
    self.locationBlock(_locationDic,_error);
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
