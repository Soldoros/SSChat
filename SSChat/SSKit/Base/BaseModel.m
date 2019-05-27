//
//  BaseModel.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.




#import "BaseModel.h"


@implementation BaseModel

//对于存在的并且值相等的key直接赋值
-(id)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        for(NSString *str in [dic allKeys]){
            [self setValue:dic[str] forKey:str];
        }
    }
    return self;
}

-(NSMutableArray *)modelsWithArray:(NSArray *)array{
    NSMutableArray *arr = [NSMutableArray new];
    for(NSDictionary *dic in array){
        [arr addObject:[self initWithDic:dic]];
    }
    return arr;
}

//对于不存在的key  和  特殊的key值(这里采用加前缀model_)处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([_currentKey isEqualToString:key])return;
    _currentKey = [NSString stringWithFormat:@"%@%@",@"model_",key];
    [super setValue:value forKey:_currentKey];
}



//通过控制器参数初始化模型对象
-(instancetype)initWithController:(BaseTableViewController *)controller{
    if(self = [super init]){

    }
    return self;
}









@end
