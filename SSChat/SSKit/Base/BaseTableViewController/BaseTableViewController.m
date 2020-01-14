//
//  BaseTableViewController.m
//  htcm
//
//  Created by soldoros on 2018/7/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewPlainController.h"
#import "BaseTableViewGroupedController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController


-(id)initWithTableViewStyle:(UITableViewStyle)tableStyle{
    switch (tableStyle) {
        case UITableViewStylePlain:{
            return [BaseTableViewPlainController new];
        }
            break;
        case UITableViewStyleGrouped:{
            return [BaseTableViewGroupedController new];
        }
            break;
        default:
            break;
    }
    return self;
}







@end
