//
//  SSChatMessage.m
//  Project
//
//  Created by soldoros on 2021/9/29.
//

#import "SSChatMessage.h"

@implementation SSChatMessage

-(instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        
        _messageFrom = (SSChatMessageFrom)[dic[@"from"]integerValue];
        _messageType = (SSChatMessageType)[dic[@"type"]integerValue];
        _nameString = dic[@"name"];
        
        
        //文本
        if(_messageType == SSChatMessageTypeText){
            
            _cellId = SSChatTextCellId;
            _textString = dic[@"body"];
            
            _textRect = [self getRecrWith:_textString font:[UIFont systemFontOfSize:SSChatTextFont]];
            CGFloat textWidth  = _textRect.size.width;
            CGFloat textHeight = _textRect.size.height;
            
            
            if(_messageFrom == SSChatMessageFromMe){
                
                _backGroundImg = @"icon_qipao1";
                _textRect.origin.x = SSChatTextLRS;
                _textRect.origin.y = SSChatTextTop;
                _textColor = [UIColor whiteColor];
                
                CGFloat headerLeft = SCREEN_Width-SSChatIconRight-SSChatIconWH;
                
                _headerRect = CGRectMake(headerLeft, SSChatCellTop, SSChatIconWH, SSChatIconWH);
                
                _backGroundRect = CGRectMake(headerLeft-SSChatDetailRight-SSChatTextLRB-textWidth-SSChatTextLRS, _headerRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS,  textHeight+SSChatTextTop+SSChatTextBottom);
                _imgInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRS, SSChatAirBottom, SSChatAirLRB);
            }
            if(_messageFrom == SSChatMessageFromOther){
                
                _backGroundImg = @"icon_qipao2";
                _textRect.origin.x = SSChatTextLRB;
                _textRect.origin.y = SSChatTextTop;
                _textColor = [UIColor blackColor];
               
                _headerRect = CGRectMake(SSChatIconLeft,SSChatCellTop, SSChatIconWH, SSChatIconWH);
                _backGroundRect = CGRectMake(SSChatIconLeft+SSChatIconWH+SSChatIconRight, _headerRect.origin.y, textWidth+SSChatTextLRB+SSChatTextLRS, textHeight+SSChatTextTop+SSChatTextBottom);
                _imgInsets = UIEdgeInsetsMake(SSChatAirTop, SSChatAirLRB, SSChatAirBottom, SSChatAirLRS);
            }
            _cellHeight = _backGroundRect.size.height + _backGroundRect.origin.y + 20;
        }
        
    }
    return self;
}

-(CGRect)getRecrWith:(NSString *)string font:(UIFont *)font{
    
    CGSize size = CGSizeMake(SSChatTextInitWidth, CGFLOAT_MAX);
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading;
    NSDictionary *att = @{NSFontAttributeName:font};
    return  [string boundingRectWithSize:size options:options attributes:att context:nil];
}

@end
