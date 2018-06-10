//
//  SSChatTextCell.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatTextCell.h"

@implementation SSChatTextCell

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mTextBtn.userInteractionEnabled = YES;
    self.mTextBtn.titleLabel.numberOfLines = 0;
    
    self.mTextBtn.titleLabel.font = makeFont(SSChatTextFont);
    [self.contentView addSubview:self.mTextBtn];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
    longPress.minimumPressDuration = 0.8;
    longPress.numberOfTouchesRequired = 1;
    [_mTextBtn addGestureRecognizer:longPress];
    
}


-(void)setLayout:(SSChatModelLayout *)layout{
    [super setLayout:layout];
    self.mTextBtn.frame = layout.btnRect;
    [self.mTextBtn setBackgroundImage:layout.btnImage forState:UIControlStateNormal];
    [self.mTextBtn setBackgroundImage:layout.btnImage forState:UIControlStateHighlighted];
    
    [self.mTextBtn setAttributedTitle:layout.model.attTextString forState:UIControlStateNormal];
    [self.mTextBtn.titleLabel sizeToFit];
    [self.mTextBtn setTitleColor:layout.model.textColor forState:UIControlStateNormal];
    self.mTextBtn.contentEdgeInsets = layout.btnInsets;

    
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

- (void) longTapAction:(UILongPressGestureRecognizer *)longPress {
  
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuControllerCopyClick)];
        UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"撤销" action:@selector(menuControllerUndoClick)];
        UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuControllerDeleteClick)];
        self.menu.menuItems = @[item1, item2,item3];
        self.menu.arrowDirection = UIMenuControllerArrowDefault;
        [self.menu setTargetRect:self.mTextBtn.frame inView:self.mTextBtn.superview];
        [self.menu setMenuVisible:YES animated:YES];
    }

}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(menuControllerCopyClick)||
        action == @selector(menuControllerUndoClick)||
        action == @selector(menuControllerDeleteClick)) {
        return YES;
    }
    return NO;
}

//复制
-(void)menuControllerCopyClick{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.layout.model.textString;
    return;
}

//撤销 10
-(void)menuControllerUndoClick{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatBaseCellBtnClick:index:messageType:)]){
        [self.delegate SSChatBaseCellBtnClick:self.indexPath index:11 messageType:SSChatMessageTypeText];
    }
}

//删除 11
-(void)menuControllerDeleteClick{
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatBaseCellBtnClick:index:messageType:)]){
        [self.delegate SSChatBaseCellBtnClick:self.indexPath index:12 messageType:SSChatMessageTypeText];
    }
}




@end
