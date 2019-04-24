//
//  ConversationViews.m
//  SSChat
//
//  Created by soldoros on 2019/4/13.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ConversationViews.h"

@implementation ConversationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 35, 35);
        _mLeftImgView.left = 10;
        _mLeftImgView.centerY = ConversationListCellH * 0.5;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [self.contentView addSubview:_mLeftImgView];
        _mLeftImgView.image = [UIImage imageNamed:@"user_avatar_blue"];
        
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(16);
        
        
        _mDetailLab = [UILabel new];
        _mDetailLab.bounds = makeRect(0, 0, 100, 30);
        _mDetailLab.textColor = [UIColor grayColor];
        [self.contentView addSubview:_mDetailLab];
        _mDetailLab.font = makeFont(14);
        
        
        _mTimeLab = [UILabel new];
        _mTimeLab.bounds = makeRect(0, 0, 100, 30);
        _mTimeLab.textColor = [UIColor grayColor];
        [self.contentView addSubview:_mTimeLab];
        _mTimeLab.font = makeFont(14);
        
        
        _mRedLab = [UILabel new];
        _mRedLab.bounds = makeRect(0, 0, 30, 30);
        _mRedLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_mRedLab];
        _mRedLab.font = makeFont(12);
        _mRedLab.backgroundColor = makeColorRgb(239, 70, 65);
        _mRedLab.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return self;
}


-(void)setConversation:(EMConversation *)conversation{
    
    EMMessage *lastMessage = conversation.latestMessage;
    SSChatDatas *_chatData = [SSChatDatas new];
    SSChatMessage *chatMessage = [_chatData getModelWithMessage:lastMessage];
    
    
    _mTitleLab.text = conversation.conversationId;
    [_mTitleLab sizeToFit];
    _mTitleLab.left = _mLeftImgView.right + 15;
    _mTitleLab.bottom = ConversationListCellH * 0.5 - 2;
    _mTitleLab.width = SCREEN_Width - _mTitleLab.left - 100;
    
 
    [self setLabelStringWithMessage:chatMessage label:_mDetailLab];
    [_mDetailLab sizeToFit];
    _mDetailLab.width = SCREEN_Width - _mTitleLab.left - 70;
    _mDetailLab.left = _mLeftImgView.right + 17;
    _mDetailLab.top = ConversationListCellH * 0.5 + 2;
    
    
    _mTimeLab.text = [self getTimeWithTimeInterval:lastMessage.timestamp];
    [_mTimeLab sizeToFit];
    _mTimeLab.right = SCREEN_Width - 20;
    _mTimeLab.centerY = _mTitleLab.centerY;
    
    
    NSInteger count = conversation.unreadMessagesCount;
    if(count==0)_mRedLab.hidden = YES;
    else _mRedLab.hidden = NO;
    _mRedLab.text = makeStrWithInt(count);
    [_mRedLab sizeToFit];
    _mRedLab.height += 4;
    _mRedLab.width  += 10;
    if(_mRedLab.width<_mRedLab.height){
        _mRedLab.width = _mRedLab.height;
    }
    _mRedLab.clipsToBounds = YES;
    _mRedLab.layer.cornerRadius = _mRedLab.height * 0.5;
    _mRedLab.right = SCREEN_Width - 20;
    _mRedLab.centerY = _mDetailLab.centerY;
    
}



-(void)setLabelStringWithMessage:(SSChatMessage *)chatMessage label:(UILabel *)label{
    
    NSString *status = @"";
    if(chatMessage.message.isRead == NO){
        status = @"[未读] ";
    }
    
    NSString *string = @"";
    switch (chatMessage.messageType) {
            
        case SSChatMessageTypeText:
            string = chatMessage.textString;
            break;
        case SSChatMessageTypeImage:
            string = @"[图片]";
            break;
        case SSChatMessageTypeGif:
            string = @"[动图]";
            break;
        case SSChatMessageTypeVoice:
            string = @"[语音]";
            break;
        case SSChatMessageTypeMap:
            string = @"[位置]";
            break;
        case SSChatMessageTypeVideo:
            string = @"[视频]";
            break;
        case SSChatMessageTypeRedEnvelope:
            string = @"[红包]";
            break;
        default:
            break;
    }
   
    if(status.length>0){
         string = makeString(status, string);
         setLabColor(label, string, 0, status.length, TitleColor);
    }else{
         label.text = string;
    }
}


- (NSString *)getTimeWithTimeInterval:(double)timeInterval{

    NSString *latestMessageTime = @"";
    if(timeInterval > 140000000000) {
        timeInterval = timeInterval / 1000;
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return latestMessageTime;
    
}


@end
