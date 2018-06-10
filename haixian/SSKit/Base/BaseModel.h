//
//  BaseModel.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseController.h"


/**
 网络请求类型选择 总共有八种类型

 - BaseNetworkRequestPost: 不带表头的post请求
 - BaseNetworkRequestPostHeader: 带表头的post请求
 - BaseNetworkRequestGet: 不带表头的get请求
 - BaseNetworkRequestGetHeader: 带表头的get请求
 - BaseNetworkRequestDelete: 不带表头的delete请求
 - BaseNetworkRequestDeleteHeader: 带表头的delete请求
 - BaseNetworkRequestPut: 不带表头put请求
 - BaseNetworkRequestPutHeader: 带表头的put请求
 */
typedef NS_ENUM(NSInteger,BaseNetworkRequestType) {
    BaseNetworkRequestPost = 1,
    BaseNetworkRequestPostHeader,
    BaseNetworkRequestGet,
    BaseNetworkRequestGetHeader,
    BaseNetworkRequestDelete,
    BaseNetworkRequestDeleteHeader,
    BaseNetworkRequestPut,
    BaseNetworkRequestPutHeader,
};


/**
 请求返回的状态和数据的代码块
 
 @param status 网络请求返回的状态
 @param object 请求返回的数据
 */
typedef void (^Block)(HtmcNetworkingStatus status,NSString *message,id object);



@interface BaseModel : NSObject


@property(nonatomic,strong)SSNoneStatus *noneStatus;

//模型转换的相关方法
@property(nonatomic,strong) id currentKey;
-(id)initWithDic:(NSDictionary *)dic;
-(NSMutableArray *)modelsWithArray:(NSArray *)array;


//请求参数 控制器对象
@property(nonatomic,strong)NSDictionary *parameters;
@property(nonatomic,strong)BaseController *baseController;



/**
 网络请求

 @param requestType 选择网络请求类型
 @param controller 相关的控制器对象
 @param parameters 相关键值对参数
 @param method 网络请求地址
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestNetWorking:(BaseNetworkRequestType)requestType controller:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block;



/**
 网络请求传入相关参数 Post请求

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param block 返回请求的数据信息代码块
 */
+(void)BaseRequestPost:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block;



/**
 网络请求传入相关参数 带表头的post请求

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param headerUrl 表头
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestPost:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block;


/**
 网络请求传入相关参数 Get请求

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestGet:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block;



/**
 网络请求传入相关参数 带表头的Get请求

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param headerUrl 表头信息
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestGet:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block;




/**
 网络请求传入相关参数 不带表头的delete请求

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestDelete:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block;




/**
 网络请求传入相关参数 带表头的delete请求

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param headerUrl 表头
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestDelete:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block;




/**
 网络请求传入相关参数 不带表头的put请求
 
 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestPut:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block;




/**
 网络请求传入相关参数 带表头的put请求
 
 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param headerUrl 表头
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestPut:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block;




/**
 带表头的post请求上传图片

 @param controller 控制器对象
 @param parameters 参数键值对
 @param method 接口地址
 @param headerUrl 表头
 @param imgData  封装的二进制文件
 @param block 返回请求的数据代码块
 */
+(void)BaseRequestPostData:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl imgData:(NSData *)imgData block:(Block)block;








@end
