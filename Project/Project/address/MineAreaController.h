//
//  MineAreaController.h
//  YongHui
//
//  Created by soldoros on 2019/7/2.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "BaseViewController.h"

//地址返回
typedef void(^MineAreaControllerBlock)(NSString *province, NSString *city, NSString *area);


@interface MineAreaController : BaseViewController

@property(nonatomic,copy)MineAreaControllerBlock handle;

-(void)setSSPickerViewAnimation;

@end


