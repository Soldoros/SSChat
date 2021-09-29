//
//  SSRequestLoadingStatus.m
//  htcm
//
//  Created by soldoros on 2018/7/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import "SSRequestLoadingStatus.h"

@implementation SSRequestLoadingStatus


//加载中
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        _superView = superView;
        [_superView addSubview:self];
        
        _mActivity=[[UIActivityIndicatorView alloc]initWithFrame:makeRect(0, 0, 45, 45)];
        _mActivity.centerX=self.width*0.5;
        _mActivity.centerY = self.height*0.5-50;
        [_mActivity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        _mActivity.color = makeColorHex(@"#999999");
        [_mActivity setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_mActivity];
        [self startLoadingImageAnimation];
        
        
//        _mLoadingLab = [UILabel new];
//         [self addSubview:_mLoadingLab];
//        _mLoadingLab.bounds = makeRect(0, 0, 32, 32);
//        _mLoadingLab.centerX = self.width*0.5;
//        _mLoadingLab.centerY = self.height*0.5-10;
//        _mLoadingLab.font = makeFont(8);
//        _mLoadingLab.textColor = TitleColor;
//        _mLoadingLab.textAlignment = NSTextAlignmentCenter;
//        _mLoadingLab.text = labString;
//        [_mLabel sizeToFit];
//        _mLabel.width = self.width*0.7;
//        _mLabel.centerX = self.width*0.5;
           
        
    }
    
    return self;
}


//网络或服务器异常的简化版本
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView loadingBlock:(LoadingBlock)loadingBlock{
    
    return [self initWithFrame:frame superView:superView statusCode:SSRequestStatusVaule13 message:@"网络或服务器异常" loadingBlock:loadingBlock];
}

//根据句状态判断
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock{
    return [self initWithFrame:frame superView:superView statusCode:statusCode message:@"暂无数据" loadingBlock:loadingBlock];
}

//数据异常
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView message:(NSString *)message  loadingBlock:(LoadingBlock)loadingBlock{
    return [self initWithFrame:frame superView:superView statusCode:SSRequestStatusVaule13 message:message loadingBlock:loadingBlock];
}


//加载完成后显示的异常信息
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView statusCode:(SSRequestStatusCode)statusCode message:(NSString *)message loadingBlock:(LoadingBlock)loadingBlock{
    
    if(self = [super initWithFrame:frame]){
            self.backgroundColor = BackGroundColor;
            _superView = superView;
            [_superView addSubview:self];
            
            
            //395 * 285
        _mImgView = [UIImageView new];
        _mImgView.bounds = makeRect(0, 0, 250, 200);
        _mImgView.centerX = self.width*0.5;
        _mImgView.bottom = self.height*0.5+50;
        [self addSubview:_mImgView];
        _mImgView.image = [UIImage imageNamed:@"kongshuju"];

        
        _mLabel = [UILabel new];
        _mLabel.bounds = makeRect(0, 0, self.width*0.7, 60);
        _mLabel.top = _mImgView.bottom + 20;
        _mLabel.centerX  = self.width*0.5;
        _mLabel.font = makeFont(14);
        _mLabel.textColor = makeColorHex(@"#999999");
        _mLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mLabel];
        _mLabel.userInteractionEnabled = YES;
        _mLabel.numberOfLines = 3;
           
            
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mButton.bounds = makeRect(0, 0, self.width/3, 25);
        _mButton.centerX = self.centerX;
        _mButton.top = _mImgView.bottom+80;
        [self addSubview:_mButton];
        [_mButton setTitleColor:TitleColor forState:UIControlStateNormal];
        _mButton.layer.borderColor = TitleColor.CGColor;
        _mButton.layer.borderWidth = 1;
        _mButton.clipsToBounds = YES;
        _mButton.layer.cornerRadius = _mButton.height*0.5;
        _mButton.titleLabel.font = makeFont(12);
        _mButton.hidden = YES;

            

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(self.statusCode == SSRequestStatusVaule11){
                return ;
            }else{
                loadingBlock(self.statusCode);
            }
        }];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        self.imgString = @"wangluowenti";
        self.btnString = @"刷新";
        self.labString = message;
        self.statusCode = statusCode;
        
    }
    return self;
}


-(void)startLoadingImageAnimation{
    
    [_mActivity startAnimating];
}

-(void)stopLoadingImageAnimation{
    [_mActivity stopAnimating];
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
    _mLabel.width = self.width*0.7;
    _mLabel.centerX = self.width*0.5;
}


-(void)setStatusCode:(SSRequestStatusCode)statusCode {
    _statusCode = statusCode;
    
    
    switch (_statusCode) {
            
            //正在加载
        case SSRequestStatusVaule11:{
            [self startLoadingImageAnimation];
            _mActivity.hidden = NO;
            _mLoadingLab.hidden = NO;
            _mImgView.hidden = YES;
            _mButton.hidden = YES;
            _mLabel.hidden = YES;
            
        }
            
            break;
            
            //数据为空
        case SSRequestStatusVaule12:{
            [self stopLoadingImageAnimation];
            _mActivity.hidden = YES;
            _mLoadingLab.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
            [self setLabString:@"暂无数据"];
            _mImgView.image = [UIImage imageNamed:@"shujukong"];
        }
            
            break;
            
            //网络或服务器异常
        case SSRequestStatusVaule13:{
            [self stopLoadingImageAnimation];
            _mActivity.hidden = YES;
            _mLoadingLab.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
            [self setLabString:@"网络或服务器异常"];
            _mImgView.image = [UIImage imageNamed:@"wangluowenti"];
        }
            break;
            
                break;
            
            //其他情况
        default:{
            [self stopLoadingImageAnimation];
            _mActivity.hidden = YES;
            _mLoadingLab.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
        }
            break;
    }
    
    self.mButton.hidden = YES;
}



@end
