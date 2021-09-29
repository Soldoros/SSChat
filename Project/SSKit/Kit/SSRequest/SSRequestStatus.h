//
//  SSRequestStatus.h
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>




/**
 网络状态统计
 
 - SSRequestStatusDefault 返回数据正常 200,
 - SSRequestStatusVaule1: 未知网络错误
 - SSRequestStatusVaule2: 无网络错误
 - SSRequestStatusVaule3: 蜂窝网络
 - SSRequestStatusVaule4: WIFI网络
 - SSRequestStatusVaule5: 其他网络
 - SSRequestStatusVaule6: 网络异常不可用
 
 - SSRequestStatusVaule11: 正在加载
 - SSRequestStatusVaule12: 数据为空
 - SSRequestStatusVaule13: 加载异常
 
 - SSRequestStatusVaule404: 资源，服务未找到
 
 */

typedef NS_ENUM(NSInteger,SSRequestStatusCode) {
    
    SSRequestStatusDefault = 200,
    
    SSRequestStatusVaule1 ,
    SSRequestStatusVaule2 ,
    SSRequestStatusVaule3 ,
    SSRequestStatusVaule4 ,
    SSRequestStatusVaule5 ,
    SSRequestStatusVaule6 ,
    
    SSRequestStatusVaule11 ,
    SSRequestStatusVaule12 ,
    SSRequestStatusVaule13 ,
    
    SSRequestStatusVaule404
};



@interface SSRequestStatus : NSObject



/**
 根据网络状态返回枚举值
 
 @param index 传入网络状态 网络状态不是网络请求状态
 @return 返回枚举状态
 */
+(SSRequestStatusCode)statusWithNetStatus:(NSInteger)index;




/**
 根据网络请求的状态返回枚举状态
 
 @param index 传入网络请求的状态
 @return 返回枚举的状态
 */
+(SSRequestStatusCode)statusWithRequestStatus:(NSInteger)index;




/**
 根据请求返回的code展示相关信息
 
 @param code 网络请求返回的状态
 @return 返回相对应的展示信息
 */
+(NSString *)msg:(NSInteger)code;














@end
