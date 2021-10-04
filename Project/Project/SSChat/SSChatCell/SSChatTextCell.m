//
//  SSChatTextCell.m
//  Project
//
//  Created by soldoros on 2021/9/29.
//

#import "SSChatTextCell.h"

@implementation SSChatTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        _mHeaderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mHeaderBtn.frame = makeRect(0, 0, SSChatIconWH, SSChatIconWH);
        _mHeaderBtn.tag = 10;
        [self.contentView addSubview:_mHeaderBtn];
        [_mHeaderBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //背景按钮
        _mBackImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_mBackImgBtn];
        _mBackImgBtn.frame = CGRectZero;
        _mBackImgBtn.tag = 50;
        
        
        _mTextView = [UITextView new];
        _mTextView.frame = CGRectZero;
        _mTextView.font = [UIFont systemFontOfSize:SSChatTextFont];
        _mTextView.backgroundColor = [UIColor clearColor];
        _mTextView.editable = NO;
        _mTextView.scrollEnabled = NO;
        _mTextView.textContainer.lineFragmentPadding = 0;
        _mTextView.layoutManager.allowsNonContiguousLayout = NO;
        _mTextView.dataDetectorTypes = UIDataDetectorTypeAll;
        _mTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_mBackImgBtn addSubview:_mTextView];
        
    }
    return self;
}

-(void)buttonPressed:(UIButton *)sender{
    
}

-(void)setMessage:(SSChatMessage *)message{
    [super setMessage:message];
    
    _mHeaderBtn.frame = message.headerRect;
    [_mHeaderBtn setImage:[UIImage imageNamed:@"touxaing2"] forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageNamed:message.backGroundImg];
    image = [image resizableImageWithCapInsets:message.imgInsets resizingMode:UIImageResizingModeStretch];
    _mBackImgBtn.frame = message.backGroundRect;
    [_mBackImgBtn setBackgroundImage:image forState:UIControlStateNormal];

    _mTextView.frame = message.textRect;
    _mTextView.text = message.textString;
    _mTextView.textColor = message.textColor;
    
}

@end
