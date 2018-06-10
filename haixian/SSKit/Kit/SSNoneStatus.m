//
//  SSNoneStatus.m
//  DEShop
//
//  Created by soldoros on 2017/5/31.
//  Copyright © 2017年 soldoros. All rights reserved.
//


#import "SSNoneStatus.h"


@implementation SSNoneStatus


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.noneStyle = HtmcNetworkingVaule12;
        
        CGFloat width = self.width;
        CGFloat height = self.height;
        
        
        _mImgView = [UIImageView new];
        _mImgView.bounds = makeRect(0, 0, width*0.3, width*0.3);
        _mImgView.centerX = self.centerX;
        _mImgView.top = 85;
        _mImgView.image = [UIImage imageNamed:@"guanzhuweikong"];
        [self addSubview:_mImgView];
        
        _mLabel = [UILabel new];
        _mLabel.bounds = makeRect(0, 0, width*2/3, 60);
        _mLabel.top = _mImgView.bottom + 35;
        _mLabel.centerX  =self.centerX;
        _mLabel.font = makeFont(15);
        _mLabel.textColor = [UIColor grayColor];
        _mLabel.numberOfLines = 0;
        _mLabel.text = @"暂无任何数据";
        _mLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mLabel];
        
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mButton.bounds = makeRect(0, 0, SCREEN_Width/2, 40);
        _mButton.centerX = self.centerX;
        _mButton.top = _mImgView.bottom+150;
        [self addSubview:_mButton];
        [_mButton setTitle:@"刷新" forState:UIControlStateNormal];
        [_mButton setTitleColor:TitleColor forState:UIControlStateNormal];
        _mButton.layer.borderColor = TitleColor.CGColor;
        _mButton.layer.borderWidth = 1;
        _mButton.clipsToBounds = YES;
        _mButton.layer.cornerRadius = _mButton.height*0.5;
        _mButton.titleLabel.font = makeFont(14);
        [_mButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.mActivity=[[UIActivityIndicatorView alloc]initWithFrame:makeRect(0, 0, 80, 80)];
        self.mActivity.centerX=self.width*0.5;
        self.mActivity.centerY = self.height*0.5-50;
        self.mActivity.clipsToBounds = YES;
        self.mActivity.layer.cornerRadius = 5;
        [self.mActivity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.mActivity setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.mActivity];
        self.mActivity.hidden = YES;
        
    }
    return self;
}

-(void)setHeight:(CGFloat)height{
    self.frame = makeRect(self.left, self.top, self.frame.size.width, height);
}


-(void)setImgString:(NSString *)imgString{
    _mImgView.image = [UIImage imageNamed:imgString];
}

-(void)setBtnString:(NSString *)btnString{
    [_mButton setTitle:btnString forState:UIControlStateNormal];
}

-(void)setLabString:(NSString *)labString{
    _mLabel.text = labString;
    [_mLabel sizeToFit];
    _mLabel.top = _mImgView.bottom + 35;
    _mLabel.centerX  =self.centerX;
}



-(void)setNoneStyle:(HtmcNetworkingStatus)noneStyle{
    _noneStyle = noneStyle;
    NSString *message = [NSString HtmcNetStatus:noneStyle];
    self.labString = message;
    self.btnString = @"点击刷新";
    self.imgString = @"wangluoyichang";

    
    switch (_noneStyle) {
        case HtmcNetworkingVaule11:{
            [_mActivity startAnimating];
            _mActivity.hidden = NO;
            _mImgView.hidden = YES;
            _mButton.hidden = YES;
            _mLabel.hidden = YES;
        }
            
            break;
        case HtmcNetworkingVaule12:{
            [_mActivity stopAnimating];
            _mActivity.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
        }
            
            break;
        case HtmcNetworkingVaule13:{
            [_mActivity stopAnimating];
            _mActivity.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
            self.labString = @"加载异常";
        }
            break;
        default:
            break;
    }
}


-(void)buttonPressed{
    if(_delegate && [_delegate respondsToSelector:@selector(SSNoneStatusBtnClick:)]){
        [_delegate SSNoneStatusBtnClick:_noneStyle];
    }
}



@end
