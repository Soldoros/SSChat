//
//  PBPayOverController.h
//  LiangCang
//
//  Created by soldoros on 2020/3/21.
//  Copyright © 2020 soldoros. All rights reserved.
//

//支付结果界面
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PBPayOverController : BaseViewController
@property(nonatomic,strong)NSDictionary *dataDic;

//购买商品0 购买碎片1  购买福袋2  购买道具3
@property(nonatomic,assign)NSInteger type; 

@end

NS_ASSUME_NONNULL_END
