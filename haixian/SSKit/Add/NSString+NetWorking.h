//
//  NSString+NetWorking.h
//  Project
//
//  Created by soldoros on 2016/12/19.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HyphenateLite/HyphenateLite.h>

@interface NSString (NetWorking)



/**
 返回网络状态码并展示提示信息

 @param errorCode 环信的状态码 需要集成环信
 @return 根据状态码返回提示信息  这里用人家的东西 顺便封装一下 哎！
 */
+(NSString *)EMErrorWith:(EMErrorCode)errorCode;





#define NetKeyStatus    @"status"
#define NetKeyMessage   @"message"





/**
 网络状态统计

 - HtmcNetworkingDefault 返回数据正常 200,
 - HtmcNetworkingVaule1: 未知网络错误
 - HtmcNetworkingVaule2: 无网络错误
 - HtmcNetworkingVaule3: 蜂窝网络
 - HtmcNetworkingVaule4: WIFI网络
 - HtmcNetworkingVaule5: 其他网络
 - HtmcNetworkingVaule6: 网络异常不可用
 
 - HtmcNetworkingVaule11: 正在加载
 - HtmcNetworkingVaule12: 数据为空
 - HtmcNetworkingVaule13: 加载异常
 
 - HtmcNetworkingVaule201: 对象创建成功
 - HtmcNetworkingVaule202: 请求已被接受
 - HtmcNetworkingVaule204: 操作已经执行成功 但是没有返回数据
 
 - HtmcNetworkingVaule301: 资源已被移除
 - HtmcNetworkingVaule303: 重定向
 - HtmcNetworkingVaule304: 资源没有被修改
 - HtmcNetworkingVaule400: 参数列表错误（缺少，格式不匹配）
 - HtmcNetworkingVaule401: 未授权（请重新登录）
 - HtmcNetworkingVaule403: 访问受限，授权过期
 - HtmcNetworkingVaule404: 资源，服务未找到
 - HtmcNetworkingVaule405: 不允许的http方法
 - HtmcNetworkingVaule409: 资源冲突，或者资源被锁定
 - HtmcNetworkingVaule415: 不支持的数据（媒体）类型
 - HtmcNetworkingVaule429: 请求过多被限制
 - HtmcNetworkingVaule500: 系统内部错误
 - HtmcNetworkingVaule501: 接口未实现
 */
typedef NS_ENUM(NSInteger,HtmcNetworkingStatus) {
    
    HtmcNetworkingDefault = 200,
    
    HtmcNetworkingVaule1 ,
    HtmcNetworkingVaule2 ,
    HtmcNetworkingVaule3 ,
    HtmcNetworkingVaule4 ,
    HtmcNetworkingVaule5 ,
    HtmcNetworkingVaule6 ,
    
    HtmcNetworkingVaule11 ,
    HtmcNetworkingVaule12 ,
    HtmcNetworkingVaule13 ,
    
    HtmcNetworkingVaule201 ,
    HtmcNetworkingVaule202 ,
    HtmcNetworkingVaule204 ,
    
    HtmcNetworkingVaule301 ,
    HtmcNetworkingVaule303 ,
    HtmcNetworkingVaule304 ,
    HtmcNetworkingVaule400 ,
    HtmcNetworkingVaule401 ,
    HtmcNetworkingVaule403 ,
    HtmcNetworkingVaule404 ,
    HtmcNetworkingVaule405 ,
    HtmcNetworkingVaule409 ,
    HtmcNetworkingVaule415 ,
    HtmcNetworkingVaule429 ,
    HtmcNetworkingVaule500 ,
    HtmcNetworkingVaule501 ,
};





/**
 根据网络状态返回枚举值

 @param index 传入网络状态 网络状态不是网络请求状态
 @return 返回枚举状态
 */
+(HtmcNetworkingStatus)statusWithNetStatus:(NSInteger)index;


/**
 根据网络请求的状态返回枚举状态

 @param index 传入网络请求的状态
 @return 返回枚举的状态
 */
+(HtmcNetworkingStatus)statusWithNetWorkingStatus:(NSInteger)index;




/**
 根据枚举状态返回展示信息

 @param status 网络请求返回的状态
 @return 返回相对应的展示信息
 */
+(NSString *)HtmcNetStatus:(HtmcNetworkingStatus)status;









@end
