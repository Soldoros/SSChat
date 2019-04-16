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
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
      
    }
    return self;
}


-(void)setDataDic:(NSDictionary *)dataDic{
    
    
}

@end
