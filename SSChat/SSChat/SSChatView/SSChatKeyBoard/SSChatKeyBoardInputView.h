//
//  SSChatKeyBoardInputView.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSDeviceDefault.h"
#import <AVFoundation/AVFoundation.h>
#import "UUProgressHUD.h"
#import "UUAVAudioPlayer.h"
#import "SSChatKeyBoardDatas.h"
#import "SSChatKeyBordView.h"



/**
 聊天界面底部的输入框视图
 */

#define SSChatKeyBoardInputViewH      55     //输入部分的高度
#define SSChatKeyBordBottomHeight     220    //底部视图的高度

//键盘总高度
#define SSChatKeyBordHeight   SSChatKeyBoardInputViewH + SSChatKeyBordBottomHeight


#define SSChatLineHeight        0.5          //线条高度
#define SSChatBotomTop          SCREEN_Height-SSChatBotomHeight-SafeAreaBottom_Height

//底部视图的顶部
#define SSChatBtnSize           30           //按钮的大小
#define SSChatLeftDistence      5            //左边间隙
#define SSChatRightDistence     5            //左边间隙
#define SSChatBtnDistence       10           //控件之间的间隙
#define SSChatTextHeight        40           //输入框的高度
#define SSChatTextMaxHeight     100           //输入框的最大高度
#define SSChatTextWidth      SCREEN_Width - (3*SSChatBtnSize + 5* SSChatBtnDistence)                       //输入框的宽度


#define SSChatTBottomDistence   7.5            //输入框上下间隙
#define SSChatBBottomDistence   12.5          //按钮上下间隙


@class SSChatKeyBoardInputView;


@protocol SSChatKeyBoardInputViewDelegate <NSObject>

//改变输入框的高度 并让控制器弹出键盘
-(void)SSChatKeyBoardInputViewHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime;

//发送文本信息
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string;

//发送语音消息
- (void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view sendVoice:(NSData *)voice time:(NSInteger)second;

//多功能视图按钮点击回调
-(void)SSChatKeyBoardInputViewBtnClickFunction:(NSInteger)index;

@end


@interface SSChatKeyBoardInputView : UIView<UITextViewDelegate,AVAudioRecorderDelegate,SSChatKeyBordViewDelegate> 

@property(nonatomic,assign)id<SSChatKeyBoardInputViewDelegate>delegate;

//当前的编辑状态（默认 语音 编辑文本 发送表情 其他功能）
@property(nonatomic,assign)SSChatKeyBoardStatus keyBoardStatus;

//键盘或者 表情视图 功能视图的高度
@property(nonatomic,assign)CGFloat changeTime;
@property(nonatomic,assign)CGFloat keyBoardHieght; 

//传入底部视图进行frame布局
@property (strong, nonatomic) SSChatKeyBordView   *mKeyBordView; 

//顶部线条
@property(nonatomic,strong) UIView   *topLine;

//当前点击的按钮  左侧按钮   表情按钮  添加按钮
@property(nonatomic,strong) UIButton *currentBtn;
@property(nonatomic,strong) UIButton *mLeftBtn;
@property(nonatomic,strong) UIButton *mSymbolBtn;
@property(nonatomic,strong) UIButton *mAddBtn;

//输入框背景 输入框 缓存输入的文字
@property(nonatomic,strong) UIButton     *mTextBtn;
@property(nonatomic,strong) UITextView   *mTextView;
@property(nonatomic,strong) NSString     *textString;
//输入框的高度
@property(nonatomic,assign) CGFloat   textH;

//添加表情
@property(nonatomic,strong) NSObject       *emojiText;

//录音相关
@property(nonatomic,assign) BOOL      isbeginVoiceRecord;
@property(nonatomic,assign) NSInteger playTime;
@property(nonatomic,strong) NSString  *docmentFilePath;

@property (nonatomic, strong) NSTimer         *playTimer;
@property (nonatomic, strong) UILabel         *placeHold;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioSession  *audioSession;

@property (nonatomic, strong) UIButton  *btnSendMessage;
@property (nonatomic, strong) UIButton  *btnChangeVoiceState;
@property (nonatomic, strong) UIButton  *btnVoiceRecord;


//键盘归位
-(void)SetSSChatKeyBoardInputViewEndEditing;


@end







