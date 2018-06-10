//
//  DERequest.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "SSRequest.h"




@implementation SSRequest

//正式服APPID
#define FormalAppId        @"453"
//测试服APPID
#define TestAppId          @"453"


//设置请求头
+(void)setHeader:(AFHTTPSessionManager *)manager header:(NSString *)header{
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}

//POST请求  不带表头的  上传普通参数
+(void)postWith:(NSDictionary *)dic method:(NSString *)method result:(Result)result{
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    [manager POST:method parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        cout(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        cout(@(responses.statusCode));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];
    
}


// 带请求头的post 上传普通格式参数
+(void)postWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [SSRequest setHeader:manager header:header];
    
    [manager POST:method parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        cout(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        result(nil,error,task);
    }];
 
    
}

//不带表头的get请求
+(void)getWith:(NSDictionary *)dic method:(NSString *)method   result:(Result)result{
    

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:method parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];
    
}


// 带请求头的get请求 上传普通格式参数
+(void)getWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result{
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头
    [SSRequest setHeader:manager header:header];

    [manager GET:method parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];
    
    
}


//不带表头的delete请求
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method   result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager DELETE:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];

    
}


//带表头的delete请求
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method header:(NSString *)header result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头
    [SSRequest setHeader:manager header:header];
    
    [manager DELETE:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];
}




//不带表头的put请求
+(void)putWith:(NSDictionary *)dic method:(NSString *)method   result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager PUT:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];

}



//带表头的put请求
+(void)putWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header  result:(Result)result{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    // 声明上传普通格式的参数
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 返回Data格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头
    [SSRequest setHeader:manager header:header];
    
    [manager PUT:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];
    
}




//post上传头像 带请求头
+(void)PostWith:(NSDictionary *)dic method:(NSString *)method  header:(NSString *)header imgData:(NSData *)imgData  result:(Result)result;{
 
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 设置请求头
    [SSRequest setHeader:manager header:header];

    
    [manager POST:method parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        cout(formData);
        if(imgData){
            [formData appendPartWithFileData:imgData name:@"avatar" fileName:@"htcmImage.jpg" mimeType:@"image/png/jpeg"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

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
+(void)downloadWithUrlString:(NSString *)method{
    
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:method];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"%@---%@", response, filePath);
    }];
    // 5.启动下载任务
    [task resume];
}

#pragma mark - 随机文件名上传
+(void)postUpload{
    
    //    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //
    //    [manager POST:@"http://localhost/demo/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //
    //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
    //
    //        // 要上传保存在服务器中的名称
    //        // 使用时间来作为文件名 2014-04-30 14:20:57.png
    //        // 让不同的用户信息,保存在不同目录中
    //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //        // 设置日期格式
    //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //        NSString *fileName = [formatter stringFromDate:[NSDate date]];
    //
    //        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:@"image/png" error:NULL];
    //
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"OK");
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"error");
    //    }];
    
}


#pragma mark - POST上传
+(void)postUploadn{
    //
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    //    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    //    // 例如返回一个html,text...
    //    //
    //    // 实际上就是AFN没有对响应数据做任何处理的情况
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //
    //    // formData是遵守了AFMultipartFormData的对象
    //    [manager POST:@"http://localhost/demo/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //
    //        // 将本地的文件上传至服务器
    //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
    //
    //        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //
    //        NSLog(@"完成 %@", result);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"错误 %@", error.localizedDescription);
    //    }];
    //
}

#pragma mark - XML格式返回 的请求
- (void)XMLData{
    
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //
    //    // 返回的数据格式是XML
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //
    //    NSDictionary *dict = @{@"format": @"xml"};
    //
    //    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    //    [manager GET:@"http://localhost/videos.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        // 如果结果是XML,同样需要使用6个代理方法解析,或者使用第三方库
    //        // 第三方库第三方框架,效率低,内存泄漏
    //        NSLog(@"%@", responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"%@", error);
    //    }];
    
}



+ (id)JSONObjectWithData:(NSData *)data
{
    if (data.length == 0) {
        
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return object;
}


@end
