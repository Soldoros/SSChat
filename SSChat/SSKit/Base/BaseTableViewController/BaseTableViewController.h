//
//  BaseTableViewController.h
//  htcm
//
//  Created by soldoros on 2018/7/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseController.h"




@interface BaseTableViewController : BaseController


/**
 类族中的表单类型，可以直接继承设置
 */
@property(nonatomic,assign)UITableViewStyle tableViewStyle;

-(id)initWithTableViewStyle:(UITableViewStyle)tableStyle;


/**
 表单的高度，表单在根页面和子页面的高度有差距，实际高度还是在实体控制器中决定
 */
@property(nonatomic,assign)CGFloat tableViewH;


/**
 视图控制器的表单
 */
@property(nonatomic,strong)UITableView *mTableView;


/**
 表单的数据源，此处是可变数组
 */
@property(nonatomic,strong)NSMutableArray *datas;


/**
 表单的数据源，此处是可变字典，因为有一些界面复杂的，数据源不规则的界面需要用到字典接收数据
 */
@property(nonatomic,strong)NSMutableDictionary *dicts;


/**
 表单翻页显示的时候，需要用到page
 */
@property(nonatomic,assign)NSInteger page;






@end
