//
//  DERequest.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

#define org_name         @"doros"
#define app_name         @"hello"

#define UrlString        @"http://120.77.247.228/brand/index.php"



/**
 *  提供对AFN的封装
 *
 *  @param object 返回的数据
 *  @param error  请求报错
 */
typedef void (^Result)(id object,NSError *error, NSURLSessionDataTask *task);

/**
 *  提供对AFN返回的网络状态封装
 *
 *  @param status 返回网络状态是否可用
 */
typedef void (^Status)(NSInteger status);

@interface SSRequest : NSObject


/**
 *  没有表头的post请求
 *
 *  @param dic    请求传入的参数
 *  @param method 请求的地址
 *  @param result 返回的结果 block类型
 */
+(void)postWith:(NSDictionary *)dic method:(NSString *)method result:(Result)result;



/**
 带表头的post请求

 @param dic 请求参数
 @param method 请求地址
 @param header 请求头
 @param result 返回的结果代码块
 */
+(void)postWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result;



/**
 没有表头的get请求

 @param dic 请求传入的参数
 @param method 请求的地址
 @param result 返回的结果代码块
 */
+(void)getWith:(NSDictionary *)dic method:(NSString *)method   result:(Result)result;


/**
 带表头的get请求
 
 @param dic 请求传入的参数
 @param method 请求的地址
 @param header 请求的表头
 @param result 返回的结果代码块
 */
+(void)getWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result;



/**
 不带表头的delete请求

 @param dic 请求传入的参数
 @param method 请求的地址
 @param result 返回的结果代码块
 */
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method   result:(Result)result;



/**
 带表头的delete请求

 @param dic 请求传入的参数
 @param method 请求的地址
 @param header 请求头
 @param result 返回的结果代码块
 */
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result;



/**
 不带表头的put请求
 
 @param dic 请求传入的参数
 @param method 请求的地址
 @param result 返回的结果代码块
 */
+(void)putWith:(NSDictionary *)dic method:(NSString *)method   result:(Result)result;


/**
 带表头的put请求
 
 @param dic 请求传入的参数
 @param method 请求的地址
 @param header 请求头
 @param result 返回的结果代码块
 */
+(void)putWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result;




/**
 代表头的post请求上传data数据（一般上传图片）

 @param dic 参数键值对
 @param method 网络请求地址
 @param header 请求头
 @param imgData data数据（上传图片）
 @param result 返回请求结果的代码块
 */
+(void)PostWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header imgData:(NSData *)imgData  result:(Result)result;






//pragma mark - 检测网络连接
+(void)startCheckNetStatus:(Status)netStatus;
+(void)stopCheckNetStatus;

//pragma mark - Session 下载
+(void)downloadWithUrlString:(NSString *)method;

//pragma mark - 随机文件名上传
+(void)postUpload;

//pragma mark - POST上传
+(void)postUploadn;

//pragma mark - XML格式返回 的请求
- (void)XMLData;





@end
