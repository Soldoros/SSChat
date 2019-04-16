//
//  SSRequestStatusStatus.m
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSRequestStatus.h"

@implementation SSRequestStatus




//根据网络状态返回枚举值   注：网络状态不是网络请求的状态
+(SSRequestStatusCode)statusWithNetStatus:(NSInteger)index{
    
    SSRequestStatusCode statusCode;
    switch (index) {
        case -1:
            statusCode =SSRequestStatusVaule1;
            break;
            //无网络
        case 0:
            statusCode = SSRequestStatusVaule2;
            break;
            //蜂窝网络
        case 1:
            statusCode = SSRequestStatusVaule3;
            break;
            //wifi网络
        case 2:
            statusCode = SSRequestStatusVaule4;
            break;
        default:
            statusCode = SSRequestStatusVaule5;
            break;
    }
    
    return statusCode;
}


//根据网络请求的状态返回枚举的状态
+(SSRequestStatusCode)statusWithRequestStatus:(NSInteger)index{
    
    SSRequestStatusCode statusCode;
    
    switch (index) {
            
            //操作成功
        case 200:
            statusCode = SSRequestStatusDefault;
            break;
            //对象创建成功
        case 201:
            statusCode = SSRequestStatusVaule201;
            break;
            //请求已被接受
        case 202:
            statusCode = SSRequestStatusVaule202;
            break;
            //操作已经执行成功 但是没有返回数据
        case 204:
            statusCode = SSRequestStatusVaule204;
            break;
            //资源已被移除
        case 301:
            statusCode = SSRequestStatusVaule301;
            break;
            //重定向
        case 303:
            statusCode = SSRequestStatusVaule303;
            break;
            //资源没有被修改
        case 304:
            statusCode = SSRequestStatusVaule304;
            break;
            //参数列表错误（缺少、格式不匹配）
        case 400:
            statusCode = SSRequestStatusVaule400;
            break;
            //未授权（请重新登录）
        case 401:
            statusCode = SSRequestStatusVaule401;
            break;
            //访问受限 授权过期
        case 403:
            statusCode = SSRequestStatusVaule403;
            break;
            //资源服务未找到
        case 404:
            statusCode = SSRequestStatusVaule404;
            break;
            //不允许的http方法
        case 405:
            statusCode = SSRequestStatusVaule405;
            break;
            //资源冲突
        case 409:
            statusCode = SSRequestStatusVaule409;
            break;
            //不支持的数据（媒体）类型
        case 415:
            statusCode = SSRequestStatusVaule415;
            break;
            //请求过多被限制
        case 429:
            statusCode = SSRequestStatusVaule429;
            break;
            //系统内部错误
        case 500:
            statusCode = SSRequestStatusVaule500;
            break;
            //接口未实现
        case 501:
            statusCode = SSRequestStatusVaule501;
            break;
            
            //其他异常
        default:
            statusCode = SSRequestStatusVaule500;
            break;
    }
    
    
    return statusCode;
    
}


//根据枚举状态来返回显示信息
+(NSString *)SSRequestMessageWithStatusCode:(SSRequestStatusCode)status{
    
    
    NSString *message = @"";
    switch (status) {
        case SSRequestStatusDefault:
            message = @"操作成功";
            break;
        case SSRequestStatusVaule1:
            message = @"未知网络错误";
            break;
        case SSRequestStatusVaule2:
            message = @"无网络错误";
            break;
        case SSRequestStatusVaule3:
            message = @"蜂窝网络";
            break;
        case SSRequestStatusVaule4:
            message = @"WIFI网络";
            break;
        case SSRequestStatusVaule5:
            message = @"其他网络";
            break;
        case SSRequestStatusVaule6:
            message = @"网络不可用";
            break;
        case SSRequestStatusVaule11:
            message = @"正在加载...";
            break;
        case SSRequestStatusVaule12:
            message = @"暂无数据";
            break;
        case SSRequestStatusVaule13:
            message = @"加载异常";
            break;
        case SSRequestStatusVaule201:
            message = @"对象创建成功（201）";
            break;
        case SSRequestStatusVaule202:
            message = @"请求已被接受（202）";
            break;
        case SSRequestStatusVaule204:
            message = @"操作成功执行，无返回数据（204）";
            break;
        case SSRequestStatusVaule301:
            message = @"资源已被移除（301）";
            break;
        case SSRequestStatusVaule303:
            message = @"重定向（303）";
            break;
        case SSRequestStatusVaule304:
            message = @"资源没有被修改（304）";
            break;
        case SSRequestStatusVaule400:
            message = @"参数列表错误（缺少、格式不匹配）（400）";
            break;
        case SSRequestStatusVaule401:
            message = @"账号或密码错误（401）";
            break;
        case SSRequestStatusVaule403:
            message = @"账户未授权（403）";
            break;
        case SSRequestStatusVaule404:
            message = @"资源、服务未找到（404）";
            break;
        case SSRequestStatusVaule405:
            message = @"不允许的http方法（405）";
            break;
        case SSRequestStatusVaule409:
            message = @"资源冲突、资源被锁定（409）";
            break;
        case SSRequestStatusVaule415:
            message = @"不支持的数据（媒体）类型（415）";
            break;
        case SSRequestStatusVaule429:
            message = @"请求过多被限制（429）";
            break;
        case SSRequestStatusVaule500:
            message = @"服务器或网络异常";
            break;
        case SSRequestStatusVaule501:
            message = @"接口未实现（501）";
            break;
            
        default:
            message = @"其他异常";
            break;
    }
    return message;
}






@end





