//
//  UITableView+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "UITableView+SSAdd.h"

@implementation UITableView (DEAdd)


-(void)registerClass:(NSString *)classStr andCellId:(NSString *)cellId{
    Class class = NSClassFromString(classStr);
    [self registerClass:class forCellReuseIdentifier:cellId];
}


-(void)registerClass:(NSArray *)classArr
          andCellIds:(NSArray *)cellIds
{
    for(int i=0;i<classArr.count;++i)
    {
        [self registerClass:NSClassFromString(classArr[i]) forCellReuseIdentifier:cellIds[i]];
    }
}

-(void)registerClass:(NSString *)classStr andHeaderFooterId:(NSString *)headerId{
    Class class = NSClassFromString(classStr);
    [self registerClass:class forHeaderFooterViewReuseIdentifier:headerId];
}



//设置cell线条的位置 上左下右
-(void)setCelllineWithCell:(UITableViewCell *)cell top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    UIEdgeInsets edg = UIEdgeInsetsMake(top, left, bottom, right);
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:edg];    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setSeparatorInset:edg];    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:edg];    }
}


@end
