//
//  BaseModel.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewController.h"


@interface BaseModel : NSObject


/**
 通过键值对初始化模型对象  也就是把字典转换成模型

 @param dic 传入键值对
 @return 返回当前对象
 */
-(id)initWithDic:(NSDictionary *)dic;


//模型转换的相关方法
@property(nonatomic,strong) id currentKey;


/**
 字典数组转换成模型数组

 @param array 传入字典数组
 @return 返回模型数组
 */
-(NSMutableArray *)modelsWithArray:(NSArray *)array;





/**
 通过控制器对象初始化模型
 
 @param controller 传入控制器
 @return 返回当前对象
 */
-(instancetype)initWithController:(BaseTableViewController *)controller;











@end
