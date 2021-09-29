//
//  MineScanningController.h
//  htcm1
//
//  Created by soldoros on 2018/5/16.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseViewController.h"

@protocol MineScanningControllerViewDelegate <NSObject>

-(void)MineScanningControllerBack:(NSString *)string;

@end

@interface MineScanningController : BaseViewController

@property(nonatomic,assign)id<MineScanningControllerViewDelegate>delegate;

//订单1   
@property(nonatomic,assign)NSInteger type;

@end
