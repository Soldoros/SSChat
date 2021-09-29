//
//  SSVideoView.m
//  SSChatView
//
//  Created by soldoros on 2018/10/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import "SSVideoView.h"
#import "RootTabBarController.h"


//播放视频的图层 100%透明 添加所有控件和点击手势
@implementation SSVideoImageLayer

-(instancetype)initWithItem:(SSImageGroupItem *)item{
    if(self = [super init]){
        self.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Height);
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        _item = item;
        _allHidden = NO;
        self.status = SSVideoLayerValue1;
        
//        self.image = _item.fromImgView.image;
        
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureRecognizerPressed:)];
        gesture.numberOfTapsRequired = 1;
        gesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:gesture];
        
        
        _mBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mBackButton.bounds = CGRectMake(0, 0, 60, 40);
        _mBackButton.tag = 100;
        [self addSubview:_mBackButton];
        [_mBackButton setTitle:@"返回" forState:UIControlStateNormal];
        [_mBackButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_mBackButton addTarget:self action:@selector(buttonPressed:)   forControlEvents:UIControlEventTouchUpInside];
        
        
        _playCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playCenterButton.bounds = CGRectMake(0, 0, 55, 55);
        _playCenterButton.tag  = 50;
        [self addSubview:_playCenterButton];
        [_playCenterButton setImage:[UIImage imageNamed:@"icon_bofang"] forState:UIControlStateNormal];
        [_playCenterButton setImage:[UIImage imageNamed:@"icon_zanting"] forState:UIControlStateSelected];
        [_playCenterButton addTarget:self action:@selector(buttonPressed:)   forControlEvents:UIControlEventTouchUpInside];
        
        _playLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playLeftButton.bounds = CGRectMake(0, 0, 40, 40);
        _playLeftButton.tag = 10;
        [self addSubview:_playLeftButton];
        _playLeftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_playLeftButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playLeftButton setTitle:@"暂停" forState:UIControlStateSelected];
        [_playLeftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playLeftButton addTarget:self action:@selector(buttonPressed:)   forControlEvents:UIControlEventTouchUpInside];
        
        
        [self setNewFrameWithDeviceoRientation];
    }
    return self;
}

-(void)showAllControl{
    
    _allHidden = NO;
    _mBackButton.hidden = NO;
    _playCenterButton.hidden = NO;
    _playLeftButton.hidden = NO;
}

-(void)hiddenAllControl{
    
    _allHidden = YES;
    _mBackButton.hidden = YES;
    _playCenterButton.hidden = YES;
    _playLeftButton.hidden = YES;
}

//刷新控件的位置
-(void)setNewFrameWithDeviceoRientation{
    
    _mBackButton.left = 10;
    _mBackButton.top = StatuBar_Height+30;
    
    _playCenterButton.centerX = self.width*0.5;
    _playCenterButton.centerY = self.height*0.5;
    
    _playLeftButton.left = 15;
    _playLeftButton.bottom = self.height-10;
    
}


//点击图层
-(void)GestureRecognizerPressed:(UITapGestureRecognizer *)gesture{
    if(_allHidden == NO) [self hiddenAllControl];
    else [self showAllControl];
}

//返回100  中间播放暂停50  左下角播放暂停10
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender.tag==50||sender.tag==10){
        if(sender.selected){
            _playCenterButton.selected=NO;
            _playLeftButton.selected=NO;
        }else{
            _playCenterButton.selected=YES;
            _playLeftButton.selected=YES;
        }
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSVideoImageLayerButtonClick:item:)]){
        [_delegate SSVideoImageLayerButtonClick:sender item:_item];
    }
    
}


//播放进度控制
-(void)sliderValueChanged:(UISlider *)slider{
    NSLog(@"当前值：%f",slider.value);
    if(_delegate && [_delegate respondsToSelector:@selector(SSVideoImageLayerSliderEventValueChanged:item:)]){
        [_delegate SSVideoImageLayerSliderEventValueChanged:slider item:_item];
    }
}


-(void)setStatus:(SSVideoLayerStatus)status{
    _status = status;
    
    switch (_status) {
            //未播放静止（播放按钮）
        case SSVideoLayerValue1:{
            
        }
            break;
            //未播放静止+点击了空白处（所有控件）
        case SSVideoLayerValue2:{
            
        }
            break;
            //播放中
        case SSVideoLayerValue3:{
            _playCenterButton.selected = YES;
            _playLeftButton.selected = YES;
        }
            break;
            //播放中+点击了空白处（所有控件）
        case SSVideoLayerValue4:{
            
        }
            break;
            //播放暂停中（所有控件）
        case SSVideoLayerValue5:{
            
        }
            break;
            //播放暂停+点击空白处
        case SSVideoLayerValue6:{
            
        }
            break;
            //播放完毕 （播放按钮）
        case SSVideoLayerValue7:{
            _playCenterButton.selected = NO;
            _playLeftButton.selected = NO;
        }
            break;
            //播放完毕+点击空白处（所有控件）
        case SSVideoLayerValue8:{
            
        }
            break;
            
        default:
            break;
    }
}


@end





//视频视图
@implementation SSVideoView


-(instancetype)initWithItem:(SSImageGroupItem *)item{
    if(self = [super init]){
        self.frame = [UIScreen mainScreen].bounds;
        _item = item;

        
        _mPlayView = [UIView new];
        _mPlayView.frame = self.bounds;
        [self addSubview:_mPlayView];
        
        
        
        _mVideoImagelayer = [[SSVideoImageLayer alloc]initWithItem:_item];
        [self addSubview:_mVideoImagelayer];
        _mVideoImagelayer.delegate = self;
    }
    return self;
}


//设置frame
-(void)setVideoViewFrame:(CGRect)videoViewFrame{
    _videoViewFrame = videoViewFrame;
    self.frame = _videoViewFrame;
    _mVideoImagelayer.frame = self.bounds;
    _playerLayer.frame = self.bounds;
    
    [_mVideoImagelayer setNewFrameWithDeviceoRientation];
}

-(void)setShowType:(SSImageShowType)showType{
    _showType = showType;
    
    switch (_showType) {
            //未展示
        case SSImageShowValue1:{
            
        }
            break;
            //放大展示
        case SSImageShowValue2:{
            cout(@"开始播放");
            [self playWithVideoLocalPath];
        }
            break;
            //滚动展示
        case SSImageShowValue3:{
            
        }
            break;
            //滚动隐藏
        case SSImageShowValue4:{
            
            [self onPreviewFinished];
        }
            break;
        default:
            break;
    }
}


-(void)playWithVideoLocalPath{
    
    NSArray *arr = [_item.videoPath componentsSeparatedByString:@"/"];
    NSString *loc = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    _item.videoLocPath = makeMoreStr(loc,@"/",arr.lastObject,nil);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:_item.videoLocPath]){
        cout(@"视频已经下载，直接播放");
        _mVideoImagelayer.image = nil;
        [self voidePlay];
        return;
    }
    
    self.userInteractionEnabled = NO;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    indicator.size = CGSizeMake(80, 80);
    indicator.center = CGPointMake(self.width / 2, self.height / 2);
    indicator.backgroundColor = [UIColor grayColor];
    indicator.clipsToBounds = YES;
    indicator.layer.cornerRadius = 6;
    [indicator startAnimating];
    [self addSubview:indicator];
    
    //https://jizhu-1256370875.cos.ap-chengdu.myqcloud.com/1606212414_mp4
    ///var/mobile/Containers/Data/Application/0894578E-2F2D-467C-9911-289FA3CB4385/Library/Caches/1606212414_mp4.mp4
    ///var/mobile/Containers/Data/Application/5F6C22A2-547A-40A4-BD56-8D126E05A6BA/Library/Caches
   
    [SSAFRequest downloadWithUrlString:_item.videoPath progressBlock:^(NSProgress *progress) {
        cout(progress);
    } downloadBlock:^(NSString *filePath) {

        [indicator removeFromSuperview];
        
        [self.mVideoImagelayer showAllControl];
        self.userInteractionEnabled = YES;
        
        self.item.videoLocPath = filePath;
        self.mVideoImagelayer.image = nil;
        [self voidePlay];
    }];
    
   
}

-(void)voidePlay{
    
    self.mVideoImagelayer.status = SSVideoLayerValue3;
}

//播放结束
-(void)onPreviewFinished{
    self.mVideoImagelayer.status = SSVideoLayerValue7;
    [_mVideoImagelayer showAllControl];
}


//图层按钮点击回调 返回100   中间播放50  左下角播放10
-(void)SSVideoImageLayerButtonClick:(UIButton *)sender item:(SSImageGroupItem *)item{

    //返回
    if(sender.tag==100){

        if(self.videoViewDelegate && [self.videoViewDelegate respondsToSelector:@selector(SSVideoViewImageButtonClick:item:)]){
            [self.videoViewDelegate SSVideoViewImageButtonClick:sender item:item];
        }
    }
    else{
        
        //暂停 播放
        if(sender.tag==50 || sender.tag==10){
            
            if(sender.selected==NO){

                [_mVideoImagelayer showAllControl];
            }
            
            else{
                
                if(self.mVideoImagelayer.status == SSVideoLayerValue7 ||
                   self.mVideoImagelayer.status == SSVideoLayerValue8 ||
                   self.mVideoImagelayer.status == SSVideoLayerValue1 ||
                   self.mVideoImagelayer.status == SSVideoLayerValue2){
                    [self playWithVideoLocalPath];
                }
                else{

                    self.mVideoImagelayer.status = SSVideoLayerValue3;
                }
                [self performSelector:@selector(hidden) afterDelay:3];
            }
        }
    }
}

-(void)hidden{
    if(self.mVideoImagelayer.status == SSVideoLayerValue3){
        [_mVideoImagelayer hiddenAllControl];
    }
}

@end
