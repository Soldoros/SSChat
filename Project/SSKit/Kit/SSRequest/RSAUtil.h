//
//  RSAUtil.h
//  Encryption
//
//  Created by 雷传营 on 16/1/10.
//  Copyright © 2016年 leichuanying. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

@interface RSAUtil : NSObject

//公钥
#define RSA_Public_key         @"MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGA4dMjeOA4Y5YWveZIzT/EL8nTJn2pB38jds26SERRP7DYoNB8oCokKJNZFIIKHYQTlEJeIbV8Htp349mGQgh3/eCAm6h4feYrT5ADJmJ2L8Wy1mE9gATgqpWlhMtdhDD+c5tFTI87nXiJTV/B+eG9j7Gl9y1fVowO4/CHIlTgdAgMBAAE="

//私钥
#define RSA_Privite_key        @"MIIBUwIBADANBgkqhkiG9w0BAQEFAASCAT0wggE5AgEAAkEAmg00Vqsh8fvI/AuJkzigJeOHlGvEPNS0cJqkRKwduGJ7/VD1w1RHEclQLuI/DmHpBKClu/kp4vo1xTt27fAyNwIDAQABAkAk71+KHBPScdzZWWbNznjPPMNH+aKeNx1gFiOmd2HU0B/az7dskcdBaqfWM9qJ+Qh5FtWymbRc26raMPRTseKRAiEA5PPOBvD0ndtsCAarfQR9UFMk7xz4/VVhiVlRJs9y3vkCIQCsQC3NViiH6GhOvdB2k2gNIcfZuUowtvpqV6732nt2rwIgJugrjdBqsVy1WhPQFpmptfm7IAs7YMmenpmYCdFdAvkCIHWieuUxgwqWAK5N2VExiCz3tfmOHgm43LnFWhuwnQLHAiALoxkBoZPXy3wPzTkA+4pbGdUN0AopbasRm2psirBhkQ=="


// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw datax
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
// enc with private key NOT working YET!
//+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
//+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
