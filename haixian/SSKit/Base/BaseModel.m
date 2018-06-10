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


//根据实际网络请求的状态值 返回 已经封装的状态值
+(HtmcNetworkingStatus)htcmStatusWithOtherStatus:(NSInteger)status controller:(BaseController *)controller{
    HtmcNetworkingStatus htcmStatus= [NSString statusWithNetWorkingStatus:status];
    
    //201 202  204都属于正常数据
    if(htcmStatus == HtmcNetworkingVaule201 ||
       htcmStatus == HtmcNetworkingVaule202 ||
       htcmStatus == HtmcNetworkingVaule204) {
        htcmStatus = HtmcNetworkingDefault;
    }
    
    //判断登录状态
    if(htcmStatus == HtmcNetworkingVaule401){
        
        
    }
    return htcmStatus;
}


//获取网络请求原生的状态值 并生成已经封装的 HtmcNetworkingStatus 并返回
+(HtmcNetworkingStatus)htcmStatusWith:(NSURLSessionDataTask *)task controller:(BaseController *)controller{
    NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = responses.statusCode;
    
    cout(@(statusCode));
    HtmcNetworkingStatus htcmStatus = [self htcmStatusWithOtherStatus:statusCode controller:controller];
    return htcmStatus;
}

//获取网络请求的原生展示信息  并根据信息和网络状态值生成封装的展示信息
+(NSString *)messageWithNetworkingError:(NSError *)error htcmStatus:(HtmcNetworkingStatus)htcmStatus{
    NSString *jss = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    NSDictionary *errorDic = makeDicWithJsonStr(jss);
    
    NSString *message = errorDic[@"message"];
    if(!message || message.length==0){
        message = [NSString HtmcNetStatus:htcmStatus];
    }
    return message;
}


//网络请求
+(void)BaseRequestNetWorking:(BaseNetworkRequestType)requestType controller:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block{
    
    //首先检查网络情况
    [SSRequest startCheckNetStatus:^(NSInteger status) {
        [SSRequest stopCheckNetStatus];
        
        //网络异常不可用
        if(status==AFNetworkReachabilityStatusNotReachable ||
           status==AFNetworkReachabilityStatusUnknown){
            cout(@(status));
            NSInteger index = (NSInteger)status;
            HtmcNetworkingStatus htcmStatus = [NSString statusWithNetStatus:index];
            cout([NSString HtmcNetStatus:htcmStatus]);
            block(htcmStatus,[NSString HtmcNetStatus:htcmStatus],nil);
        }
        
        else{
        
            //拼接好地址段
            NSString *netUrlString = makeString(URLStrUse, method);
            
            switch (requestType) {
                case BaseNetworkRequestPost:{
                    [BaseModel BaseRequestPost:controller parameters:parameters method:netUrlString block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestPostHeader:{
                    [BaseModel BaseRequestPost:controller parameters:parameters method:netUrlString headerUrl:URLHeaderUrl block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestGet:{
                    [BaseModel BaseRequestGet:controller parameters:parameters method:netUrlString block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestGetHeader:{
                    [BaseModel BaseRequestGet:controller parameters:parameters method:netUrlString headerUrl:URLHeaderUrl block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestDelete:{
                    [BaseModel BaseRequestDelete:controller parameters:parameters method:netUrlString block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestDeleteHeader:{
                    [BaseModel BaseRequestDelete:controller parameters:parameters method:netUrlString headerUrl:URLHeaderUrl block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestPut:{
                    [BaseModel BaseRequestPut:controller parameters:parameters method:netUrlString block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                case BaseNetworkRequestPutHeader:{
                    [BaseModel BaseRequestPut:controller parameters:parameters method:netUrlString headerUrl:URLHeaderUrl block:^(HtmcNetworkingStatus status, NSString *message, id object) {
                        block(status,message,object);
                    }];
                }
                    break;
                    
                default:
                    
                    break;
            }
            
        }
        
        
    }];
    
}


//网络请求post 不带请求头
+(void)BaseRequestPost:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block{
    
        [SSRequest postWith:parameters method:method result:^(id object, NSError *error, NSURLSessionDataTask *task) {

            HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
            NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
            block(htcmStatus,message,object);
        }];

}


//网络请求post  带表头的请求
+(void)BaseRequestPost:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block{
   
            [SSRequest postWith:parameters method:method header:headerUrl result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
            }];
 
}


//网络请求get  不带表头的
+(void)BaseRequestGet:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block{
  
            [SSRequest getWith:parameters method:method result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
            }];

}



//网络请求get 带表头的
+(void)BaseRequestGet:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block{

            [SSRequest getWith:parameters method:method header:headerUrl result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
            }];

}


//不带表头的delete请求
+(void)BaseRequestDelete:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block{

            
            [SSRequest deleteWith:parameters method:method result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
            }];

    
}


//带表头的delete请求
+(void)BaseRequestDelete:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block{

            [SSRequest deleteWith:parameters method:method header:headerUrl result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
            }];

    
}



//不带表头的put请求
+(void)BaseRequestPut:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method block:(Block)block{

            [SSRequest putWith:parameters method:method result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
                
            }];

    
}




//代表头的put请求
+(void)BaseRequestPut:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl block:(Block)block{

            [SSRequest putWith:parameters method:method header:headerUrl result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
            }];

}




//带表头的post请求上传图片
+(void)BaseRequestPostData:(BaseController *)controller parameters:(NSDictionary *)parameters method:(NSString *)method headerUrl:(NSString *)headerUrl imgData:(NSData *)imgData block:(Block)block{
    
    //拼接好地址段
    NSString *netUrlString = makeString(URLStrUse, method);
    
    //首先检查网络情况
    [SSRequest startCheckNetStatus:^(NSInteger status) {
        [SSRequest stopCheckNetStatus];
        //网络异常不可用
        if(status==AFNetworkReachabilityStatusNotReachable ||
           status==AFNetworkReachabilityStatusUnknown){
            NSInteger index = (NSInteger)status;
            HtmcNetworkingStatus htcmStatus = [NSString statusWithNetStatus:index];
            block(htcmStatus,[NSString HtmcNetStatus:htcmStatus],nil);
        }
        
        //正常网络
        else{
            
            [SSRequest PostWith:parameters method:netUrlString header:URLHeaderUrl imgData:imgData result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                
                HtmcNetworkingStatus htcmStatus = [self htcmStatusWith:task controller:controller];
                NSString *message = [self messageWithNetworkingError:error htcmStatus:htcmStatus];
                block(htcmStatus,message,object);
                
            }];
        }
        
    }];
    
    
}








@end
