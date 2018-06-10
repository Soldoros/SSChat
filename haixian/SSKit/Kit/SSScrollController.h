//
//  SSScrollController.h
//  DEShop
//
//  Created by soldoros on 2017/6/6.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "BaseController.h"

@protocol SSScrollControllerDelegate <NSObject>

-(void)SSScrollControllerBtnClick;

@end

@interface SSScrollController : UIViewController

@property(nonatomic,assign)id<SSScrollControllerDelegate>delegate;

@property(nonatomic,strong)NSArray *images;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIScrollView *mScrollView;
@property(nonatomic,strong)UIPageControl *pageControll;

@end
