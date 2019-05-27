//
//  SSAccountManager.m
//  SSChat
//
//  Created by soldoros on 2019/5/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSAccountManager.h"
#import "SSDocumentManager.h"

static  NSString *Model_account   = @"account";
static  NSString *Model_password  = @"password";

@implementation SSAccountModel : NSObject

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    
    if(self = [super init]){
        _account   = [aDecoder decodeObjectForKey:Model_account];
        _password  = [aDecoder decodeObjectForKey:Model_password];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
    [aCoder encodeObject:_account  forKey:Model_account];
    [aCoder encodeObject:_password forKey:Model_password];
}

@end



@implementation SSAccountManager

static SSAccountManager *account = nil;

+(instancetype)shareSSAccountManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[SSAccountManager alloc] init];
    });
    return account;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _filePath  = [[SSDocumentManager getAPPDocumentPath] stringByAppendingPathComponent:@"account_login_data"];
        [self readLocalDatas];
    }
    return self;
}


-(void)setAccountModel:(SSAccountModel *)accountModel{
    _accountModel = accountModel;
    [self saveLocalDatas];
}

-(void)readLocalDatas{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:_filePath]){
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
        _accountModel = [object isKindOfClass:[SSAccountModel class]] ? object : nil;
    }
}

-(void)saveLocalDatas{
    [NSKeyedArchiver archiveRootObject:_accountModel toFile:_filePath];
}


@end
