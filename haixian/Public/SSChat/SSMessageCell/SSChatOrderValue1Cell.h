//
//  SSChatOrderValue1Cell.h
//  haixian
//
//  Created by soldoros on 2017/11/13.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"



/**
 订单预购消息cell
 */
@interface SSChatOrderValue1Cell : SSChatBaseCell

@property(nonatomic, strong) UIButton       *mButton;
@property(nonatomic, strong) UIImageView    *mImgView;
@property(nonatomic, strong) UILabel        *mlabel;

@property(nonatomic, strong) UILabel        *mNumlabel;
@property(nonatomic, strong) UILabel        *mPricelabel;
@property(nonatomic, strong) UIButton       *mPayBtn;

@end
