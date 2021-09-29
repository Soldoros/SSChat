//
//  SSAFRequest.m
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*
 
 
   
 //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
 //    [dic setValue:@"iosApp" forKey:@"source"];
     
 
 */

#import "SSAFRequest.h"
#import "RSAUtil.h"

@implementation SSAFRequest


+(void)cancelAllRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

//设置默认请求头
+(void)setHeader:(AFHTTPSessionManager *)manager requestHeader:(NSDictionary *)requestHeader{
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"jsCode" forHTTPHeaderField:@"X-WX-Code"];
    [manager.requestSerializer setValue:@"encryptedData" forHTTPHeaderField:@"X-WX-Encrypted-Data"];
    
    if(requestHeader != nil){
        for(NSString *headerKey in requestHeader){
            [manager.requestSerializer setValue:requestHeader[headerKey] forHTTPHeaderField:headerKey];
        }
    }
}


//设置登录后的请求头
+(void)setAuthHeader:(AFHTTPSessionManager *)manager{
    
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //"F2C224D4-2BCE-4C64-AF9F-A6D872000D1A" = 1;
    //code = 0;
    //mid = 1032221112;
    //phone = 13333333333;
    //session =     {
    //    id = "app_13333333333";
    //    skey = a7cfc740442f4bc18a4dd2061c6f1022;
    //    userId = 103223;
    //};
    //wxmpNo = 200;
    NSDictionary *headerDic = [SSRootAccount getUserToken];
    [manager.requestSerializer setValue:[headerDic[@"session"][@"id"]description] forHTTPHeaderField:@"X-WX-Id"];
    [manager.requestSerializer setValue:[headerDic[@"session"][@"skey"]description] forHTTPHeaderField:@"X-WX-Skey"];
    
}


//登录过期后回退到个人中心
+(void)setResult:(Result)result object:(id)object error:(NSError *)error task:(NSURLSessionDataTask *)task{
    NSDictionary *dic = makeDicWithJsonStr(object);
    if([dic[@"code"]integerValue] == -1){
        [self sendNotifCation:NotiLoginStatusChange data:@(NO)];
        UIViewController *vc = [UIViewController getCurrentController];
        vc.tabBarController.selectedIndex = 4;
        [vc.navigationController popToRootViewControllerAnimated:YES];
        result(object,error,task);
    }
    else{
        result(object,error,task);
    }
}

//用参数形式传递tocken
+(NSDictionary *)dicWithTocken:(NSDictionary *)dic{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *header = @"";
    NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:dic];
    cout(header);
    [dd setValue:header forKey:@"token"];
    
    return dd;
}


//网络请求
+(void)RequestNetWorking:(SSRequestType)requestType parameters:(id)parameters method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    NSString *urlString = makeString(URLContentString, method);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValuesForKeysWithDictionary:parameters];
    
    cout(urlString);
    switch (requestType) {
        case SSRequestPost:{
            
            [SSAFRequest postWith:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
            
        }
            break;
        case SSRequestPostHeader:{
            
            [SSAFRequest postWithHedaer:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestGet:{
            [SSAFRequest getWith:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestGetHeader:{
            
            [SSAFRequest getWithHeader:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestPut:{
            [SSAFRequest putWith:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestPutHeader:{
            
            [SSAFRequest putWithHeader:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestDelete:{
            [SSAFRequest deleteWith:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestDeleteHeader:{
            
            [SSAFRequest deleteWithHeader:dic method:urlString requestHeader:requestHeader result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
               
            }];
        }
            break;
        default:
            break;
    }
}



//POST请求  不带表头的  上传普通参数  JSON 1   HTTP 2   其他 3
+(void)postWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
   
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送数据json
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [SSAFRequest setHeader:manager requestHeader:requestHeader];
    
    [manager POST:method parameters:dic headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        cout(@(responses.statusCode));
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
            result(nil,error,task);
    }];
    
    
    
}



// 带请求头的post 上传普通格式参数
+(void)postWithHedaer:(id)dic method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送数据json
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [SSAFRequest setAuthHeader:manager];
        
    [manager POST:method parameters:dic headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        cout(@(responses.statusCode));
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
            result(nil,error,task);
    }];
    
    
}



//不带表头的get请求
+(void)getWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [SSAFRequest setHeader:manager requestHeader:requestHeader];
    
    
    [manager GET:method parameters:dic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}


// 带请求头的get请求 上传普通格式参数
+(void)getWithHeader:(NSDictionary *)dic method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [SSAFRequest setAuthHeader:manager];
  

    [manager GET:method parameters:dic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}


//不带表头的delete请求
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [SSAFRequest setHeader:manager requestHeader:requestHeader];
    
    [manager DELETE:method parameters:dic headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}


//带表头的delete请求
+(void)deleteWithHeader:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager DELETE:method parameters:dic headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}



//不带表头的put请求
+(void)putWith:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    [SSAFRequest setHeader:manager requestHeader:requestHeader];
    
    [manager PUT:method parameters:dic headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}



//带表头的put请求
+(void)putWithHeader:(NSDictionary *)dic method:(NSString *)method  requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager PUT:method parameters:dic headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
}


//post上传头像 带请求头  上传普通参数  JSON 1   HTTP 2   其他 3
+(void)PostWithFile:(NSDictionary *)dic method:(NSString *)method  imgData:(NSData *)imgData name:(NSString *)name requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [SSAFRequest setAuthHeader:manager];
    
    [manager POST:method parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imgData name:name fileName:@"icon.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        NSDictionary *dd = makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]);
        cout(dd);
        result(nil,error,task);
    }];
    
}


//发送多个文件 上传普通参数  JSON 1   HTTP 2   其他 3
+(void)PostWithFiles:(NSDictionary *)dic method:(NSString *)method  datas:(NSArray *)datas names:(NSArray *)names requestHeader:(NSDictionary *)requestHeader result:(Result)result{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager POST:method parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(int i=0;i<datas.count;++i){
            NSData *data = datas[i];
            if(data){
                [formData appendPartWithFileData:data name:names[i] fileName:@"htcmImage.jpg" mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        result(nil,error,task);
    }];
    
    
}

//fomart格式的post请求
+(void)PostFomart:(NSDictionary *)dic method:(NSString *)method requestHeader:(NSDictionary *)requestHeader result:(Result)result;{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送数据json
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [SSAFRequest setAuthHeader:manager];
        
    [manager POST:method parameters:dic headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        cout(@(responses.statusCode));
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
            result(nil,error,task);
    }];
    
}





#pragma mark - 检测网络状态 共4种状态
+(void)startCheckNetStatus:(Status)netStatus{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        netStatus(status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:{
                NSLog(@"其他网络");
            }
                break;
        }
        
    }] ;
    
    [manager startMonitoring];
}


//关闭监测
+(void)stopCheckNetStatus{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}



#pragma mark - Session 下载
+(void)downloadWithUrlString:(NSString *)method progressBlock:(ProgressBlock)progressBlock downloadBlock:(DownloadBlock)downloadBlock{
    
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:[method stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //下载进度
        NSLog(@"%@",downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载到哪个文件夹
        NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *fileName=[cachePath stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL fileURLWithPath:fileName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成了
        NSLog(@"下载完成了 %@",filePath);
        
        downloadBlock(filePath.path);
    }];
    
    // 5.启动下载任务
    [task resume];
}




+ (id)JSONObjectWithData:(NSData *)data{
    
    if (data.length == 0) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return object;
}





@end
