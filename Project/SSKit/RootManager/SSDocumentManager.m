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
    NSString *documentPath = [path  stringByAppendingPathComponent:AppName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return documentPath;
}


+(NSString *)getAccountDocumentPath:(NSString *)suffix{
    
    NSString *path = [[SSDocumentManager getAPPDocumentPath]  stringByAppendingPathComponent:suffix];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return path;
}

@end
