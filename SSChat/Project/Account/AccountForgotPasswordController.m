//
//  AccountForgotPasswordController.m
//  SSChat
//
//  Created by soldoros on 2019/4/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

//忘记密码
#import "AccountForgotPasswordController.h"

@interface AccountForgotPasswordController ()

@end

@implementation AccountForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLine.hidden = YES;
    
    UILabel * mTitleLab = [UILabel new];
    mTitleLab.bounds = makeRect(0, 0, 100, 30);
    mTitleLab.textColor = [UIColor blackColor];
    [self.view addSubview:mTitleLab];
    mTitleLab.font = makeFont(24);
    mTitleLab.text = @"索.德罗斯：";
    [mTitleLab sizeToFit];
    mTitleLab.left = 30;
    mTitleLab.top = SafeAreaTop_Height + 30;
    
    
    NSString *string1 = @"钉钉：13540033103";
    NSString *string2 = @"邮箱：765970680@qq.com";
    NSString *string3 = @"GitHub：https://github.com/Soldoros/SSChat";
    
    
    UITextView *mTextView = [UITextView new];
    mTextView.backgroundColor = [UIColor clearColor];
    mTextView.editable = NO;
    mTextView.scrollEnabled = NO;
    mTextView.textContainer.lineFragmentPadding = 0;
    mTextView.layoutManager.allowsNonContiguousLayout = NO;
    mTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    mTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTextView.linkTextAttributes = @{NSForegroundColorAttributeName:TitleColor};
    [self.view addSubview:mTextView];
    mTextView.font = makeFont(18);
    mTextView.width = SCREEN_Width - 70;
    mTextView.attributedText = [self getAttStringWithString:string1];
    [mTextView sizeToFit];
    mTextView.left = 35;
    mTextView.top = mTitleLab.bottom + 100;
    
    UITextView *mTextView2 = [UITextView new];
    mTextView2.backgroundColor = [UIColor clearColor];
    mTextView2.editable = NO;
    mTextView2.scrollEnabled = NO;
    mTextView2.textContainer.lineFragmentPadding = 0;
    mTextView2.layoutManager.allowsNonContiguousLayout = NO;
    mTextView2.dataDetectorTypes = UIDataDetectorTypeAll;
    mTextView2.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTextView2.linkTextAttributes = @{NSForegroundColorAttributeName:TitleColor};
    [self.view addSubview:mTextView2];
    mTextView2.font = makeFont(18);
    mTextView2.width = SCREEN_Width - 70;
    mTextView2.attributedText = [self getAttStringWithString:string2];
    [mTextView2 sizeToFit];
    mTextView2.left = 35;
    mTextView2.top = mTextView.bottom + 30;
    
    UITextView *mTextView3 = [UITextView new];
    mTextView3.backgroundColor = [UIColor clearColor];
    mTextView3.editable = NO;
    mTextView3.scrollEnabled = NO;
    mTextView3.textContainer.lineFragmentPadding = 0;
    mTextView3.layoutManager.allowsNonContiguousLayout = NO;
    mTextView3.dataDetectorTypes = UIDataDetectorTypeAll;
    mTextView3.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    mTextView3.linkTextAttributes = @{NSForegroundColorAttributeName:TitleColor};
    [self.view addSubview:mTextView3];
    mTextView3.font = makeFont(18);
    mTextView3.width = SCREEN_Width - 70;
    mTextView3.attributedText = [self getAttStringWithString:string3];
    [mTextView3 sizeToFit];
    mTextView3.left = 35;
    mTextView3.top = mTextView2.bottom + 30;
}


-(NSMutableAttributedString *)getAttStringWithString:(NSString *)string{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSMutableParagraphStyle *paragraphString = [[NSMutableParagraphStyle alloc] init];
    paragraphString.lineBreakMode = NSLineBreakByCharWrapping;
    [paragraphString setLineSpacing:6];
    
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, attString.length)];
    
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, attString.length)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attString.length)];

    return attString;
}

@end
