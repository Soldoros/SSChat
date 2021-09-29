//
//  SSRequestEncryption.h
//  YongHui
//
//  Created by soldoros on 2019/6/30.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSRequestEncryption : NSObject

+ (NSDictionary *)paramsEncryptWithParams:(NSDictionary *)params aesKey:(NSString *)key aesIv:(NSString *)iv;

@end

NS_ASSUME_NONNULL_END
