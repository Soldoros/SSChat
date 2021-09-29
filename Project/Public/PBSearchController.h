//
//  PBSearchController.h
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//



//搜索页面
#import "BaseCollectionViewController.h"
#import "PBViews.h"


@interface PBSearchController : BaseCollectionViewController

//搜索结果
@property(nonatomic,strong)NSString *searchString;
//是否成为第一响应者
@property(nonatomic,assign)BOOL FirstResponder;
//搜索状态 是否在输入中
@property(nonatomic,assign)BOOL isSearch;


@end
