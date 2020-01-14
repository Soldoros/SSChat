//
//  SSScrollController.h
//  DEShop
//
//  Created by soldoros on 2017/6/6.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "BaseController.h"

@interface SSScrollController : BaseController


@property(nonatomic,strong)NSArray *images;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIScrollView *mScrollView;
@property(nonatomic,strong)UIPageControl *pageControll;

@end
