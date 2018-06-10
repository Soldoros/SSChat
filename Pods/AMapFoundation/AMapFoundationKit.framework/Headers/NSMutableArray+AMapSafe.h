//
//  NSArray(AMapSave).h
//  AMapFoundationKit
//
//  Created by zhou on 2018/2/23.
//  Copyright © 2018年 Amap.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray<ObjectType> (AMapSafe)

- (BOOL)amf_addObjectSafe:(ObjectType)anObject;

@end
