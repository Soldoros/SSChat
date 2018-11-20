//
//  SSChatIMEmotionModel.m
//  htcm
//
//  Created by soldoros on 2018/6/1.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatIMEmotionModel.h"


@implementation SSChatIMEmotionModel

+ (SSChatIMEmotionModel *)modelWithDictionary:(NSDictionary*)dic atIndex:(int)index{
    
    SSChatIMEmotionModel* model = [SSChatIMEmotionModel new];
    
    model.name = dic[@"name"];
    
    model.code = [NSString stringWithFormat:@"[%d]", index];

    model.imageName = [NSString stringWithFormat:@"Expression_%d.png", index+1];
    
    return model;
}


@end





static SSChartEmotionImages *emotion = nil;

@implementation SSChartEmotionImages

+ (SSChartEmotionImages *)ShareSSChartEmotionImages{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        emotion = [SSChartEmotionImages new];
    });
    return emotion;
}

- (void)initEmotionImages{
    if(_emotions != nil && _emotions.count!=0)return;
    
    _emotions = [NSMutableArray array];
    _images = [NSMutableArray array];
    _codes = [NSMutableArray new];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion_icons.plist" ofType:nil];
    NSArray* array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray* entities = [NSMutableArray arrayWithCapacity:array.count];
    SSChatIMEmotionModel* model = nil;
    NSDictionary* dic = nil;
    for (int i = 0; i < array.count; i++) {
        dic = array[i];
        model = [SSChatIMEmotionModel modelWithDictionary:dic atIndex:i];
        [entities addObject:model];
        [_emotions addObject:model.name];
        [_images addObject:[UIImage imageNamed:model.imageName]];
        [_codes addObject:model.code];
    }
}


-(void)initSystemEmotionImages{
    if(_systemImages != nil && _systemImages.count!=0)return;
    
    _systemImages = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F640) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [_systemImages addObject:emoT];
        }
    }
}


-(NSMutableArray *)dealWithArray:(NSMutableArray *)arr1 arr2:(NSMutableArray *)arr2{
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObjectsFromArray:arr1];
    [arr addObjectsFromArray:arr2];

    
    NSInteger k = 1;
    NSInteger number = SSChatEmojiRow * SSChatEmojiLine;
    for (NSInteger i = 0;i < arr.count;i++) {
        if(i==number*k-1){
            [arr insertObject:DeleteButtonId atIndex:i];
            k++;
        }
    }
    [arr addObject:DeleteButtonId];
    
    return arr;
}


//将表情图转换成字符串
-(NSString *)emotionStringWithImg:(UIImage *)image{
    NSString *string = @"";
    for(int i=0;i<_images.count;++i){
        UIImage *img = _images[i];
        if([img isEqual:image]){
            string = _emotions[i];
            break;
        }
    }
    return string;
}

//将字符串转换成对应的表情图
-(UIImage *)emotionImgWithString:(NSString *)string{
    UIImage *img = nil;
    for(int i=0;i<_emotions.count;++i){
        NSString *str = _emotions[i];
        if([str isEqualToString:string]){
            img = _images[i];
            break;
        }
    }
    return img;
}


//将字符串中所有的表情字符串转换成图片 并返回可变字符串
-(NSMutableAttributedString *)emotionImgsWithString:(NSString *)string{
 
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:string];
    

    //正则匹配要替换的文字的范围
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    //遍历字符串,获得所有的匹配字符串
    NSArray *resultArray = [re matchesInString:string options:0 range:NSMakeRange(0, string.length)];

    for(int i=(int)resultArray.count-1;i>=0;--i){
        
        NSTextCheckingResult *checkingResult = resultArray[i];
        
        for(int j=0;j<_emotions.count;++j){
    
            NSString *faceName = self.emotions[j];
            
            //截取闭区间的字符串
            if ([[string substringWithRange:checkingResult.range] isEqualToString:faceName]){
                
                NSTextAttachment * textAttachment = [[NSTextAttachment alloc]init];
                textAttachment.image = _images[j];
                textAttachment.bounds = CGRectMake(0, 0, 23, 23);
                NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithAttributedString:imageStr];
//                mstr.backgroundColor = [UIColor clearColor];
                [mstr addAttribute:NSBaselineOffsetAttributeName value:@(-3.6) range:NSMakeRange(0, mstr.length)];
                
                NSMutableParagraphStyle *paragraphString = [[NSMutableParagraphStyle alloc] init];
                [paragraphString setLineSpacing:5];
                [mstr addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, mstr.length)];
                
   
                [attStr replaceCharactersInRange:checkingResult.range withAttributedString:mstr];
                [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, attStr.length)];
                
            }
            
            
            else{

            }
        }
    }

    return attStr;
}

//输入视图删除 [微笑] 这类字符串  直接一次性删除
-(void)deleteEmtionString:(UITextView *)textView{
    
    NSString *souceText = textView.text;
    NSRange range = textView.selectedRange;
    if (range.location == NSNotFound) {
        range.location = textView.text.length;
    }
    if (range.length > 0) {
        [textView deleteBackward];
        return;
    }else{
        
        //正则匹配要替换的文字的范围
        NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
        NSError *error = nil;
        NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        if (!re) {
            NSLog(@"%@", [error localizedDescription]);
        }
        //通过正则表达式来匹配字符串
        NSArray *resultArray = [re matchesInString:souceText options:0 range:NSMakeRange(0, souceText.length)];
        
        NSTextCheckingResult *checkingResult = resultArray.lastObject;
        
        for (NSString *faceName in self.emotions) {
            
            if ([souceText hasSuffix:@"]"]) {
                
                if ([[souceText substringWithRange:checkingResult.range] isEqualToString:faceName]) {
                    
                    NSLog(@"faceName %@", faceName);
                    
                    NSString *newText = [souceText substringToIndex:souceText.length - checkingResult.range.length];
                    textView.text = newText;
                    return;
                    
                }
                
            }else{
                [textView deleteBackward];
                return;
            }
        }
    }
}


@end



//表单Layout
@implementation SSChatCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat W = (self.collectionView.bounds.size.width) / SSChatEmojiLine;
    CGFloat H = (self.collectionView.bounds.size.height) / SSChatEmojiRow;
    
    self.itemSize = CGSizeMake(W, H);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    CGFloat Y = (self.collectionView.bounds.size.height - SSChatEmojiRow * H);
    self.collectionView.contentInset = UIEdgeInsetsMake(Y, 0, 0, 0);
}

@end


