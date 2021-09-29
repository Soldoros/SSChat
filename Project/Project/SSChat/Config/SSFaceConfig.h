//
//  SSFaceConfig.h
//  Project
//
//  Created by soldoros on 2021/9/27.
//

//表情资源
#import <Foundation/Foundation.h>

//表情视图的表单cell
#define DeleteButtonId  @"DeleteButtonId"
//表情的行数 列数
#define SSChatEmojiRow     4
#define SSChatEmojiLine    7
//系统自带表情的参数
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);


NS_ASSUME_NONNULL_BEGIN

@interface SSFaceConfig : NSObject

+(SSFaceConfig *)shareFaceConfig;

//系统提供的表情库
@property(nonatomic,strong)NSMutableArray *systemImages;

@end

NS_ASSUME_NONNULL_END
