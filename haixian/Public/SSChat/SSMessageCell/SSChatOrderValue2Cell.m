//
//  SSChatOrderValue2Cell.m
//  haixian
//
//  Created by soldoros on 2017/11/13.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatOrderValue2Cell.h"

@implementation SSChatOrderValue2Cell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    
    self.mButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mButton.userInteractionEnabled = YES;
    self.mButton.titleLabel.numberOfLines = 0;
    self.mButton.titleLabel.font = makeFont(SSChatTextFont);
    [self.contentView addSubview:self.mButton];
    
    _mImgView = [UIImageView new];
    _mImgView.left = 20;
    _mImgView.top = 20;
    _mImgView.bounds = makeRect(0, 0, 60, 60);
    [self.mButton addSubview:_mImgView];
    
    
    //商品名称
    _mlabel = [UILabel new];
    _mlabel.font = makeFont(12);
    _mlabel.numberOfLines = 1;
    _mlabel.left = _mImgView.right + 5;
    _mlabel.textAlignment = NSTextAlignmentLeft;
    [self.mButton addSubview:_mlabel];
    
    
    //商品价格
    _mPricelabel = [UILabel new];
    _mPricelabel.font = makeFont(10);
    _mPricelabel.numberOfLines = 1;
    _mPricelabel.left = _mImgView.right + 5;
    _mPricelabel.textAlignment = NSTextAlignmentLeft;
    [self.mButton addSubview:_mPricelabel];
    
    
    //商品数量
    _mNumlabel = [UILabel new];
    _mNumlabel.font = makeFont(10);
    _mNumlabel.numberOfLines = 1;
    _mNumlabel.left = _mImgView.right + 5;
    _mNumlabel.textAlignment = NSTextAlignmentLeft;
    [self.mButton addSubview:_mNumlabel];
    
    
    _mPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mPayBtn.bounds = makeRect(0, 0, 50, 25);
    _mPayBtn.backgroundColor = [UIColor redColor];
    [_mPayBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    _mPayBtn.titleLabel.font = makeFont(10);
    [_mPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mButton addSubview:_mPayBtn];
    _mPayBtn.tag = 10;
    _mPayBtn.clipsToBounds = YES;
    _mPayBtn.layer.cornerRadius = 4;
    [_mPayBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setLayout:(SSChatModelLayout *)layout{
    [super setLayout:layout];
    self.mButton.frame = layout.btnRect;
    self.mImgView.frame = layout.goodsImgRect;
    _mlabel.bounds = makeRect(0, 0, _mButton.width-_mImgView.width-40, 18);
    _mlabel.top = 10;
    _mlabel.left = _mImgView.right + 10;
    _mPayBtn.right = _mButton.width-10;
    _mPayBtn.bottom = _mButton.height - 10;
    
    _mNumlabel.bounds = _mlabel.bounds;
    _mNumlabel.top = _mlabel.bottom;
    _mNumlabel.left = _mlabel.left;
    
    _mPricelabel.bounds = _mlabel.bounds;
    _mPricelabel.top = _mNumlabel.bottom;
    _mPricelabel.left = _mNumlabel.left;
    
    
    _mlabel.textColor = layout.titleColor;
    _mPricelabel.textColor = [UIColor redColor];
    _mNumlabel.textColor = layout.titleColor;
    
    
    NSString *imgstr = makeString(URLStr, layout.model.dict[@"goods_image"]);
    
    [_mImgView sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:ImagePlace1]];
    [self.mButton setBackgroundImage:layout.btnImage forState:UIControlStateNormal];
    [self.mButton setBackgroundImage:layout.btnImage forState:UIControlStateHighlighted];
    _mlabel.text = layout.model.dict[@"goods_name"];
    _mNumlabel.text = makeString(@"数量:",layout.model.dict[@"goods_number"]);
    _mPricelabel.text = makeString(@"价格:￥",layout.model.dict[@"goods_price"]);
}


//立即购买10
-(void)buttonPressed:(UIButton *)sender{
 
    
    
}

@end
