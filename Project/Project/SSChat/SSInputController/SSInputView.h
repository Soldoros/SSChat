//
//  SSInputView.h
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import <UIKit/UIKit.h>
#import "SSInputTextView.h"
#import "SSMediaRecordView.h"
@class SSInputView;

@protocol SSInputViewDelegate <NSObject>


//点击语音按钮回调
- (void)inputViewDidTouchVoice:(SSInputView *)textView;

//点击键盘按钮回调
- (void)inputViewDidTouchKeyboard:(SSInputView *)textView;

//点击笑脸后的回调
- (void)inputViewDidTouchFace:(SSInputView *)textView;

//点击+后回调
- (void)inputViewDidTouchMore:(SSInputView *)textView;

//发送文本消息点击回调
- (void)inputView:(SSInputView *)textView didSendText:(NSString *)text;

//发送语音消息点击回调
- (void)inputView:(SSInputView *)textView didSendVoice:(NSString *)path;

//输入@字符回调
- (void)inputViewDidInputAt:(SSInputView *)textView;

//删除@字符回调 比如删除 @xxx）
- (void)inputViewDidSendAt:(SSInputView *)textView didDeleteAt:(NSString *)text;

//输入条高度变化回调
- (void)inputView:(SSInputView *)textView didChangeHeight:(CGFloat)offset;

@end


@interface SSInputView : UIView


//清空整个文本输入框中的内容。
- (void)clearInput;

//添加表情输入
- (void)addEmoji:(NSString *)emoji;

//删除普通字符串
- (void)deletText;


//回调协议对象
@property (nonatomic, weak) id<SSInputViewDelegate> delegate;

//顶部线条
@property (nonatomic, strong) UIView *mLine;
//语音按钮
@property (nonatomic, strong) UIButton *mVoiceBtn;
//表情按钮
@property (nonatomic, strong) UIButton *mFaceBtn;
//加号按钮
@property (nonatomic, strong) UIButton *mMoreBtn;
//文本输入框
@property (nonatomic, strong) SSInputTextView *mTextView;
//录音按钮
@property (nonatomic, strong) UIButton *mRecordBtn;

//录音显示状态
@property(nonatomic,strong)SSMediaRecordView *mRecordView;

@end


