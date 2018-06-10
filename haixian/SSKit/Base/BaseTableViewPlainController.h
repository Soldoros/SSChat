//
//  BaseTableViewPlainController.h
//  htcm
//
//  Created by soldoros on 2018/4/16.
//  Copyright © 2018年 soldoros. All rights reserved.
//



#import "BaseController.h"



/**
 表单用代码初始化给出了两种样式 这里采用表头和表尾悬浮的样式 表头表尾无分割线
 系统给出的样式竟然只能使用一次 xib中可以修改 纯代码不行 所以新建两个表单基类
 */
@interface BaseTableViewPlainController : BaseController<UITableViewDelegate,UITableViewDataSource>


//header footer高度自适应 并且给header  footer赋值
- (void)configureHedaerFooter:(id)view atInSection:(NSInteger)section;

//cell高度自适应 并且给cell赋值
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;



@end
