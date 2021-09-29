//
//  SSFaceConfig.m
//  Project
//
//  Created by soldoros on 2021/9/27.
//

//表情资源
#import "SSFaceConfig.h"


@implementation SSFaceConfig

+(SSFaceConfig *)shareFaceConfig{
    static dispatch_once_t onceToken;
    static SSFaceConfig *config;
    dispatch_once(&onceToken, ^{
        config = [[SSFaceConfig alloc] init];
        [config initSystemEmotionImages];
    });
    return config;
}

//获取本地的表情和系统表情
-(void)initSystemEmotionImages{
    
    _systemImages = [NSMutableArray new];
    
    __weak typeof(self)wself = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i=0x1F600; i<=0x1F64F; i++) {
            if (i < 0x1F641 || i > 0x1F640) {
                int sym = EMOJI_CODE_TO_SYMBOL(i);
                NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
                [array addObject:emoT];
            }
        }
        wself.systemImages = [self dealWithArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
        });
    });
}


//添加删除符号
-(NSMutableArray *)dealWithArray:(NSMutableArray *)arr{
    
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:arr];
    
    NSInteger k = 1;
    NSInteger number = SSChatEmojiRow * SSChatEmojiLine;
    
    for (NSInteger i = 0;i < array.count;i++) {
        if(i==number*k-1){
//            [array insertObject:DeleteButtonId atIndex:i];
            k++;
        }
    }
//    [array addObject:DeleteButtonId];
    return array;
}


@end
