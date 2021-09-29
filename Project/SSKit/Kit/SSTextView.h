//
//  SSTextField.h
//  QuFound
//
//  Created by soldoros on 2021/1/6.
//  Copyright © 2021 macbook. All rights reserved.
//
/*
 
 _mTextView = [SSTextView new];
 _mTextView.frame = makeRect(20, 10, ScreenWidth - 40, 130);
 _mTextView.layer.borderColor = BackGroundColor.CGColor;
 _mTextView.layer.borderWidth = 1;
 _mTextView.centerX = SCREEN_Width * 0.5;
 _mTextView.top = _mBackView1.bottom + 15;
 _mTextView.font = makeFont(14);
 _mTextView.textColor = makeColorHex(@"#333333");
 [self.contentView addSubview:_mTextView];
 _mTextView.placeString = @"在这里详细描述一下您的商铺";
 
 __weak typeof(self) weakSelf = self;
 _mTextView.textViewBlock = ^(UITextView * _Nonnull mTextView, NSString * _Nonnull string, NSString *currentStr) {
     if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(PubilcViewEdit:textF:string:)]){
         
         [weakSelf.delegate PubilcViewEdit:weakSelf.indexPath textF:mTextView string:string];
         
     }
 };
 
 
 
 
 */

#import <UIKit/UIKit.h>


//添加block回调
typedef void (^SSTextViewBlock)(UITextView * _Nonnull mTextView, NSString * _Nonnull string, NSString *currentStr);

NS_ASSUME_NONNULL_BEGIN

@interface SSTextView : UITextView<UITextViewDelegate>

@property(nonatomic,strong)NSString *placeString;

@property(nonatomic,strong)UIColor *placeColor;

@property(nonatomic,strong)UILabel *placeHolderLabel;

@property(nonatomic,copy)SSTextViewBlock textViewBlock;

@property(nonatomic,strong)NSString *currentStr;

//最大输入数量
@property(nonatomic,assign)NSInteger number;

@end

NS_ASSUME_NONNULL_END
