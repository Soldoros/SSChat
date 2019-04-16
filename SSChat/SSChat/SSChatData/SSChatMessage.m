//
//  SSChatMessage.m
//  SSChatView
//
//  Created by soldoros on 2018/10/12.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatMessage.h"

@implementation SSChatMessage


//文本消息
-(void)setTextString:(NSString *)textString{
    _textString = textString;
    self.attTextString = [[SSChartEmotionImages ShareSSChartEmotionImages]emotionImgsWithString:textString];
   
    //设置以字符为单位的换行和行高 间距 字号 颜色
    NSMutableParagraphStyle *paragraphString = [[NSMutableParagraphStyle alloc] init];
    paragraphString.lineBreakMode = NSLineBreakByCharWrapping;
    [paragraphString setLineSpacing:SSChatTextLineSpacing];

    [_attTextString addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, _attTextString.length)];
    [_attTextString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SSChatTextFont] range:NSMakeRange(0, _attTextString.length)];
    [_attTextString addAttribute:NSForegroundColorAttributeName value:SSChatTextColor range:NSMakeRange(0, _attTextString.length)];
 
}




@end
