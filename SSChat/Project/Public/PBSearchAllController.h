//
//  PBSearchAllController.h
//  htcm
//
//  Created by soldoros on 2018/7/24.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//所有的搜索
#import "BaseTableViewGroupedController.h"
#import "PBSearchView.h"

@interface PBSearchAllController : BaseTableViewGroupedController

//搜索类型 医生 科室 症状
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
