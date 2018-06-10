//
//  SSChatBottom.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UUProgressHUD.h"
@class SSChatBottom;

#import "SSChatKeyBordView.h"

/**
 底部按钮点击的五种状态

 - SSChatBottomTypeDefault: 默认在底部的状态
 - SSChatBottomTypeVoice: 准备发语音的状态
 - SSChatBottomTypeEdit: 准备编辑文本的状态
 - SSChatBottomTypeSymbol: 准备发送表情的状态
 - SSChatBottomTypeAdd: 准备发送其他功能的状态
 */
typedef NS_ENUM(NSInteger,SSChatBottomType) {
    SSChatBottomTypeDefault=1,
    SSChatBottomTypeVoice,
    SSChatBottomTypeEdit,
    SSChatBottomTypeSymbol,
    SSChatBottomTypeAdd,
};

@protocol SSChatBottomDelegate <NSObject>

-(void)SSChatBottomBtnClick:(NSString *)string;

- (void)SSChatBottomBtnClick:(SSChatBottom *)view sendVoice:(NSData *)voice time:(NSInteger)second;

@end

@interface SSChatBottom : UIView<UITextViewDelegate,AVAudioRecorderDelegate>

@property(nonatomic,assign) id<SSChatBottomDelegate>delegate;

//给出五种状态 当前处于默认状态
@property(nonatomic,assign)SSChatBottomType type;

//键盘或者 表情视图 功能视图的高度
@property(nonatomic,assign)CGFloat keyBordHieght;

//传入底部视图进行frame布局
@property (strong, nonatomic) SSChatKeyBordView   *mKeyBordView;

//顶部线条
@property(nonatomic,strong) UIView *topLine;

//当前点击的按钮  左侧按钮   表情按钮  添加按钮
@property(nonatomic,strong) UIButton *currentBtn;
@property(nonatomic,strong) UIButton *mLeftBtn;
@property(nonatomic,strong) UIButton *mSymbolBtn;
@property(nonatomic,strong) UIButton *mAddBtn;

//输入框背景 输入框 缓存输入的文字
@property(nonatomic,strong) UIButton       *mTextBtn;
@property(nonatomic,strong) UITextView     *mTextView;
@property(nonatomic,strong) NSString *textString;

//添加表情
@property(nonatomic,strong) NSObject       *emojiText;

//录音相关
@property(nonatomic,assign) BOOL isbeginVoiceRecord;
@property(nonatomic,assign) NSInteger playTime;
@property(nonatomic,strong) NSString *docmentFilePath;

@property (nonatomic, strong) NSTimer *playTimer;
@property (nonatomic, strong) UILabel *placeHold;
@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) UIButton *btnSendMessage;
@property (nonatomic, strong) UIButton *btnChangeVoiceState;
@property (nonatomic, strong) UIButton *btnVoiceRecord;



//设置所有控件新的尺寸位置
-(void)setNewSizeWithBootm;
//监听输入框的操作 输入框高度动态变化 输入框不能小于最小高度 不能大于最大高度
- (void)textViewDidChange:(UITextView *)textView;

//开始发送消息
-(void)startSendMessage;


@end
