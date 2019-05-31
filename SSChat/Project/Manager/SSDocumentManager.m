//
//  SSDocumentManager.m
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//


#import "SSDocumentManager.h"

@implementation SSDocumentManager

+ (NSString *)getAppTempPath{
    
    return NSTemporaryDirectory();
}

+(NSString *)getAPPDocumentPath{

    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *documentPath = [path  stringByAppendingPathComponent:[[NIMSDK sharedSDK] appKey]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return documentPath;
}


+(NSString *)getUserDocumentPath{
    
    NSString *user = [NIMSDK sharedSDK].loginManager.currentAccount;
    NSString *userPath = [[SSDocumentManager getAPPDocumentPath]  stringByAppendingPathComponent:user];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:userPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:userPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return userPath;
}


+(NSString *)getAccountDocumentPath:(NSString *)suffix{
    
    NSString *userPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                          
    if (![[NSFileManager defaultManager] fileExistsAtPath:userPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:userPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return userPath;
}

@end
