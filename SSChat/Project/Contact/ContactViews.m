//
//  ContactViews.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ContactViews.h"

@implementation ContactListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 35, 35);
        _mLeftImgView.left = 10;
        _mLeftImgView.centerY = ContactListCellH * 0.5;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [self.contentView addSubview:_mLeftImgView];
        
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(16);
        
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

//通讯录列表数据
-(void)setDataDic:(NSDictionary *)dataDic{
    
    _dataDic = dataDic;
    
    _mLeftImgView.image = [UIImage imageNamed:_dataDic[@"image"]];
    
    _mTitleLab.text = _dataDic[@"title"];
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
    
    
    _mRedLab.hidden = YES;
    
    if(_indexPath.section == 0 && _indexPath.row == 0){
        
        _mRedLab.hidden = NO;
      
        NSInteger count = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
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
        _mRedLab.centerY = ContactListCellH * 0.5;
    }
    
}


-(void)setUser:(NIMUser *)user{
    _user = user;
    
    _mLeftImgView.image = [UIImage imageNamed:@"user_avatar_blue"];
    
    _mTitleLab.text = _user.userInfo.nickName ? _user.userInfo.nickName : _user.userId;
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
    
    
    _mRedLab.hidden = YES;
    
    if(_indexPath.section == 0 && _indexPath.row == 0){
        
        _mRedLab.hidden = NO;
        
        NSInteger count = 1;
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
        _mRedLab.centerY = ContactListCellH * 0.5;
    }
}


//搜索好友的数据
-(void)setFriendString:(NSString *)friendString{
    
    _mLeftImgView.image = [UIImage imageNamed:@"user_avatar_blue"];
    
    _mTitleLab.text = friendString;
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
}

@end




//好友申请列表cell
@implementation ContactFriendRequestsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = BackGroundColor;
        self.contentView.backgroundColor = BackGroundColor;
        
        _mTimeLab = [UILabel new];
        _mTimeLab.frame = makeRect(0, 0, SCREEN_Width, 45);
        _mTimeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_mTimeLab];
        _mTimeLab.font = makeFont(14);
        _mTimeLab.textColor = [UIColor lightGrayColor];
        
        
        _mBackView = [UIView new];
        _mBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mBackView];
        _mBackView.clipsToBounds = YES;
        _mBackView.layer.cornerRadius = 5;
        _mBackView.frame = makeRect(15, 45, SCREEN_Width-30, ContactFriendRequestsCellH - 45);
        
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 35, 35);
        _mLeftImgView.left = 10;
        _mLeftImgView.top = 10;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [_mBackView addSubview:_mLeftImgView];
        
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [_mBackView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(14);
        
        _mMessageLab = [UILabel new];
        _mMessageLab.bounds = makeRect(0, 0, 100, 30);
        _mMessageLab.textColor = [UIColor lightGrayColor];
        [_mBackView addSubview:_mMessageLab];
        _mMessageLab.font = makeFont(12);
      
        
        _mLine1 = [UIView new];
        _mLine1.bounds = makeRect(0, 0, _mBackView.width, 1);
        _mLine1.left = 0;
        _mLine1.bottom = _mBackView.height - 45;
        _mLine1.backgroundColor = BackGroundColor;
        [_mBackView addSubview:_mLine1];
        
        
        _mLine2 = [UIView new];
        _mLine2.bounds = makeRect(0, 0, 1, 45);
        _mLine2.centerX = _mBackView.width * 0.5;
        _mLine2.bottom = _mBackView.height;
        _mLine2.backgroundColor = BackGroundColor;
        [_mBackView addSubview:_mLine2];
        
        
        _mButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _mButton1.bounds = makeRect(0, 0, _mBackView.width * 0.5, 45);
        _mButton1.left = 0;
        _mButton1.bottom = _mBackView.height;
        _mButton1.tag = 50;
        [_mButton1 setTitle:@"拒绝" forState:UIControlStateNormal];
        [_mButton1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_mButton1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_mBackView addSubview:_mButton1];
        
        
        _mButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _mButton2.bounds = makeRect(0, 0, _mBackView.width * 0.5, 45);
        _mButton2.left = _mBackView.width * 0.5;
        _mButton2.bottom = _mBackView.height;
        _mButton2.tag = 51;
        [_mButton2 setTitle:@"同意" forState:UIControlStateNormal];
        [_mButton2 setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mButton2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_mBackView addSubview:_mButton2];
        
        
        _mBottomLab = [UILabel new];
        _mBottomLab.bounds = makeRect(0, 0, _mBackView.width, 45);
        _mBottomLab.bottom = _mBackView.height;
        _mBottomLab.left = 0;
        _mBottomLab.textColor = [UIColor lightGrayColor];
        [_mBackView addSubview:_mBottomLab];
        _mBottomLab.font = makeFont(16);
        _mBottomLab.backgroundColor = [UIColor clearColor];
        _mBottomLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}


//拒绝50  同意51
-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(ContactFriendRequestsCellBtnClick:sender: )]){
        [_delegate ContactFriendRequestsCellBtnClick:_indexPath sender:sender];
    }
    
}


-(void)setNotification:(NIMSystemNotification *)notification{
    _notification = notification;
    
    _mLeftImgView.image = [UIImage imageNamed:@"user_avatar_blue"];
    
    _mTimeLab.text = makeStrWithInt(notification.timestamp);
    
    _mTitleLab.text = notification.sourceID;
    [_mTitleLab sizeToFit];
    _mTitleLab.left = _mLeftImgView.right + 10;
    _mTitleLab.top = _mLeftImgView.top ;
 
    _mBottomLab.hidden = NO;
    _mButton1.hidden = YES;
    _mButton2.hidden = YES;
    _mLine2.hidden = YES;
    
    switch (self.notification.handleStatus) {
        case SSNotificationAgreed:
            _mBottomLab.text = @"已同意";
            break;
        case SSNotificationDeclined:
            _mBottomLab.text = @"已拒绝";
            break;
        case SSNotificationExpired:
            _mBottomLab.text = @"已过期";
            break;
        default:
            [self setDetailWith:notification];
            break;
    }
    
}

-(void)setDetailWith:(NIMSystemNotification *)notification{
    
    _mBottomLab.text = @"友情提示";
    NSString *text = notification.postscript;
    if(text.length ==0 || text == nil){
        text = @"请求添加您为好友";
    }
    id object = self.notification.attachment;
    if ([object isKindOfClass:[NIMUserAddAttachment class]]) {
        NIMUserOperation operation = [(NIMUserAddAttachment *)object operationType];
        switch (operation) {
            case NIMUserOperationAdd:
                text = @"已添加你为好友";
                break;
            case NIMUserOperationRequest:
                _mBottomLab.hidden = YES;
                _mButton1.hidden = NO;
                _mButton2.hidden = NO;
                _mLine2.hidden = NO;
                break;
            case NIMUserOperationVerify:
                text = @"通过了你的好友请求";
                break;
            case NIMUserOperationReject:
                text = @"拒绝了你的好友请求";
                break;
            default:
                break;
        }
    }
    
    _mMessageLab.text = text;
    [_mMessageLab sizeToFit];
    _mMessageLab.left = _mLeftImgView.right + 10;
    _mMessageLab.bottom = _mLeftImgView.bottom ;
    
}



@end
