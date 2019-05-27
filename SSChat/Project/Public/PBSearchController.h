//
//  PBSearchController.h
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//



//搜索页面
#import "BaseTableViewGroupedController.h"
#import "PBSearchView.h"


@interface PBSearchController : BaseTableViewGroupedController


//会话搜索 添加好友搜索 好友搜索 黑名单搜索
@property(nonatomic,assign)PBSearchAllType searchType;

//搜索结果
@property(nonatomic,strong)NSString *searchString;
//搜索框
@property(nonatomic,strong) UISearchBar *mSearchBar;
//是否成为第一响应者
@property(nonatomic,assign)BOOL FirstResponder;
//搜索状态 是否在输入中
@property(nonatomic,assign)BOOL isSearch;




@end
