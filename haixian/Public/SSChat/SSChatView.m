//
//  SSChatView.m
//  haixian
//
//  Created by soldoros on 2017/11/14.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatView.h"

@implementation SSChatView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _mImgView = [UIImageView new];
         _mImgView.bounds = makeRect(0, 0, SSChatViewH-25, SSChatViewH-25);
        _mImgView.left = 10;
        _mImgView.centerY = SSChatViewH * 0.5;
        [self addSubview:_mImgView];
        _mImgView.image = [UIImage imageNamed:@"组-14"];
        
        
        _mLabel = [UILabel new];
        _mLabel.bounds = makeRect(0, 0, SCREEN_Width-_mImgView.right-30, _mImgView.height);
        _mLabel.left = _mImgView.right + 10;
        _mLabel.top = _mImgView.top ;
        _mLabel.font = makeFont(16);
        _mLabel.numberOfLines = 2;
        _mLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_mLabel];
        _mLabel.text = @"男鞋亚沙手动阀是返回大师傅；阿发发的发发发";
        
//        _mPrice = [UILabel new];
//        _mPrice.bounds = makeRect(0, 0, SCREEN_Width-_mImgView.right-30, 20);
//        _mPrice.left = _mLabel.left;
//        _mPrice.top = _mLabel.bottom+5 ;
//        _mPrice.font = makeFont(16);
//        _mPrice.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:_mPrice];
//        _mPrice.text = @"￥199.00";
 
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic{
    
    
    NSString *imgstr = makeString(URLStr, dataDic[@"thumb_img"]);
    NSString *title = dataDic[@"title"];

    
    [_mImgView sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:ImagePlace1]];
    _mLabel.text = title;

    
    
}



@end
