//
//  SSChatModelLayout.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatModelLayout.h"
#import "SSChatDatas.h"
#import "SSChatIMEmotionModel.h"



@implementation SSChatModelLayout


-(instancetype)initWithModel:(SSChatModel *)model{
    if(self = [super init]){
        self.cells = [SSChatDatas getCells];
        self.model = model;
        
    }
    return self;
}

-(void)setModel:(SSChatModel *)model{
    _model = model;
    
    switch (_model.messageType ) {

        case SSChatMessageTypeText:
            [self setText];
            break;
        case SSChatMessageTypeImage:
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
        case SSChatMessageTypeOrderValue1:
            [self setOrderValue1];
            break;
        case SSChatMessageTypeOrderValue2:
            [self setOrderValue2];
            break;
        case SSChatMessageTypeRecallMsg:
            [self setRecallMessage];
            break;
        case SSChatMessageTypeRemoveMsg:
            [self setRemoveMessage];
            break;
        default:
            break;
    }
}


//显示文字消息
-(void)setText{
    
    self.cellString = @"SSChatTextCell";
    self.btnImage = makeImage(self.model.imgString);
    
    _model.attTextString = [[SSChartEmotionImages ShareSSChartEmotionImages]emotionImgsWithString:_model.textString];
    [_model.attTextString addAttribute:NSFontAttributeName
                                 value:makeFont(SSChatTextFont)
                                 range:NSMakeRange(0, _model.attTextString.length)];
    [_model.attTextString addAttribute:NSForegroundColorAttributeName
                                 value:_model.textColor
                                 range:NSMakeRange(0, _model.attTextString.length)];
    
    NSMutableParagraphStyle *paragraphString = [[NSMutableParagraphStyle alloc] init];
    [paragraphString setLineSpacing:5];
    [_model.attTextString addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, _model.attTextString.length)];
    
    UILabel *lab = [UILabel new];
    lab.bounds = makeRect(0, 0, SSChatTextInitWidth, 100);
    lab.font = makeFont(SSChatTextFont);
    lab.numberOfLines = 0;
    lab.attributedText = _model.attTextString;
    [lab sizeToFit];
    
    
    
    CGFloat textWidth  = lab.width;
    CGFloat textHeight = lab.height;
    
    if(_model.messageFrom == SSChatMessageFromOther){
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
       
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        
        self.btnInsets = UIEdgeInsetsMake(SSChatTextTop, SSChatTextLRB, SSChatTextBottom, SSChatTextLRS);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        
    }else{
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-SSChatTextLRB-textWidth-SSChatTextLRS, self.headerImgRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
        self.btnInsets = UIEdgeInsetsMake(SSChatTextTop, SSChatTextLRS, SSChatTextBottom, SSChatTextLRB);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB)];
    }
    
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.btnRect = makeRect(self.btnRect.origin.x, self.headerImgRect.origin.y, self.btnRect.size.width, self.btnRect.size.height);
    }
    self.height = self.btnRect.size.height + self.btnRect.origin.y + SSChatCellBottom;
    
}


-(void)setImage{
    
    self.cellString = @"SSChatImgCell";
    self.btnImage = makeImage(self.model.imgString);
 
    if(_model.messageFrom == SSChatMessageFromOther){
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, SSChatImageWidth, SSChatImageHeight);

        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        
    }else{
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-SSChatImageWidth, self.headerImgRect.origin.y, SSChatImageWidth, SSChatImageHeight);

        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB)];
    }
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.btnRect = makeRect(self.btnRect.origin.x, self.headerImgRect.origin.y, self.btnRect.size.width, self.btnRect.size.height);
    }
    self.height = self.btnRect.size.height + self.btnRect.origin.y + SSChatCellBottom;
    
}


-(void)setVoice{
    self.cellString = @"SSChatVoiceCell";
    self.btnImage = makeImage(self.model.imgString);
    
    //计算时间
    _timeString = [NSString stringWithFormat:@"%ld's ",_model.duration];
    CGRect rect = [NSObject getRectWith:_timeString width:150 font:makeFont(SSChatVoiceTimeFont) spacing:0 Row:0];
    CGFloat timeWidth  = rect.size.width;
    CGFloat timeHeight = rect.size.height;
    
    //根据时间设置按钮实际长度
    CGFloat timeLength = SSChatVoiceMaxWidth - SSChatVoiceMinWidth;
    CGFloat changeLength = timeLength/60;
    CGFloat currentLength = changeLength*_model.duration+SSChatVoiceMinWidth;
    
    if(_model.messageFrom == SSChatMessageFromOther){

        UIColor *imgColor = makeColorRgb(178, 239, 228);
        self.voiceImg = [[UIImage imageNamed:@"chat_animation3"] imageWithColor:imgColor];
        self.voiceImgs =
        @[[[UIImage imageNamed:@"chat_animation1"] imageWithColor:imgColor],
          [[UIImage imageNamed:@"chat_animation2"] imageWithColor:imgColor],
          [[UIImage imageNamed:@"chat_animation3"] imageWithColor:imgColor]];
        
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, currentLength, SSChatVoiceHeight);
        self.timeLabRect = makeRect(self.btnRect.size.width-timeWidth-10, (self.btnRect.size.height-timeHeight)/2, timeWidth, timeHeight);
        self.voiceRect = makeRect(20, (self.btnRect.size.height-SSChatVoiceImgSize)/2, SSChatVoiceImgSize, SSChatVoiceImgSize);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        
    }else{
        UIColor *imgColor = makeColorRgb(178, 239, 228);
        self.voiceImg = [[UIImage imageNamed:@"chat_animation_white3"] imageWithColor:imgColor];
        self.voiceImgs =
        @[[[UIImage imageNamed:@"chat_animation_white1"] imageWithColor:imgColor],
          [[UIImage imageNamed:@"chat_animation_white2"] imageWithColor:imgColor],
          [[UIImage imageNamed:@"chat_animation_white3"] imageWithColor:imgColor]];
        
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-currentLength, self.headerImgRect.origin.y, currentLength, SSChatVoiceHeight);
        
        self.timeLabRect = makeRect(10, (self.btnRect.size.height-timeHeight)/2, timeWidth, timeHeight);
        self.voiceRect = makeRect(self.btnRect.size.width-SSChatVoiceImgSize-20, (self.btnRect.size.height-SSChatVoiceImgSize)/2, SSChatVoiceImgSize, SSChatVoiceImgSize);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB)];
    }
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.btnRect = makeRect(self.btnRect.origin.x, self.headerImgRect.origin.y, self.btnRect.size.width, self.btnRect.size.height);
    }
    self.height = self.btnRect.size.height + self.btnRect.origin.y + SSChatCellBottom;
}


-(void)setMap{
    self.cellString = @"SSChatMapCell";
    self.btnImage = makeImage(self.model.imgString);
    
    if(_model.messageFrom == SSChatMessageFromOther){
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, SSChatMapWidth, SSChatMapHeight);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        
    }else{
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-SSChatImageWidth, self.headerImgRect.origin.y, SSChatMapWidth, SSChatMapHeight);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB)];
    }
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.btnRect = makeRect(self.btnRect.origin.x, self.headerImgRect.origin.y, self.btnRect.size.width, self.btnRect.size.height);
    }
    self.height = self.btnRect.size.height + self.btnRect.origin.y + SSChatCellBottom;
}

//短视频
-(void)setVideo{
    
    self.cellString = @"SSChatVideoCell";
    self.btnImage = makeImage(self.model.imgString);
    
    if(_model.messageFrom == SSChatMessageFromOther){
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight, self.headerImgRect.origin.y, SSChatVideoWidth, SSChatVideoHeight);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        
    }else{
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-SSChatImageWidth, self.headerImgRect.origin.y, SSChatVideoWidth, SSChatVideoHeight);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB)];
    }
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.btnRect = makeRect(self.btnRect.origin.x, self.headerImgRect.origin.y, self.btnRect.size.width, self.btnRect.size.height);
    }
    self.height = self.btnRect.size.height + self.btnRect.origin.y + SSChatCellBottom;
}


//显示支付定金订单信息
-(void)setOrderValue1{
    self.cellString = @"SSChatOrderValue1Cell";
    self.height =  SSChatOrderValue1CellH;
    self.btnImage = makeImage(self.model.imgString);
    
    if(_model.messageFrom == SSChatMessageFromOther){
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight,SSChatCellTop, SSChatOrderInitWidth,SSChatOrderValue1CellH-2*SSChatCellTop);
        
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        self.goodsImgRect = makeRect(10, 10, _btnRect.size.height-20, _btnRect.size.height-20);
        self.titleColor = [UIColor blackColor];
    }else{
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-SSChatOrderInitWidth,SSChatCellTop, SSChatOrderInitWidth,SSChatOrderValue1CellH-2*SSChatCellTop);
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRB)];
        self.goodsImgRect = makeRect(10, 10, _btnRect.size.height-20, _btnRect.size.height-20);
        self.titleColor = [UIColor whiteColor];
    }
}

//显示直接购买订单信息
-(void)setOrderValue2{
    self.cellString = @"SSChatOrderValue2Cell";
    self.height =  SSChatOrderValue2CellH;
    self.btnImage = makeImage(self.model.imgString);
    
    if(_model.messageFrom == SSChatMessageFromOther){
        self.headerImgRect = makeRect(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIconLeft+SSChatIconWH+SSChatIconRight,SSChatCellTop, SSChatOrderInitWidth,SSChatOrderValue1CellH-2*SSChatCellTop);
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS)];
        
        self.goodsImgRect = makeRect(10, 10, _btnRect.size.height-20, _btnRect.size.height-20);
        
    }else{
        self.headerImgRect = makeRect(SSChatIcon_RX, SSChatCellTop, SSChatIconWH, SSChatIconWH);
        
        self.btnRect = makeRect(SSChatIcon_RX-SSChatDetailRight-SSChatOrderInitWidth,SSChatCellTop, SSChatOrderInitWidth,SSChatOrderValue1CellH-2*SSChatCellTop);
        self.btnImage = [self.btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRB)];
        
        self.goodsImgRect = makeRect(10, 10, _btnRect.size.height-20, _btnRect.size.height-20);
    }
}


//撤销的消息
-(void)setRecallMessage{
    
    self.cellString = @"SSChatMessageCell";
    self.height = 40;
    
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.height = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight+25;
    }
}


//删除的消息
-(void)setRemoveMessage{
    
    self.cellString = @"SSChatMessageCell";
    self.height = 0;
    
    //显示时间
    if(_model.showTime==YES){
        CGRect hRect = self.headerImgRect;
        hRect.origin.y = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
        self.headerImgRect = hRect;
        
        self.height = SSChatTimeTop+SSChatTimeBottom+SSChatTimeHeight;
    }
    
}




@end
