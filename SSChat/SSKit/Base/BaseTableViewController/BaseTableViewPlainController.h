//
//  BaseTableViewPlainController.h
//  htcm
//
//  Created by soldoros on 2018/4/16.
//  Copyright © 2018年 soldoros. All rights reserved.
//



#import "BaseTableViewController.h"



@interface BaseTableViewPlainController : BaseTableViewController<UITableViewDelegate,UITableViewDataSource>


/**
 基于UITableView+FDTemplateLayoutCell 的表单header和footer的高度自适应
 
 @param view 传入表单的表头或者表尾
 @param section 传入表单分组
 */
- (void)configureHedaerFooter:(id)view atInSection:(NSInteger)section;



/**
 基于UITableView+FDTemplateLayoutCell 的表单cell高度自适应
 
 @param cell 传入表单的cell
 @param indexPath 传入表单cell的分组
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;



@end
