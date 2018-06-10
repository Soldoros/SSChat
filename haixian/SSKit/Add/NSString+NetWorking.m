//
//  NSString+NetWorking.m
//  Project
//
//  Created by soldoros on 2016/12/19.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "NSString+NetWorking.h"

@implementation NSString (NetWorking)

+(NSString *)EMErrorWith:(EMErrorCode)errorCode{
    
    NSString *errorString = @"";
    switch (errorCode) {
        case EMErrorGeneral:
            errorString = @"网络异常!";
            break;
        case EMErrorNetworkUnavailable:
            errorString = @"网络不可用!";
            break;
        case EMErrorDatabaseOperationFailed:
            errorString = @"数据库操作失败!";
            break;
        case EMErrorInvalidAppkey:
            errorString = @"APPKEY无效!";
            break;
        case EMErrorInvalidUsername:
            errorString = @"无效的用户名!";
            break;
        case EMErrorInvalidPassword:
            errorString = @"无效的密码!";
            break;
        case EMErrorInvalidURL:
            errorString = @"无效的URL地址!";
            break;
        case EMErrorUserAlreadyLogin:
            errorString = @"用户已登录!";
            break;
        case EMErrorUserNotLogin:
            errorString = @"用户未登录!";
            break;
        case EMErrorUserAuthenticationFailed:
            errorString = @"密码验证失败!";
            break;
        case EMErrorUserAlreadyExist:
            errorString = @"用户已存在!";
            break;
        case EMErrorUserNotFound:
            errorString = @"用户不存在!";
            break;
        case EMErrorUserIllegalArgument:
            errorString = @"请求参数不合法!";
            break;
        case EMErrorUserLoginOnAnotherDevice:
            errorString = @"当前用户在另一台设备登录!";
            break;
        case EMErrorUserRemoved:
            errorString = @"用户数据被物理删除!";
            break;
        case EMErrorUserRegisterFailed:
            errorString = @"用户注册失败!";
            break;
        case EMErrorUpdateApnsConfigsFailed:
            errorString = @"更新推送设置失败!";
            break;
        case EMErrorUserPermissionDenied:
            errorString = @"用户没有权限做该操作!";
            break;
        case EMErrorServerNotReachable:
            errorString = @"服务器未连接!";
            break;
        case EMErrorServerTimeout:
            errorString = @"请求服务超时!";
            break;
        case EMErrorServerBusy:
            errorString = @"服务器繁忙!";
            break;
        case EMErrorServerUnknownError:
            errorString = @"未知服务错误!";
            break;
        case EMErrorServerGetDNSConfigFailed:
            errorString = @"获取DNS设置失败!";
            break;
        case EMErrorServerServingForbidden:
            errorString = @"服务被禁用!";
            break;
        case EMErrorFileNotFound:
            errorString = @"文件没有找到!";
            break;
        case EMErrorFileInvalid:
            errorString = @"文件无效!";
            break;
        case EMErrorFileUploadFailed:
            errorString = @"上传文件失败!";
            break;
        case EMErrorFileDownloadFailed:
            errorString = @"下载文件失败!";
            break;
        case EMErrorMessageInvalid:
            errorString = @"消息无效!";
            break;
        case EMErrorMessageIncludeIllegalContent:
            errorString = @"消息包含非法信息!";
            break;
        case EMErrorMessageTrafficLimit:
            errorString = @"单位时间发送消息超过上限!";
            break;
        case EMErrorMessageEncryption:
            errorString = @"加密错误!";
            break;
        case EMErrorGroupInvalidId:
            errorString = @"群组ID无效!";
            break;
        case EMErrorGroupAlreadyJoined:
            errorString = @"已加入群组!";
            break;
        case EMErrorGroupNotJoined:
            errorString = @"未加入群组!";
            break;
        case EMErrorGroupPermissionDenied:
            errorString = @"没有权限进行该操作!";
            break;
        case EMErrorGroupMembersFull:
            errorString = @"群成员数已达到上限!";
            break;
        case EMErrorGroupNotExist:
            errorString = @"群组不存在!";
            break;
        case EMErrorChatroomInvalidId:
            errorString = @"聊天室ID无效!";
            break;
        case EMErrorChatroomAlreadyJoined:
            errorString = @"已加入聊天室!";
            break;
        case EMErrorChatroomNotJoined:
            errorString = @"未加入聊天室!";
            break;
        case EMErrorChatroomPermissionDenied:
            errorString = @"没有权限进行该操作!";
            break;
        case EMErrorChatroomMembersFull:
            errorString = @"聊天室成员个数达到上限!";
            break;
        case EMErrorChatroomNotExist:
            errorString = @"聊天室不存在!";
            break;
        case EMErrorCallInvalidId:
            errorString = @"实时通话ID无效!";
            break;
        case EMErrorCallBusy:
            errorString = @"已经在进行实时通话了!";
            break;
        case EMErrorCallRemoteOffline:
            errorString = @"对方不在线!";
            break;
        case EMErrorCallConnectFailed:
            errorString = @"实时通话建立连接失败!";
            break;
        default:
            break;
    }
    
    return errorString;
}


//根据网络状态返回枚举值   注：网络状态不是网络请求的状态
+(HtmcNetworkingStatus)statusWithNetStatus:(NSInteger)index{

    HtmcNetworkingStatus htmcStatus;
    switch (index) {
        case -1:
            htmcStatus = HtmcNetworkingVaule1;
            break;
            //无网络
        case 0:
            htmcStatus = HtmcNetworkingVaule2;
            break;
            //蜂窝网络
        case 1:
            htmcStatus = HtmcNetworkingVaule3;
            break;
            //wifi网络
        case 2:
            htmcStatus = HtmcNetworkingVaule4;
            break;
        default:
            htmcStatus = HtmcNetworkingVaule5;
            break;
    }
    
    return htmcStatus;
}


//根据网络请求的状态返回枚举的状态
+(HtmcNetworkingStatus)statusWithNetWorkingStatus:(NSInteger)index{

    HtmcNetworkingStatus htmcStatus;
    
    switch (index) {

            //操作成功
        case 200:
            htmcStatus = HtmcNetworkingDefault;
            break;
            //对象创建成功
        case 201:
            htmcStatus = HtmcNetworkingVaule201;
            break;
            //请求已被接受
        case 202:
            htmcStatus = HtmcNetworkingVaule202;
            break;
            //操作已经执行成功 但是没有返回数据
        case 204:
            htmcStatus = HtmcNetworkingVaule204;
            break;
            //资源已被移除
        case 301:
            htmcStatus = HtmcNetworkingVaule301;
            break;
            //重定向
        case 303:
            htmcStatus = HtmcNetworkingVaule303;
            break;
            //资源没有被修改
        case 304:
            htmcStatus = HtmcNetworkingVaule304;
            break;
            //参数列表错误（缺少、格式不匹配）
        case 400:
            htmcStatus = HtmcNetworkingVaule400;
            break;
            //未授权（请重新登录）
        case 401:
            htmcStatus = HtmcNetworkingVaule401;
            break;
            //访问受限 授权过期
        case 403:
            htmcStatus = HtmcNetworkingVaule403;
            break;
            //资源服务未找到
        case 404:
            htmcStatus = HtmcNetworkingVaule404;
            break;
            //不允许的http方法
        case 405:
            htmcStatus = HtmcNetworkingVaule405;
            break;
            //资源冲突
        case 409:
            htmcStatus = HtmcNetworkingVaule409;
            break;
            //不支持的数据（媒体）类型
        case 415:
            htmcStatus = HtmcNetworkingVaule415;
            break;
            //请求过多被限制
        case 429:
            htmcStatus = HtmcNetworkingVaule429;
            break;
            //系统内部错误
        case 500:
            htmcStatus = HtmcNetworkingVaule500;
            break;
            //接口未实现
        case 501:
            htmcStatus = HtmcNetworkingVaule501;
            break;

            //其他异常
        default:
            htmcStatus = HtmcNetworkingVaule500;
            break;
    }
    
    
    return htmcStatus;
    
}


//根据枚举状态来返回显示信息
+(NSString *)HtmcNetStatus:(HtmcNetworkingStatus)status{

    
    NSString *message = @"";
    switch (status) {
        case HtmcNetworkingDefault:
            message = @"操作成功";
            break;
        case HtmcNetworkingVaule1:
            message = @"未知网络错误";
            break;
        case HtmcNetworkingVaule2:
            message = @"无网络错误";
            break;
        case HtmcNetworkingVaule3:
            message = @"蜂窝网络";
            break;
        case HtmcNetworkingVaule4:
            message = @"WIFI网络";
            break;
        case HtmcNetworkingVaule5:
            message = @"其他网络";
            break;
        case HtmcNetworkingVaule6:
            message = @"网络不可用";
            break;
        case HtmcNetworkingVaule11:
            message = @"正在加载...";
            break;
        case HtmcNetworkingVaule12:
            message = @"暂无任何数据";
            break;
        case HtmcNetworkingVaule13:
            message = @"加载异常";
            break;
        case HtmcNetworkingVaule201:
            message = @"对象创建成功（201）";
            break;
        case HtmcNetworkingVaule202:
            message = @"请求已被接受（202）";
            break;
        case HtmcNetworkingVaule204:
            message = @"操作成功执行，无返回数据（204）";
            break;
        case HtmcNetworkingVaule301:
            message = @"资源已被移除（301）";
            break;
        case HtmcNetworkingVaule303:
            message = @"重定向（303）";
            break;
        case HtmcNetworkingVaule304:
            message = @"资源没有被修改（304）";
            break;
        case HtmcNetworkingVaule400:
            message = @"参数列表错误（缺少、格式不匹配）（400）";
            break;
        case HtmcNetworkingVaule401:
            message = @"未授权（请重新登录401）";
            break;
        case HtmcNetworkingVaule403:
            message = @"访问受限，授权过期（403）";
            break;
        case HtmcNetworkingVaule404:
            message = @"资源、服务未找到（404）";
            break;
        case HtmcNetworkingVaule405:
            message = @"不允许的http方法（405）";
            break;
        case HtmcNetworkingVaule409:
            message = @"资源冲突、资源被锁定（409）";
            break;
        case HtmcNetworkingVaule415:
            message = @"不支持的数据（媒体）类型（415）";
            break;
        case HtmcNetworkingVaule429:
            message = @"请求过多被限制（429）";
            break;
        case HtmcNetworkingVaule500:
            message = @"系统内部错误（500）";
            break;
        case HtmcNetworkingVaule501:
            message = @"接口未实现（501）";
            break;
            
        default:
            message = @"其他异常";
            break;
    }
    return message;
}














@end
