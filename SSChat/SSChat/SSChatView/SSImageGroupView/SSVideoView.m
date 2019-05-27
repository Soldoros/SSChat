//
//  SSVideoView.m
//  SSChatView
//
//  Created by soldoros on 2018/10/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import "SSVideoView.h"


//播放视频的图层 100%透明 添加所有控件和点击手势
@implementation SSVideoImageLayer

-(instancetype)initWithItem:(SSImageGroupItem *)item{
    if(self = [super init]){
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        _item = item;
        _currentTime = 0.0;
        _totalTime = 0.0;
        _allHidden = NO;
        
        NIMVideoObject *videoObject = _item.chatMessage.videoObject;
        
        UIImage *videoImage = [UIImage imageWithContentsOfFile:videoObject.coverPath];
        if(videoImage){
            _mBackImage = videoImage;
            self.image = _mBackImage;
        }else{
            NSURL *url = [NSURL URLWithString:videoObject.coverUrl];
            __weak SSVideoImageLayer *weakSelf = self;
            [self setImageWithURL:url placeholder:[UIImage imageFromColor:CellLineColor] options:YYWebImageOptionAllowBackgroundTask completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                weakSelf.mBackImage = image;
            }];
        }
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureRecognizerPressed:)];
        gesture.numberOfTapsRequired = 1;
        gesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:gesture]; 
        
        _mBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mBackButton.bounds = CGRectMake(0, 0, 60, 40);
        _mBackButton.tag = 100;
        [self addSubview:_mBackButton];
        [_mBackButton setTitle:@"返回" forState:UIControlStateNormal];
        [_mBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
        
        
        _playSlider = [UISlider new];
        _playSlider.bounds = CGRectMake(0, 0,self.width-165 , 20);
        _playSlider.minimumValue = 0;
        _playSlider.maximumValue = 1;
        _playSlider.value = 0;
        _playSlider.minimumTrackTintColor = [UIColor lightGrayColor];
        _playSlider.maximumTrackTintColor = [UIColor blueColor];
        [_playSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        _playSlider.continuous = YES;
        [self addSubview:_playSlider];
        

        
        _currenTimeLab = [UILabel new];
        _currenTimeLab.bounds = CGRectMake(0, 0, 50, 25);
        _currenTimeLab.textColor = [UIColor whiteColor];
        _currenTimeLab.textAlignment = NSTextAlignmentCenter;
        _currenTimeLab.font = [UIFont systemFontOfSize:10];
        _currenTimeLab.text = @"00:00";
        [_currenTimeLab sizeToFit];
        [self addSubview:_currenTimeLab];
   
        _totalTimeLab = [UILabel new];
        _totalTimeLab.bounds = CGRectMake(0, 0, 50, 25);
        _totalTimeLab.textColor = [UIColor whiteColor];
        _totalTimeLab.textAlignment = NSTextAlignmentCenter;
        _totalTimeLab.font = [UIFont systemFontOfSize:10];
        _totalTimeLab.text = @"00:00";
        [_totalTimeLab sizeToFit];
        [self addSubview:_totalTimeLab];

        
        [self setNewFrameWithDeviceoRientation];
    }
    return self;
}

-(void)showAllControl{
    
    _allHidden = NO;
    _mBackButton.hidden = NO;
    _playCenterButton.hidden = NO;
    _playLeftButton.hidden = NO;
    _playSlider.hidden = NO;
    _currenTimeLab.hidden = NO;
    _totalTimeLab.hidden = NO;
}

-(void)hiddenAllControl{
    
    _allHidden = YES;
    _mBackButton.hidden = YES;
    _playCenterButton.hidden = YES;
    _playLeftButton.hidden = YES;
    _playSlider.hidden = YES;
    _currenTimeLab.hidden = YES;
    _totalTimeLab.hidden = YES;
}

//刷新控件的位置
-(void)setNewFrameWithDeviceoRientation{
    
    _mBackButton.left = 10;
    _mBackButton.top = 20;
    
    _playCenterButton.centerX = self.width*0.5;
    _playCenterButton.centerY = self.height*0.5;
    
    _playLeftButton.left = 15;
    _playLeftButton.bottom = self.height-10;
    
    _playSlider.bounds = CGRectMake(0, 0,self.width-165 , 20);
    _playSlider.left = _playLeftButton.right+45;
    _playSlider.centerY = _playLeftButton.centerY;
    
    _currenTimeLab.centerY = _playLeftButton.centerY;
    _currenTimeLab.right = _playSlider.left - 10;
   
    _totalTimeLab.centerY = _playLeftButton.centerY;
    _totalTimeLab.left = _playSlider.right + 10;
}

//根据时间设置显示和进度条状态
-(void)setPeriodicTimeAndProgress{
    
    _playSlider.minimumValue = 0;
    _playSlider.maximumValue = _totalTime;
    _playSlider.value = _currentTime;
    
    //当前播放的时间
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:_currentTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    _currenTimeLab.text =  [dateFormatter stringFromDate: detaildate];
    [_currenTimeLab sizeToFit];
    _currenTimeLab.centerY = _playLeftButton.centerY;
    _currenTimeLab.right = _playSlider.left - 10;
    
    //视频的总时间
    NSDate *detaildate2=[NSDate dateWithTimeIntervalSince1970:_totalTime];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"mm:ss"];
    _totalTimeLab.text =  [dateFormatter2 stringFromDate: detaildate2];
    [_totalTimeLab sizeToFit];
    _totalTimeLab.centerY = _playLeftButton.centerY;
    _totalTimeLab.left = _playSlider.right + 10;
    
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

        _playerLayer = [AVPlayerLayer new];
        _playerLayer.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
        [self.layer addSublayer:_playerLayer];
        
        //播放完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
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
            
            [self moviePlayDidEnd];
        }
            break;
        default:
            break;
    }
}

-(void)playWithVideoLocalPath{
    
    NSString *url = _item.chatMessage.videoObject.url;
    NSString *path = _item.chatMessage.videoObject.path;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        cout(@"视频已经下载，直接播放");
        _mVideoImagelayer.image = nil;
        [self voidePlay];
        return;
    }
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.size = CGSizeMake(80, 80);
    indicator.center = CGPointMake(self.width / 2, self.height / 2);
    indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    indicator.clipsToBounds = YES;
    indicator.layer.cornerRadius = 6;
    [indicator startAnimating];
    [self addSubview:indicator];
    
    self.userInteractionEnabled = NO;
    [_mVideoImagelayer hiddenAllControl];
    
    [[NIMSDK sharedSDK].resourceManager download:url filepath:path progress:^(float progress) {
        cout(@(progress));
    } completion:^(NSError *error) {
        [indicator removeFromSuperview];
        [self.mVideoImagelayer showAllControl];
        self.userInteractionEnabled = YES;
        if(error){
            [self showTimeBlack:@"视频下载失败 请检查网络"];
        }else{
            self.mVideoImagelayer.image = nil;
            [self voidePlay];
        }
    }];
   
}

-(void)voidePlay{
    
    if(_player == nil){
        
        NSString *path = _item.chatMessage.videoObject.path;
        NSURL *playUrl = [NSURL fileURLWithPath:path];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:playUrl];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        _playerLayer.player = _player;
    }
    
    [_player play];
    self.mVideoImagelayer.status = SSVideoLayerValue3;
    [self addPeriodicTime];
}


//获取播放的时间 开始播放
-(void)addPeriodicTime{
    
    
    __block SSVideoView *weakSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        cout(@(CMTimeGetSeconds(weakSelf.player.currentItem.asset.duration)));
        weakSelf.mVideoImagelayer.currentTime = (NSTimeInterval)CMTimeGetSeconds(time);
        weakSelf.mVideoImagelayer.totalTime = (NSTimeInterval)CMTimeGetSeconds(weakSelf.player.currentItem.asset.duration);
        [weakSelf.mVideoImagelayer setPeriodicTimeAndProgress];
        
    }];
    
}

//播放完成
-(void)moviePlayDidEnd{
    
    [_player seekToTime:CMTimeMake(0, 1) completionHandler:^(BOOL finished) {
        [self.player pause];
        self.mVideoImagelayer.status = SSVideoLayerValue7;
    }];
}

//图层按钮点击回调 返回100   中间播放50  左下角播放10
-(void)SSVideoImageLayerButtonClick:(UIButton *)sender item:(SSImageGroupItem *)item{

    if(sender.tag==100){
        if(_player){
            [_player seekToTime:CMTimeMake(0, 1) completionHandler:^(BOOL finished) {
                [self.player pause];
                self.mVideoImagelayer.status = SSVideoLayerValue7;
                if(self.videoViewDelegate && [self.videoViewDelegate respondsToSelector:@selector(SSVideoViewImageButtonClick:item:)]){
                    [self.videoViewDelegate SSVideoViewImageButtonClick:sender item:item];
                }
            }];
        }else{
            if(self.videoViewDelegate && [self.videoViewDelegate respondsToSelector:@selector(SSVideoViewImageButtonClick:item:)]){
                [self.videoViewDelegate SSVideoViewImageButtonClick:sender item:item];
            }
        }
    }
    else{
        
        if(sender.tag==50 || sender.tag==10){
            if(sender.selected==NO){
                [_player pause];
            }else{
                
                [self playWithVideoLocalPath];
            }
        }
        
    }
}


//进度条拖动回调
-(void)SSVideoImageLayerSliderEventValueChanged:(UISlider *)slider item:(SSImageGroupItem *)item{

    if (_player.status == AVPlayerStatusReadyToPlay){
        NSTimeInterval duration = CMTimeGetSeconds(_player.currentItem.duration);
         CMTime seekTime = CMTimeMake(duration, 1);
        [_player seekToTime:seekTime completionHandler:^(BOOL finished) {
           
            
        }];
        
        _mVideoImagelayer.currentTime = slider.value*0.1*duration;
        [_mVideoImagelayer setPeriodicTimeAndProgress];
        
//        [_player seekToTime:CMTimeMake(slider.value*0.1*duration,1)];
    }
    
    
}



//监听回调 加载 状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSTimeInterval loadedTime = [self availableDurationWithplayerItem:playerItem];
        NSTimeInterval totalTime = CMTimeGetSeconds(playerItem.duration);
        
        cout(@(loadedTime));
        cout(@(totalTime));
        
    }else if ([keyPath isEqualToString:@"status"]){
        
    }
}


// 计算缓冲总进度
- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem{
    
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}


@end
