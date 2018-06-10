//
//  SSChatOrderValue2Cell.h
//  haixian
//
//  Created by soldoros on 2017/11/13.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"



/**
 订单直接购买消息cell
 */
@interface SSChatOrderValue2Cell : SSChatBaseCell

@property(nonatomic, strong) UIButton       *mButton;
@property(nonatomic, strong) UIImageView    *mImgView;
@property(nonatomic, strong) UILabel        *mlabel;
@property(nonatomic, strong) UIButton       *mPayBtn;

@property(nonatomic, strong) UILabel        *mNumlabel;
@property(nonatomic, strong) UILabel        *mPricelabel;

@end
