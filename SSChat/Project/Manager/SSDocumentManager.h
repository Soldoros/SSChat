//
//  SSDocumentManager.h
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

/*
 文档本地化的管理
 */
#import <Foundation/Foundation.h>


@interface SSDocumentManager : NSObject


/**
 获取app临时文件k路径

 @return 返回路径
 */
+ (NSString *)getAppTempPath;


/**
 获取app文件路径

 @return 返回路径
 */
+(NSString *)getAPPDocumentPath;


/**
 获取当前用户文件夹路径

 @return 返回路径
 */
+(NSString *)getUserDocumentPath;




/**
 用户文档路径

 @param suffix 添加后缀
 @return 返回路径
 */
+(NSString *)getAccountDocumentPath:(NSString *)suffix;

@end



