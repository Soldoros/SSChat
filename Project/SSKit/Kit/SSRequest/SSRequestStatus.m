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
            
            //资源服务未找到
        case 404:
            statusCode = SSRequestStatusVaule404;
            break;
            
            //其他异常
        default:
            statusCode = SSRequestStatusDefault;
            break;
    }
    
    
    return statusCode;
    
}


//根据枚举状态来返回显示信息
+(NSString *)msg:(NSInteger)code{
    
    
    NSString *message = @"";
    switch (code) {
        case 0:
            message = @"操作成功";
            break;
        case 1:
            message = @"服务器内部错误";
            break;
        case 2:
            message = @"Json解析错误";
            break;
        case 3:
            message = @"用户未登录";
            break;
        case 4:
            message = @"用户名或密码或用户设备不能为空";
            break;
        case 5:
            message = @"用户名或密码错误";
            break;
        case 6:
            message = @"未知用户设备";
            break;
        case 7:
            message = @"接收方ID不能为空";
            break;
        case 8:
            message = @"发送方ID不能为空";
            break;
        case 9:
            message = @"群组ID不能为空";
            break;
        case 10:
            message = @"用户权限不足";
            break;
        case 11:
            message = @"用户Id不能为空";
            break;
        case 12:
            message = @"群组名字不能为空";
            break;
            
        default:
            message = @"其他异常";
            break;
    }
    return message;
}




@end





