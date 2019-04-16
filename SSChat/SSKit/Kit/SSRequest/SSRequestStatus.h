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
 
 - SSRequestStatusVaule201: 对象创建成功
 - SSRequestStatusVaule202: 请求已被接受
 - SSRequestStatusVaule204: 操作已经执行成功 但是没有返回数据
 
 - SSRequestStatusVaule301: 资源已被移除
 - SSRequestStatusVaule303: 重定向
 - SSRequestStatusVaule304: 资源没有被修改
 - SSRequestStatusVaule400: 参数列表错误（缺少，格式不匹配）
 - SSRequestStatusVaule401: 未授权（请重新登录）
 - SSRequestStatusVaule403: 访问受限，授权过期
 - SSRequestStatusVaule404: 资源，服务未找到
 - SSRequestStatusVaule405: 不允许的http方法
 - SSRequestStatusVaule409: 资源冲突，或者资源被锁定
 - SSRequestStatusVaule415: 不支持的数据（媒体）类型
 - SSRequestStatusVaule429: 请求过多被限制
 - SSRequestStatusVaule500: 系统内部错误
 - SSRequestStatusVaule501: 接口未实现
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
    
    SSRequestStatusVaule201 ,
    SSRequestStatusVaule202 ,
    SSRequestStatusVaule204 ,
    
    SSRequestStatusVaule301 ,
    SSRequestStatusVaule303 ,
    SSRequestStatusVaule304 ,
    SSRequestStatusVaule400 ,
    SSRequestStatusVaule401 ,
    SSRequestStatusVaule403 ,
    SSRequestStatusVaule404 ,
    SSRequestStatusVaule405 ,
    SSRequestStatusVaule409 ,
    SSRequestStatusVaule415 ,
    SSRequestStatusVaule429 ,
    SSRequestStatusVaule500 ,
    SSRequestStatusVaule501 ,
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
 根据枚举状态返回展示信息
 
 @param statusCode 网络请求返回的状态
 @return 返回相对应的展示信息
 */
+(NSString *)SSRequestMessageWithStatusCode:(SSRequestStatusCode)statusCode;














@end
