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
        _mLeftImgView.bounds = CGRectMake(0, 0, 45, 45);
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
        _mDetailLab.textColor = TitleColor;
        [self.contentView addSubview:_mDetailLab];
        _mDetailLab.font = makeFont(15);
        
        
        _mTimeLab = [UILabel new];
        _mTimeLab.bounds = makeRect(0, 0, 100, 30);
        _mTimeLab.textColor = makeColorRgb(180, 180, 180);
        [self.contentView addSubview:_mTimeLab];
        _mTimeLab.font = makeFont(12);
        
        
        _mRedLab = [UILabel new];
        _mRedLab.bounds = makeRect(0, 0, 30, 30);
        _mRedLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_mRedLab];
        _mRedLab.font = makeFont(12);
        _mRedLab.backgroundColor = makeColorRgb(239, 70, 65);
        _mRedLab.textAlignment = NSTextAlignmentCenter;
        _mRedLab.clipsToBounds = YES;
        
    }
    return self;
}

-(void)setRecentSession:(NIMRecentSession *)recentSession{
    _recentSession = recentSession;
    
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:_recentSession.session.sessionId];
    NSString *img = [SSChatDatas showHeaderImgWithSession:_recentSession.session];
    
    NSString *title = [SSChatDatas getNavagationTitle:recentSession.session];
    
    NSMutableAttributedString *detail = [self messageContent:_recentSession.lastMessage];
    NSString *time =  [self getTimeWithTimeInterval:_recentSession.lastMessage.timestamp];
    
    
    [[NIMSDK sharedSDK].resourceManager fetchNOSURLWithURL:user.userInfo.avatarUrl completion:^(NSError * _Nullable error, NSString * _Nullable urlString) {
        UIImage *image = [UIImage imageNamed:img];
        [self.mLeftImgView setImageWithURL:[NSURL URLWithString:urlString] placeholder:image options:YYWebImageOptionIgnoreAnimatedImage completion:nil];
    }];
    
    
    _mTitleLab.text = title;
    [_mTitleLab sizeToFit];
    _mTitleLab.left = _mLeftImgView.right + 15;
    _mTitleLab.top = _mLeftImgView.top;
    _mTitleLab.width = SCREEN_Width - _mTitleLab.left - 100;
    
    _mDetailLab.attributedText = detail;
    [_mDetailLab sizeToFit];
    _mDetailLab.width = SCREEN_Width - _mTitleLab.left - 70;
    _mDetailLab.left = _mLeftImgView.right + 16;
    _mDetailLab.bottom = _mLeftImgView.bottom;
    
    _mTimeLab.text = time;
    [_mTimeLab sizeToFit];
    _mTimeLab.right = SCREEN_Width - 20;
    _mTimeLab.top = _mLeftImgView.top;
    
    
    if(_recentSession.unreadCount == 0){
        _mRedLab.hidden = YES;
    }else{
        _mRedLab.hidden = NO;
    }
    _mRedLab.text = makeStrWithInt(_recentSession.unreadCount);
    [_mRedLab sizeToFit];
    _mRedLab.height += 4;
    _mRedLab.width  += 10;
    if(_mRedLab.width<_mRedLab.height){
        _mRedLab.width = _mRedLab.height;
    }
    _mRedLab.clipsToBounds = YES;
    _mRedLab.layer.cornerRadius = _mRedLab.height * 0.5;
    _mRedLab.right = SCREEN_Width - 20;
    _mRedLab.bottom = _mLeftImgView.bottom;
}

//设置消息类型和状态
- (NSMutableAttributedString *)messageContent:(NIMMessage*)lastMessage{
    NSString *text = @"";
    switch (lastMessage.messageType) {
        case NIMMessageTypeText:
            text = lastMessage.text;
            break;
        case NIMMessageTypeAudio:
            text = @"[语音]";
            break;
        case NIMMessageTypeImage:
            text = @"[图片]";
            break;
        case NIMMessageTypeVideo:
            text = @"[视频]";
            break;
        case NIMMessageTypeLocation:
            text = @"[位置]";
            break;
        case NIMMessageTypeNotification:{
            text = @"[通知]";
            break;
        }
        case NIMMessageTypeFile:
            text = @"[文件]";
            break;
        case NIMMessageTypeTip:
            text = lastMessage.text;
            break;
        case NIMMessageTypeRobot:
            text = @"[机器人]";
            break;
        default:
            text = @"[未知消息]";
    }
    
    
    NSString *current = [NIMSDK sharedSDK].loginManager.currentAccount;
    if([lastMessage.from isEqualToString:current]){
        if(lastMessage.session.sessionType == NIMSessionTypeP2P){
            return [self getMessageReceipt:lastMessage text:text];
        }else{
            return [self getMessageWithText:text];
        }
    }else{
        return [self getMessageWithText:text];
    }
    
}

-(NSMutableAttributedString *)getMessageWithText:(NSString *)text{
    NSMutableAttributedString *mutableString =  [[NSMutableAttributedString alloc]initWithString:text];
    NSDictionary *dic1 = @{NSForegroundColorAttributeName:makeColorRgb(160, 160, 160)};
    [mutableString addAttributes:dic1 range:NSMakeRange(0,text.length)];
    return mutableString;
}

//设置已读未读
-(NSMutableAttributedString *)getMessageReceipt:(NIMMessage *)message text:(NSString *)text{
    
    if(message.isRemoteRead){
        NSString *str = makeString(@"[已读] ", text);
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:str];
        NSDictionary *dic1 = @{NSForegroundColorAttributeName:makeColorRgb(160, 160, 160)};
        [mutableString addAttributes:dic1 range:NSMakeRange(0,str.length)];
        return  mutableString;
    }else{
        NSString *str = makeString(@"[未读] ", text);
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:str];
        NSDictionary *dic1 = @{NSForegroundColorAttributeName:makeColorRgb(160, 160, 160)};
        [mutableString addAttributes:dic1 range:NSMakeRange(str.length - text.length,text.length)];
        return  mutableString;
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
