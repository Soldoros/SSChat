//
//  SSChatBaseCell.m
//  Project
//
//  Created by soldoros on 2021/9/29.
//

#import "SSChatBaseCell.h"

@implementation SSChatBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for (UIView *view in self.subviews) {
            if([view isKindOfClass:[UIScrollView class]]) {
                ((UIScrollView *)view).delaysContentTouches = NO;
                break;
            }
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BackGroundColor;
        self.contentView.backgroundColor = BackGroundColor;
    }
    return self;
}

-(void)setMessage:(SSChatMessage *)message{
    _message = message;
    
    
}

@end
