//
//  SSRequestEncryption.m
//  YongHui
//
//  Created by soldoros on 2019/6/30.
//  Copyright © 2019 soldoros. All rights reserved.
//

//参数加密
#import "SSRequestEncryption.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation SSRequestEncryption

+ (NSDictionary *)paramsEncryptWithParams:(NSDictionary *)params aesKey:(NSString *)key aesIv:(NSString *)iv{
    
    NSMutableDictionary *paramenter = [NSMutableDictionary dictionary];
    paramenter[@"timestamp"] = [[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970] * 1000] stringValue];
    paramenter[@"nonce"] = [self get32bitRandomString];
    [paramenter addEntriesFromDictionary:params];
    
    //1.自然排序
    NSArray *keys = [paramenter allKeys];
    NSArray *sortKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    
    NSString  *connect = @"&";
    for (id key in sortKeys) {
        connect = [connect stringByAppendingString:key];
        connect = [connect stringByAppendingString:@"="];
        connect = [connect stringByAppendingString:[paramenter objectForKey:key]];
        connect = [connect stringByAppendingString:@"&"];
    }
    if (connect.length > 1) {
        connect = [connect substringWithRange:NSMakeRange(1, connect.length - 2)];
    }
    //2.AES加密
    NSString *aesCiphertext = [self encryptionAESWithString:connect key:key iv:iv];
    //3.$ + AES + $
    NSString *aesConnect = [NSString stringWithFormat:@"$%@$",aesCiphertext];
    //4.md5加密
    NSString *sign = [self MD5ForUpper32Bate:aesConnect];
    
    paramenter[@"sign"] = sign;
    return paramenter;
}

+ (NSString *)get32bitRandomString{
    char data[32];
    for (int x = 0; x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}


#pragma mark --MD5
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}

#pragma mark --AES
+ (NSString *)encryptionAESWithString:(NSString *)content key:(NSString *)key iv:(NSString *)iv {
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128operation:kCCEncrypt data:data key:key iv:iv];
    NSString *encString = [AESData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encString;
}

+ (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation,
                                            kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            keyPtr,
                                            kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes],
                                            [data length],
                                            buffer,
                                            bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    else
    {
        NSLog(@"aes_error");
    }
    
    free(buffer);
    return nil;
}




@end
