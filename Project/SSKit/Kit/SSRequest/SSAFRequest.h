//
//  SSAFRequest.h
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SSRequestStatus.h"
#import "SSRequestDefine.h"



/**
 请求参数的上传格式

 - RequestJson: 参数用json格式上传
 - RequestHTTP: 参数用普通键值对上传
 - RequestProperty: 参数用普通键值对上传
 */
typedef NS_ENUM(NSInteger,SSRequestCode) {
    RequestJson = 1,
    RequestHTTP = 2,
    RequestProperty = 3
};



/**
 请求的数据返回格式

 - SSResponseSerializerJson: 用json data返回 需要解析
 - SSResponseSerializerHTTP: 用价值对返回 直接使用
 */
typedef NS_ENUM(NSInteger,SSResponseSerializer) {
    SSResponseSerializerJson = 1,
    SSResponseSerializerHTTP,
};

/**
 网络请求类型选择 总共有八种类型
 
 - SSRequestPost: 不带表头的post请求
 - SSRequestPostHeader: 带表头的post请求
 - SSRequestGet: 不带表头的get请求
 - SSRequestGetHeader: 带表头的get请求
 - SSRequestDelete: 不带表头的delete请求
 - SSRequestDeleteHeader: 带表头的delete请求
 - SSRequestPut: 不带表头put请求
 - SSRequestPutHeader: 带表头的put请求
 */
typedef NS_ENUM(NSInteger,SSRequestType) {
    SSRequestPost = 1,
    SSRequestPostHeader,
    SSRequestGet,
    SSRequestGetHeader,
    SSRequestDelete,
    SSRequestDeleteHeader,
    SSRequestPut,
    SSRequestPutHeader,
};


/**
 *  提供对AFN返回的网络状态封装
 *
 *  @param status 返回网络状态是否可用
 */
typedef void (^Status)(NSInteger status);


/**
 *  提供对AFN的封装
 *
 *  @param object 返回的数据
 *  @param error  请求报错
 */
typedef void (^Result)(id object,NSError *error, NSURLSessionDataTask *task);


@interface SSAFRequest : NSObject



/**
 取消所有网络请求
 */
+(void)cancelAllRequest;


/**
 设置请求头

 @param manager AFHTTPSessionManager对象
 @param header 请求头value
 */
+(void)setHeader:(AFHTTPSessionManager *)manager header:(NSString *)header;


/**
 网络请求
 
 @param requestType 选择网络请求类型
 @param parameters 相关键值对参数
 @param method 网络请求地址
 @param requestHeader 请求头设置
 @param result 返回请求的数据代码块
 */
+(void)RequestNetWorking:(SSRequestType)requestType parameters:(id)parameters method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result;


//POST请求  不带表头的  上传普通参数  JSON 1   HTTP 2   其他 3
+(void)postWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;


// 带请求头的post 上传普通格式参数
+(void)postWithHedaer:(id)dic method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result;


//不带表头的get请求
+(void)getWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;

// 带请求头的get请求 上传普通格式参数
+(void)getWithHeader:(NSDictionary *)dic method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result;

//不带表头的delete请求
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;


//带表头的delete请求
+(void)deleteWithHeader:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;


//不带表头的put请求
+(void)putWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;

//带表头的put请求
+(void)putWithHeader:(NSDictionary *)dic method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result;




//post上传头像 带请求头  上传普通参数  JSON 1   HTTP 2   其他 3
+(void)PostWithFile:(NSDictionary *)dic method:(NSString *)method  imgData:(NSData *)imgData name:(NSString *)name requestHeader:(NSDictionary *)requestHeader result:(Result)result;


//发送多个文件 上传普通参数  JSON 1   HTTP 2   其他 3
+(void)PostWithFiles:(NSDictionary *)dic method:(NSString *)method  datas:(NSArray *)datas names:(NSArray *)names requestHeader:(NSDictionary *)requestHeader result:(Result)result;


//fomart格式的post请求
+(void)PostFomart:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;


#pragma mark - 检测网络状态 共4种状态
+(void)startCheckNetStatus:(Status)netStatus;

//关闭监测
+(void)stopCheckNetStatus;



#pragma mark - Session 下载
typedef void (^ProgressBlock)(NSProgress *progress);
typedef void (^DownloadBlock)(NSString *filePath);
+(void)downloadWithUrlString:(NSString *)method progressBlock:(ProgressBlock)progressBlock downloadBlock:(DownloadBlock)downloadBlock;



+ (id)JSONObjectWithData:(NSData *)data;




@end
