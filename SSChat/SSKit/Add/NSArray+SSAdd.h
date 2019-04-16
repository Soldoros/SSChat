//
//  NSArray+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/30.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DEAdd)

/**
 *  取出数组前面NUM个数据组成数组并返回
 *
 *  @param num 需要取出数据的个数
 *
 *  @return 返回的还是数组
 */
-(NSArray *)getArrayWithNum:(NSInteger)num;



@end
