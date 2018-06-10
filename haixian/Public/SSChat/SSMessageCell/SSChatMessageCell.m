//
//  SSChatMessageCell.m
//  htcm
//
//  Created by soldoros on 2018/6/7.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatMessageCell.h"

@implementation SSChatMessageCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    self.mHeaderImgBtn.hidden = YES;
    
    _mLabel = [YYLabel new];
    _mLabel.bounds = makeRect(0, 0, SSChatTimeWidth, SSChatTimeHeight);
    [self.contentView addSubview:_mLabel];
    _mLabel.font = makeFont(SSChatTimeFont);
    _mLabel.textColor = [UIColor whiteColor];
    _mLabel.backgroundColor = makeColorRgb(210, 210, 210);
    _mLabel.clipsToBounds = YES;
    _mLabel.layer.cornerRadius = 3;
}

-(void)setLayout:(SSChatModelLayout *)layout{
    [super setLayout:layout];
    
    if(layout.model.messageFrom == SSChatMessageFromMe){
    
        NSString *tagStr2 = @"重新编辑";
        NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:@"您撤回了一条消息 重新编辑"];
        [text2 setColor:[UIColor whiteColor] range:NSMakeRange(0, text2.length)];
        [text2 setFont:makeFont(SSChatTimeFont) range:NSMakeRange(0, text2.length)];
        [text2 setTextHighlightRange:NSMakeRange(text2.length-tagStr2.length, tagStr2.length) color:TitleColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatBaseCellLabClick:index:yout:)]){
                [self.delegate SSChatBaseCellLabClick:self.indexPath index:0 yout:self.layout];
            }
            
        }];
        
        _mLabel.attributedText = text2;
        
    }else{
        _mLabel.text = makeMoreStr(layout.model.message.conversationId,@" 撤回了一条消息",nil);
    }
    
    [_mLabel sizeToFit];
    _mLabel.width += 20;
    _mLabel.height += 6;
    _mLabel.centerX = SCREEN_Width*0.5;
    _mLabel.textAlignment = NSTextAlignmentCenter;
    
    if(layout.model.showTime){
        _mLabel.top = self.mMsgTimeLab.bottom + SSChatTimeBottom;
    }else{
        _mLabel.top = 0;
    }
    
}





@end
