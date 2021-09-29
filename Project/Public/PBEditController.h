//
//  PBEditController.h
//  htcm1
//
//  Created by soldoros on 2018/5/21.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseViewController.h"


@protocol PBEditControllerDelegate <NSObject>

-(void)PBEditControllerBtnClick:(NSString *)string indexPath:(NSIndexPath *)indexPath;

@end

@interface PBEditController : BaseViewController

@property(nonatomic,assign)id<PBEditControllerDelegate>delegate;

//显示单行输入框1  还是多行2
@property(nonatomic,assign)NSInteger type;

//输入框的默认文字
@property(nonatomic,strong)NSString *editPlaceholder;

//列表的分组
@property(nonatomic,strong)NSIndexPath *indexPath;





@end
