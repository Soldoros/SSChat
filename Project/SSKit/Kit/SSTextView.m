//
//  SSTextField.m
//  QuFound
//
//  Created by soldoros on 2021/1/6.
//  Copyright © 2021 macbook. All rights reserved.
//

#import "SSTextView.h"

@implementation SSTextView

-(instancetype)init{
    if(self = [super init]){
        [self setData];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setData];
    }
    return self;
}

-(void)setData{
    self.delegate = self;
    _number = 200;
    self.placeString = @"";
    _currentStr = @"";
    _placeColor = makeColorHex(@"#999999");
    self.textColor = makeColorHex(@"#333333");
}

-(void)drawRect:(CGRect)rect{
    
    if( [_placeString length] > 0 )
    {
        UIEdgeInsets insets = self.textContainerInset;
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(insets.left+10,0,self.bounds.size.width - (insets.left +insets.right+20),1.0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.textColor = _placeColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
            _placeHolderLabel.userInteractionEnabled = YES;
        }

        setLabHeight(_placeHolderLabel, _placeString, 4);
        [_placeHolderLabel sizeToFit];
        [_placeHolderLabel setFrame:CGRectMake(insets.left + 5,8,self.bounds.size.width - (insets.left +insets.right),CGRectGetHeight(_placeHolderLabel.frame))];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( self.text.length == 0 && [_placeString length] > 0 ){
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}


-(void)textViewDidChange:(UITextView *)textView{
    
    if(textView.text.length>0){
        [[self viewWithTag:999] setAlpha:0.01];
    }else{
        [[self viewWithTag:999] setAlpha:1];
    }
    self.textViewBlock(textView, textView.text, _currentStr);
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(textView.text.length + text.length > _number){
        return NO;
    }
    _currentStr = text;
    return YES;
}


@end
