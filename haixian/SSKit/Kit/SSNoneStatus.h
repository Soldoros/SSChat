//
//  SSNoneStatus.h
//  DEShop
//
//  Created by soldoros on 2017/5/31.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+NetWorking.h"


@protocol SSNoneStatusDelegate <NSObject>

-(void)SSNoneStatusBtnClick:(HtmcNetworkingStatus)style;

@end

@interface SSNoneStatus : UIView

@property(nonatomic,assign)id<SSNoneStatusDelegate>delegate;
@property(nonatomic,assign) HtmcNetworkingStatus noneStyle;

//图片  提示信息  按钮文字
@property(nonatomic,strong)NSString    *imgString;
@property(nonatomic,strong)NSString    *labString;
@property(nonatomic,strong)NSString    *btnString;

@property(nonatomic,strong)UIImageView *mImgView;
@property(nonatomic,strong)UILabel *mLabel;
@property(nonatomic,strong)UIButton *mButton;


//进度指示器
@property(nonatomic,strong)UIActivityIndicatorView *mActivity;





@end
