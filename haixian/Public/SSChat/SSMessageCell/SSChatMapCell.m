//
//  SSChatMapCell.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatMapCell.h"

@implementation SSChatMapCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mMapBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.mMapBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:self.mMapBtn];
    [self.mMapBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

    ///初始化地图
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc] initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height)];
    [_mMapBtn addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.userInteractionEnabled = YES;
    
}


-(void)setLayout:(SSChatModelLayout *)layout{
    
    [super setLayout:layout];
    
    self.mMapBtn.frame = layout.btnRect;
    [self.mMapBtn setBackgroundImage:layout.btnImage forState:UIControlStateNormal];
    [self.mMapBtn setBackgroundImage:layout.btnImage forState:UIControlStateHighlighted];
    
    _mapView.frame = _mMapBtn.bounds;
    [self makeMaskView:_mapView withImage:layout.btnImage];
    
}


- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}


//点击地图回调
-(void)buttonPressed:(UIButton *)sender{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatBaseCellBtnClick:index:messageType:)]){
        [self.delegate SSChatBaseCellBtnClick:self.indexPath index:sender.tag messageType:SSChatMessageTypeMap];
    }
}





@end
