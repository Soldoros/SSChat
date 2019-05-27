//
//  MineScanningController.h
//  htcm1
//
//  Created by soldoros on 2018/5/16.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseController.h"

@protocol MineScanningControllerViewDelegate <NSObject>

-(void)MineScanningControllerBack:(NSString *)string;

@end

@interface MineScanningController : BaseController

@property(nonatomic,assign)id<MineScanningControllerViewDelegate>delegate;

@end
