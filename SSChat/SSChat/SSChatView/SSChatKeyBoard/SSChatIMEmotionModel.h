//
//  SSChatIMEmotionModel.h
//  htcm
//
//  Created by soldoros on 2018/6/1.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//表情视图的表单cell
#define DeleteButtonId  @"DeleteButtonId"

//表情的行数 列数
#define SSChatEmojiRow     3
#define SSChatEmojiLine    7

//系统自带表情的参数
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);



/**
 表情模型
 */
@interface SSChatIMEmotionModel : NSObject

+ (SSChatIMEmotionModel *)modelWithDictionary:(NSDictionary*)dic atIndex:(int)index;

//for post, ex:[0]
@property (nonatomic, copy) NSString* code;
//for parse, ex:[微笑]
@property (nonatomic, copy) NSString* name;
//ex, Expression_1.png
@property (nonatomic, copy) NSString* imageName;

@end





/**
 配置表情，包括系统自带的表情 还有本地导入的表情
 */
@interface SSChartEmotionImages : NSObject

@property(nonatomic,strong)NSMutableArray *emotions;
@property(nonatomic,strong)NSMutableArray<UIImage*> *images;
@property(nonatomic,strong)NSMutableArray *codes;
@property(nonatomic,strong)NSMutableArray *systemImages;


+ (SSChartEmotionImages *)ShareSSChartEmotionImages;
- (void)initEmotionImages;
- (void)initSystemEmotionImages;

//对数组进行处理
-(NSMutableArray *)dealWithArray:(NSMutableArray *)arr1 arr2:(NSMutableArray *)arr2;

//将表情图转换成字符串
-(NSString *)emotionStringWithImg:(UIImage *)image;
//将字符串转换成对应的表情图
-(UIImage *)emotionImgWithString:(NSString *)string;

//将字符串中所有的表情字符串转换成图片 并返回可变字符串
-(NSMutableAttributedString *)emotionImgsWithString:(NSString *)string;

//输入视图删除 [微笑] 这类字符串  直接一次性删除
-(void)deleteEmtionString:(UITextView *)textView;

@end




/**
 表单Layout
 */
@interface SSChatCollectionViewFlowLayout : UICollectionViewFlowLayout

@end















