//
//  UITableView+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DEAdd)

-(void)registerClass:(NSString *)classStr andCellId:(NSString *)cellId;

-(void)registerClass:(NSArray *)classArr
          andCellIds:(NSArray *)cellIds;

-(void)setCelllineWithCell:(UITableViewCell *)cell top:(CGFloat)top left:(CGFloat)left  bottom:(CGFloat)bottom right:(CGFloat)right;

-(void)registerClass:(NSString *)classStr andHeaderFooterId:(NSString *)headerId;

@end
