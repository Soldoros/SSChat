//
//  ServiceRegisterTask.m
//  SSChat
//
//  Created by soldoros on 2019/5/20.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ServiceRegisterTask.h"


@implementation ServiceRegisterUser

@end



@implementation ServiceRegisterTask

+ (void)registerUser:(ServiceRegisterUser *)user
          completion:(ServiceRegisterHandler)completion{

    NSURLRequest *request = [ServiceRegisterTask taskRequest:user];
    
    NSURLSession *_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionTask *sessionTask = [_session dataTaskWithRequest:request  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable connectionError) {
        id jsonObject = nil;
        NSError *error = connectionError;
        if (connectionError == nil &&  [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] == 200)
        {
            if (data){
                jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            }
            else {
                error = [NSError errorWithDomain:@"ntes domain" code:-1 userInfo:@{@"description" : @"invalid data"}];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [ServiceRegisterTask onGetResponse:jsonObject error:error completion:completion];
        });
    }];
    [sessionTask resume];
}


+ (NSURLRequest *)taskRequest:(ServiceRegisterUser *)user{
    
    NSString *urlString = @"https://app.netease.im/api/createDemoUser";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"Post"];
    
    [request addValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"nim_demo_ios" forHTTPHeaderField:@"User-Agent"];
    [request addValue:[[NIMSDK sharedSDK] appKey] forHTTPHeaderField:@"appkey"];
    
    NSString *postData = [NSString stringWithFormat:@"username=%@&password=%@&nickname=%@",user.account, user.token, user.nickname];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
    
}


+ (void)onGetResponse:(id)jsonObject error:(NSError *)error completion:(ServiceRegisterHandler)completion{
    
    NSError *resultError = error;
    NSString *errMsg = @"unknown error";
    
    if (error == nil && [jsonObject isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *dict = (NSDictionary *)jsonObject;
        NSInteger code = [dict[@"res"] integerValue];
        resultError = code == 200 ? nil :  [NSError errorWithDomain:@"ntes domain" code:code userInfo:nil];
        errMsg = dict[@"errmsg"];
    }
    if (completion){
        completion(resultError,errMsg);
    }
}


@end
