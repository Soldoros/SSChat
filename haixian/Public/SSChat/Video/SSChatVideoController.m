//
//  SSChatVideoController.m
//  htcm1
//
//  Created by soldoros on 2018/5/14.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//播放视频
#import "SSChatVideoController.h"
#import <AVFoundation/AVFoundation.h>

@interface SSChatVideoController ()

@property(nonatomic,strong)UIImageView   *mVideoImgView;
//最新的视频api
@property(nonatomic,strong)AVPlayer      *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;

//下载视频资源后的本地路径
@property(nonatomic,strong)NSURL *localUrl;


@end

@implementation SSChatVideoController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavgationNil];
    [self setRightOneBtnTitle:@""];
    self.navLine.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn1.bounds = CGRectMake(10, StatuBar_Height, NavBar_Height, NavBar_Height);
    self.leftBtn1.left = 15;
    self.leftBtn1.top = StatuBar_Height;
    [self.leftBtn1 setTitleColor:TitleColor forState:UIControlStateNormal];
    self.leftBtn1.titleLabel.font = makeFont(16);
    [self.leftBtn1 addTarget:self action:@selector(leftBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn1];
    [self.leftBtn1 setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    
    
    self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height+30, NavBar_Height);
    self.rightBtn1.showsTouchWhenHighlighted=YES;
    self.rightBtn1.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
    self.rightBtn1.right = self.navtionImgView.width-15;
    self.rightBtn1.top = StatuBar_Height;
    self.rightBtn1.selected = NO;
    [self.rightBtn1 addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightBtn1];
    self.rightBtn1.titleLabel.font = makeFont(16);
    self.rightBtn1.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.rightBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.rightBtn1 setTitle:@"重播" forState:UIControlStateNormal];
    
    
    _mVideoImgView = [UIImageView new];
    _mVideoImgView.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Width);
    _mVideoImgView.centerX = SCREEN_Width*0.5;
    _mVideoImgView.centerY = SCREEN_Height*0.5;
    [self.view addSubview:_mVideoImgView];
    _mVideoImgView.backgroundColor = [UIColor grayColor];
    _mVideoImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_mVideoImgView sd_setImageWithURL:[NSURL fileURLWithPath:_layout.model.thumbnailLocalPath] placeholderImage:[UIImage imageFromColor:[UIColor grayColor]]];
    
    
    _playerLayer = [[AVPlayerLayer alloc]init];
    _playerLayer.frame = _mVideoImgView.bounds;
    [_mVideoImgView.layer addSublayer:_playerLayer];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerLayer.backgroundColor = [UIColor clearColor].CGColor;

    if([self isFileExist:_layout.model.videoLocalPath]){
        _localUrl = [NSURL fileURLWithPath:_layout.model.videoLocalPath];
        [self setAVPlayer:_localUrl];
    }
    
    else{
        [self showAlert:@"正在下载视频..."];
        [[EMClient sharedClient].chatManager downloadMessageAttachment:_layout.model.message progress:nil completion:^(EMMessage *message, EMError *error) {
            [self closeAlert];
            if (!error) {
                cout(@"下载成功");
                _playerLayer.backgroundColor = [[UIColor grayColor]CGColor];
                EMVideoMessageBody *body = (EMVideoMessageBody *)message.body;
                _localUrl = [NSURL fileURLWithPath:body.localPath];
                [self setAVPlayer:_localUrl];
            }
            else{
                cout(@"下载失败");
                _localUrl = [NSURL fileURLWithPath:_layout.model.videoLocalPath];
                [self setAVPlayer:_localUrl];
            }
        }];
        
    }
    
}


-(void)setAVPlayer:(NSURL *)videoUrl{
 
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    _player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
    _playerLayer.player = _player;
    [_player play];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    AVPlayerItem *playerItem = (AVPlayerItem *)object;
//
//    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
//        NSTimeInterval loadedTime = [self availableDurationWithplayerItem:playerItem];
//        NSTimeInterval totalTime = CMTimeGetSeconds(playerItem.duration);
//
//        if (!self.slider.isSliding) {
//            self.slider.progressPercent = loadedTime/totalTime;
//        }
//
//        //如果加载的速度比播放速度满
//        if(self.slider.progressPercent>self.slider.sliderPercent){
//            if(_mPlayBtn.selected == NO && _player.rate != 1){
//                [_player play];
//            }
//        }
//
//
//    }else if ([keyPath isEqualToString:@"status"]){
//
//
//    }
}

- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


-(void)rightBtnClick{
   
    [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:_localUrl];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_player replaceCurrentItemWithPlayerItem:playerItem];
    _playerLayer.player = _player;
    [_player play];
}


-(void)leftBtnCLick{
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer=nil;
    self.player=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

//判断文件是否已经在沙盒中已经存在？
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}





@end
