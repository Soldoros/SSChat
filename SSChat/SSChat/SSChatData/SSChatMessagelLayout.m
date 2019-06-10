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

@implementation SSChatMessagelLayout

//根据模型返回布局
-(instancetype)initWithMessage:(SSChatMessage *)chatMessage{
    if(self = [super init]){
        _readHeight = 0.0;
        self.chatMessage = chatMessage;
    }
    return self;
}

-(void)setChatMessage:(SSChatMessage *)chatMessage{
    _chatMessage = chatMessage;
    
    switch (_chatMessage.messageType) {
            
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
        case SSChatMessageTypeLocation:
            [self setMap];
            break;
        case SSChatMessageTypeVideo:
            [self setVideo];
            break;
        case SSChatMessageTypeRedEnvelope:
            [self setVideo];
            break;
        case SSChatMessageTypeFile:
            [self setFile];
            break;
        case SSChatMessageTypeTypeTip:
        [self setFile];
        break;
        case NIMMessageTypeCustom:
            [self setFile];
            break;
        default:
            break;
    }
}


//显示文字消息 这个自适应计算有误差 用sizeToFit就比较完美 有好办法告诉我
-(void)setText{
    
    _textLabRect = [NSObject getRectWith:_chatMessage.attTextString width:SSChatTextInitWidth];
    
    CGFloat textWidth  = _textLabRect.size.width;
    CGFloat textHeight = _textLabRect.size.height;
    
    CGFloat backTop = 0;
    if(_chatMessage.message.session.sessionType == NIMSessionTypeTeam && _chatMessage.messageFrom == SSChatMessageFromOther){
        backTop = 15;
    }
    
    if(_chatMessage.messageFrom == SSChatMessageFromOther){
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
       
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y + backTop, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
        _textLabRect.origin.x = SSChatTextLRB;
        _textLabRect.origin.y = SSChatTextTop;
        
    }else{
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-SSChatTextLRB-textWidth-SSChatTextLRS, self.headerImgRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
        _textLabRect.origin.x = SSChatTextLRS;
        _textLabRect.origin.y = SSChatTextTop;
    }
    
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_chatMessage.showTime==YES){
        
        [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y + backTop, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + backTop + SSChatCellBottom + _readHeight;
    
}


//接收方用下载的大图size
//发送方用本地大图的size
-(void)setImage{
    
    _chatMessage.contentMode =  UIViewContentModeScaleAspectFill;
    
    CGFloat imgWidth = _chatMessage.imageObject.size.width;
    CGFloat imgHeight = _chatMessage.imageObject.size.height;
    
    NSString *imgPath = _chatMessage.imageObject.path;
    if (_chatMessage.messageFrom == SSChatMessageFromMe && imgPath.length == 0) {
        imgPath = _chatMessage.imageObject.path;
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
    }
    
    CGFloat backTop = 0;
    if(_chatMessage.message.session.sessionType == NIMSessionTypeTeam && _chatMessage.messageFrom == SSChatMessageFromOther){
        backTop = 15;
    }
    if(_chatMessage.messageFrom == SSChatMessageFromOther){
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y + backTop, imgActualWidth, imgActualHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
    }else{
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-imgActualWidth, self.headerImgRect.origin.y, imgActualWidth, imgActualHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_chatMessage.showTime==YES){
        
       [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y + backTop, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + backTop + SSChatCellBottom + _readHeight;
    
}


-(void)setVoice{
    
    //计算时间
    NSString *time = makeStrWithInt(_chatMessage.audioObject.duration/1000);
    CGRect rect = [NSObject getRectWith:makeString(time, @"\"") width:150 font:[UIFont systemFontOfSize:SSChatVoiceTimeFont] spacing:0 Row:0];
    CGFloat timeWidth  = rect.size.width;
    CGFloat timeHeight = rect.size.height;
    
    //根据时间设置按钮实际长度
    CGFloat timeLength = SSChatVoiceMaxWidth - SSChatVoiceMinWidth;
    CGFloat changeLength = timeLength/30;
    CGFloat currentLength = changeLength*_chatMessage.audioObject.duration/1000 + SSChatVoiceMinWidth;
    if(currentLength > SSChatVoiceMaxWidth){
        currentLength = SSChatVoiceMaxWidth;
    }
    
    CGFloat backTop = 0;
    if(_chatMessage.message.session.sessionType == NIMSessionTypeTeam && _chatMessage.messageFrom == SSChatMessageFromOther){
        backTop = 15;
    }
    if(_chatMessage.messageFrom == SSChatMessageFromOther){
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIconLeft, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y + backTop, currentLength, SSChatVoiceHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);

        _voiceTimeLabRect = CGRectMake(_backImgButtonRect.size.width-timeWidth-10, (_backImgButtonRect.size.height-timeHeight)/2, timeWidth, timeHeight);
        
        _voiceImgRect = CGRectMake(20, (_backImgButtonRect.size.height-SSChatVoiceImgSize)/2, SSChatVoiceImgSize, SSChatVoiceImgSize);
        
    }else{
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-currentLength, self.headerImgRect.origin.y, currentLength, SSChatVoiceHeight);
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
        _voiceTimeLabRect = CGRectMake(10, (_backImgButtonRect.size.height-timeHeight)/2, timeWidth, timeHeight);
        
        _voiceImgRect = CGRectMake(_backImgButtonRect.size.width-SSChatVoiceImgSize-20, (_backImgButtonRect.size.height-SSChatVoiceImgSize)/2, SSChatVoiceImgSize, SSChatVoiceImgSize);
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_chatMessage.showTime==YES){
        
       [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y + backTop, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + backTop + SSChatCellBottom + _readHeight;
    
}


-(void)setMap{
    
    CGFloat backTop = 0;
    if(_chatMessage.message.session.sessionType == NIMSessionTypeTeam && _chatMessage.messageFrom == SSChatMessageFromOther){
        backTop = 15;
    }
    if(_chatMessage.messageFrom == SSChatMessageFromOther){
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y + backTop, SSChatMapWidth, SSChatMapHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
        
    }else{
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-SSChatMapWidth, self.headerImgRect.origin.y, SSChatMapWidth, SSChatMapHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_chatMessage.showTime==YES){
        
        [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y + backTop, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + backTop + SSChatCellBottom + _readHeight;
    
}

//短视频
-(void)setVideo{
    
    _chatMessage.contentMode =  UIViewContentModeScaleAspectFill;
    CGFloat imgWidth = _chatMessage.videoObject.coverSize.width;
    CGFloat imgHeight = _chatMessage.videoObject.coverSize.height;
   
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
    
    CGFloat backTop = 0;
    if(_chatMessage.message.session.sessionType == NIMSessionTypeTeam && _chatMessage.messageFrom == SSChatMessageFromOther){
        backTop = 15;
    }
    
    if(_chatMessage.messageFrom == SSChatMessageFromOther){
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
         _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y + backTop, imgActualWidth, imgActualHeight);
  
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
    }else{
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-imgActualWidth, self.headerImgRect.origin.y, imgActualWidth, imgActualHeight);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
    }
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_chatMessage.showTime==YES){
        
        [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y + backTop, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + backTop + SSChatCellBottom + _readHeight;
    
}


//文件
-(void)setFile{
    
    CGFloat textWidth  = SSChatFileWidth;
    CGFloat textHeight = SSChatFileHeight;
    
    CGFloat backTop = 0;
    if(_chatMessage.message.session.sessionType == NIMSessionTypeTeam && _chatMessage.messageFrom == SSChatMessageFromOther){
        backTop = 15;
    }
    if(_chatMessage.messageFrom == SSChatMessageFromOther){
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y + backTop, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
        
        _fileImgRect = CGRectMake(22, 15, SSChatFileIconW, SSChatFileIconH);
        _titleLabRect = CGRectMake(SSChatFileIconW + 35, 20, SSChatFileWidth - SSChatFileIconW - 30, 20);
        
        _sizeLabRect = CGRectMake(SSChatFileIconW + 37, SSChatFileIconH - 10, SSChatFileWidth - SSChatFileIconW - 30, 20);
        
    }else{
        
        _readHeight = SSChatReadLabBottom;
        
        _headerImgRect = CGRectMake(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        _backImgButtonRect = CGRectMake(SSChatIcon_RX-SSChatDetailRight-SSChatTextLRB-textWidth-SSChatTextLRS, self.headerImgRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        _imageInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
        
        _fileImgRect = CGRectMake(15, 15, SSChatFileIconW, SSChatFileIconH);
        
        _titleLabRect = CGRectMake(SSChatFileIconW + 30, 20, SSChatFileWidth - SSChatFileIconW - 20, 20);
        
        _sizeLabRect = CGRectMake(SSChatFileIconW + 32, SSChatFileIconH - 10, SSChatFileWidth - SSChatFileIconW - 30, 20);
    }
    
    
    //判断时间是否显示
    _timeLabRect = CGRectMake(0, 0, 0, 0);
    
    if(_chatMessage.showTime==YES){
        
        [self getTimeLabRect];
        
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        _backImgButtonRect = CGRectMake(_backImgButtonRect.origin.x, _headerImgRect.origin.y + backTop, _backImgButtonRect.size.width, _backImgButtonRect.size.height);
    }
    
    _cellHeight = _backImgButtonRect.size.height + _backImgButtonRect.origin.y + backTop + SSChatCellBottom + _readHeight;
    
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
    CGRect timeRect = [NSObject getRectWith:_chatMessage.messageTime width:SSChatTimeWidth font:[UIFont systemFontOfSize:SSChatTimeFont] spacing:0 Row:0];
    CGFloat timeWidth = timeRect.size.width+20;
    _timeLabRect = CGRectMake((SCREEN_Width - timeWidth)/2, SSChatTimeTop, timeWidth, SSChatTimeHeight);
}


@end
