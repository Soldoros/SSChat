//
//  NSObject+JsonAutoSerialize.h
//  AMapFoundation
//
//  Created by zhou on 2018/2/1.
//  Copyright © 2018年 Amap.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络自动化解析数组定义宏
#define AMapJsonArray(key,type)  NSArray <type *> *key;     \
@property (nonatomic, strong, readonly) type *__Array__##key

#define AMapJsonMutableArray(key,type)  NSMutableArray <type *> *key;     \
@property (nonatomic, strong, readonly) type *__Array__##key

#define AMapNestedArray(key,type)   NSArray *key;     \
@property (nonatomic, strong, readonly) type *__Array__##key

#define AMapNestedMutableArray(key,type)    NSMutableArray *key;     \
@property (nonatomic, strong, readonly) type *__Array__##key

//#define AMapBind(key,propertyName,type)    *key;     \
//@property (nonatomic, strong, readonly) type *__Bind__##propertyName##__##key

@protocol AMapJsonManualSerialization <NSObject>

@optional

- (void)manualDeserializationJsonData:(NSDictionary *)jsonDictionary forInfo:(id)customInfo;

- (NSMutableDictionary *)manualSerializeObjectForInfo:(id)customInfo;

@end

@interface NSObject (AMapJsonSerialization)

// 反序列化自动解析Json数据，并根据和dictionaryJson的key匹配的属性名进行自动赋值，注意dictionaryJson需要和对象对应，注意只有非基础类型属性的解析才会回调手动解析(需实现AMapManuallParseJson协议)
- (void)amf_deserializationJsonData:(NSDictionary *)dictionaryJson forInfo:(id)customInfo;

// 将Module数据对象序列化成Json数据对象的Dictionary,对于NSString、NSMutableArray、NSNumber、NSNull、NSArray和NSMutableArray会返回nil
- (NSMutableDictionary *)amf_serializeJsonObjectForInfo:(id)customInfo;

// 将NSArray或NSMutableArray序列化成Json数据对象的数组,仅适用于是NSArray和NSMutableArray类型的对象调用,否则会返回nil
- (NSMutableArray *)amf_serializeJsonArrayForInfo:(id)customInfo;

@end
