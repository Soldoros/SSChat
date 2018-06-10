//
//  NSMutableDictionary+AMapSave.h
//  AMapFoundationKit
//
//  Created by zhou on 2018/2/23.
//  Copyright © 2018年 Amap.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary <KeyType, ObjectType> (AMapSafe)

- (BOOL)amf_setObjectSafe:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

@end
