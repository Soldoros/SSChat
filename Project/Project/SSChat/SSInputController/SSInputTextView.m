//
//  SSInputTextView.m
//  Project
//
//  Created by soldoros on 2021/9/20.
//

#import "SSInputTextView.h"

@implementation SSInputTextView

- (UIResponder *)nextResponder{
    if(_mNextResponder == nil){
        return [super nextResponder];
    }
    else{
        return _mNextResponder;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_mNextResponder != nil)
        return NO;
    else
        return [super canPerformAction:action withSender:sender];
}

@end
