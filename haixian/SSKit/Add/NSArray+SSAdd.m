//
//  NSArray+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/30.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "NSArray+SSAdd.h"

@implementation NSArray (DEAdd)


-(NSArray *)getArrayWithNum:(NSInteger)num{
    
    NSMutableArray *marray = [NSMutableArray new];
    for(int i=0;i<num;++i){
        id obj = [self objectAtIndex:i];
        [marray addObject:obj];
    }
    return marray;
}

@end
