//
//  SSChatMessagelLayout.m
//  SSChatView
//
//  Created by soldoros on 2018/10/12.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatMessagelLayout.h"
#import "SSChatDatas.h"
#import "SSChatIMEmotionModel.h"


//gif框架 FLAnimatedImageView
//#import <FLAnimatedImageView+WebCache.h>


@implementation SSChatMessagelLayout

//根据模型返回布局
-(instancetype)initWithMessage:(SSChatMessage *)message{
    if(self = [super init]){
        self.message = message;
    }
    return self;
}

-(void)setMessage:(SSChatMessage *)message{
    _message = message;
    
    switch (_message.messageType) {
            
        case SSChatMessageTypeText:
            [self setText];
            break;
        case SSChatMessageTypeImage:
        case SSChatMessageTypeGif:
            [self setImage];
            break;
        case SSChatMessageTypeVoice:
            [self setVoice];
            break;
        case SSChatMessageTypeMap:
            [self setMap];
            break;
        case SSChatMessageTypeVideo:
            [self setVideo];
            break;
        case SSChatMessageTypeRedEnvelope:
            [self setVideo];
            break;
        case SSChatMessageTypeUndo:
            [self setRecallMessage];
            break;
        case SSChatMessageTypeDelete:
            [self setRemoveMessage];
            break;
        default:
            break;
    }
}


//显示文字消息 这个自适应计算有误差 用sizeToFit就比较完美 有好办法告诉我
-(void)setText{
    
    _textLabRect = [NSObject getRectWith:_message.attTextString width:SSChatTextInitWidth];
    
    CGFloat textWidth  = _textLabRect.size.width;
    CGFloat textHeight = _textLabRect.size.height;
    
    if(_message.messageFrom == SSChatMessageFromOther){
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
        _textLabRect.origin.x = SSChatTextLRB;
        _textLabRect.origin.y = SSChatTextTop;
        
    }else{
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-SSChatTextLRB-textWidth-SSChatTextLRS, self.headerImgRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
        _textLabRect.origin.x = SSChatTextLRS;
        _textLabRect.origin.y = SSChatTextTop;
    }
    
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_message.showTime==YES){

       [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + SSChatCellBottom;
    
}


//接收方用下载的大图size
//发送方用本地大图的size
-(void)setImage{
    
    _message.contentMode =  UIViewContentModeScaleAspectFill;
    
    CGFloat imgWidth = _message.imageBody.size.width;
    CGFloat imgHeight = _message.imageBody.size.height;
    
    NSString *imgPath = _message.imageBody.thumbnailLocalPath;
    if (_message.messageFrom == SSChatMessageFromMe && imgPath.length == 0) {
        imgPath = _message.imageBody.localPath;
        UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
        imgWidth = img.size.width;
        imgHeight = img.size.height;
    }
    
    CGFloat imgActualWidth = imgWidth;
    if(imgActualWidth > SSChatImageMaxWidth){
        imgActualWidth = SSChatImageMaxWidth;
    }
    if(imgActualWidth < SSChatImageMinWidth){
        imgActualWidth = SSChatImageMinWidth;
    }

    CGFloat imgActualHeight =  imgActualWidth * imgHeight/imgWidth;
    if(imgActualHeight > SSChatImageMaxHeight){
        imgActualHeight = SSChatImageMaxHeight;
        _message.contentMode =  UIViewContentModeScaleAspectFill;
    }
    
    if(_message.messageFrom == SSChatMessageFromOther){
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, imgActualWidth, imgActualHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
    }else{
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-imgActualWidth, self.headerImgRect.origin.y, imgActualWidth, imgActualHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_message.showTime==YES){
        
       [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + SSChatCellBottom;
    
}


-(void)setVoice{
    
    //计算时间
    NSString *time = makeStrWithInt(_message.voiceBody.duration);
    CGRect rect = [NSObject getRectWith:makeString(time, @"\"") width:150 font:[UIFont systemFontOfSize:SSChatVoiceTimeFont] spacing:0 Row:0];
    CGFloat timeWidth  = rect.size.width;
    CGFloat timeHeight = rect.size.height;
    
    //根据时间设置按钮实际长度
    CGFloat timeLength = SSChatVoiceMaxWidth - SSChatVoiceMinWidth;
    CGFloat changeLength = timeLength/30;
    CGFloat currentLength = changeLength*_message.voiceBody.duration+SSChatVoiceMinWidth;
    if(currentLength > SSChatVoiceMaxWidth){
        currentLength = SSChatVoiceMaxWidth;
    }
    
    if(_message.messageFrom == SSChatMessageFromOther){
        
        _headerImgRect = CGRectMake(SSChatIconLeft, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, currentLength, SSChatVoiceHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);

        _voiceTimeLabRect = CGRectMake(_backImgButtonRect.size.width-timeWidth-10, (_backImgButtonRect.size.height-timeHeight)/2, timeWidth, timeHeight);
        
        _voiceImgRect = CGRectMake(20, (_backImgButtonRect.size.height-SSChatVoiceImgSize)/2, SSChatVoiceImgSize, SSChatVoiceImgSize);
        
    }else{
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-currentLength, self.headerImgRect.origin.y, currentLength, SSChatVoiceHeight);
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
        _voiceTimeLabRect = CGRectMake(10, (_backImgButtonRect.size.height-timeHeight)/2, timeWidth, timeHeight);
        
        _voiceImgRect = CGRectMake(_backImgButtonRect.size.width-SSChatVoiceImgSize-20, (_backImgButtonRect.size.height-SSChatVoiceImgSize)/2, SSChatVoiceImgSize, SSChatVoiceImgSize);
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_message.showTime==YES){
        
       [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + SSChatCellBottom;
    
}


-(void)setMap{
    
    if(_message.messageFrom == SSChatMessageFromOther){
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, SSChatMapWidth, SSChatMapHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
        
    }else{
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-SSChatMapWidth, self.headerImgRect.origin.y, SSChatMapWidth, SSChatMapHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_message.showTime==YES){
        
        [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + SSChatCellBottom;
    
}

//短视频
-(void)setVideo{
    
    EMVideoMessageBody *body = _message.videoBody;
    
    NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
    NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
    NSLog(@"视频的secret -- %@"        ,body.secretKey);
    NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
    NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
    NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
    NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
    // 缩略图sdk会自动下载
    NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
    NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
    NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
    NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
    
    _message.contentMode =  UIViewContentModeScaleAspectFill;
    
    CGFloat imgWidth = _message.videoBody.thumbnailSize.width;
    CGFloat imgHeight = _message.videoBody.thumbnailSize.height;

   
    CGFloat imgActualWidth = imgWidth;
    if(imgActualWidth > SSChatImageMaxWidth){
        imgActualWidth = SSChatImageMaxWidth;
    }
    if(imgActualWidth < SSChatImageMinWidth){
        imgActualWidth = SSChatImageMinWidth;
    }
    
    CGFloat imgActualHeight =  imgActualWidth * imgHeight/imgWidth;
    if(imgActualHeight > SSChatImageMaxHeight){
        imgActualHeight = SSChatImageMaxHeight;
    }
    
    cout(@(imgActualWidth));
    cout(@(imgActualHeight));
    
    if(_message.messageFrom == SSChatMessageFromOther){
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
         _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, imgActualWidth, imgActualHeight);
  
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
    }else{
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-imgActualWidth, self.headerImgRect.origin.y, imgActualWidth, imgActualHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_message.showTime==YES){
        
        [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + SSChatCellBottom;
    
}


//显示支付定金订单信息
-(void)setOrderValue1{
    
    
}

//显示直接购买订单信息
-(void)setOrderValue2{
    
    
}


//撤销的消息
-(void)setRecallMessage{
    
    
}


//删除的消息
-(void)setRemoveMessage{
    
    
    
}




//获取时间的frame值
-(void)getTimeLabRect{
    CGRect timeRect = [NSObject getRectWith:_message.messageTime width:SSChatTimeWidth font:[UIFont systemFontOfSize:SSChatTimeFont] spacing:0 Row:0];
    CGFloat timeWidth = timeRect.size.width+20;
    _timeLabRect = CGRectMake((SCREEN_Width - timeWidth)/2, SSChatTimeTop, timeWidth, SSChatTimeHeight);
}


@end
