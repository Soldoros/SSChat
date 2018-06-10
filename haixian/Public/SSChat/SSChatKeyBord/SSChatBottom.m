//
//  SSChatBottom.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatBottom.h"
#import "SSChatModelLayout.h"
#import "SSChatIMEmotionModel.h"
#import "SSChatController.h"

@interface SSChatBottom ()<UITextFieldDelegate>

@end

@implementation SSChatBottom


-(instancetype)init{
    if(self = [super init]){
        [self initMainView];
    }
    return self;
}

-(void)initMainView{
    
    self.backgroundColor =  SSChatCellColor;
    
    self.frame = makeRect(0, SCREEN_Height-SSChatBotomHeight-SafeAreaBottom_Height, SCREEN_Width, SSChatBotomHeight);

    _type = SSChatBottomTypeDefault;
    
    _topLine = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, 0.5)];
    _topLine.backgroundColor = CellLineColor;
    [self addSubview:_topLine];
    
    //左侧按钮
    _mLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mLeftBtn.bounds = makeRect(0, 0, SSChatBtnSize, SSChatBtnSize);
    _mLeftBtn.left    = SSChatBtnDistence;
    _mLeftBtn.bottom  = self.height - SSChatBBottomDistence;
    _mLeftBtn.tag  = 10;
    [self addSubview:_mLeftBtn];
    [_mLeftBtn setBackgroundImage:makeImage(@"icon_yuying") forState:UIControlStateNormal];
    [_mLeftBtn setBackgroundImage:makeImage(@"icon_shuru") forState:UIControlStateSelected];
    _mLeftBtn.selected = NO;
    [_mLeftBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //添加按钮
    _mAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mAddBtn.bounds = makeRect(0, 0, SSChatBtnSize, SSChatBtnSize);
    _mAddBtn.right = SCREEN_Width - SSChatBtnDistence;
    _mAddBtn.bottom  = self.height - SSChatBBottomDistence;
    _mAddBtn.tag  = 12;
    _mAddBtn.selected = NO;
    [self addSubview:_mAddBtn];
    [_mAddBtn setBackgroundImage:makeImage(@"icon_tianjia") forState:UIControlStateNormal];
    [_mAddBtn setBackgroundImage:makeImage(@"icon_tianjia") forState:UIControlStateSelected];
    _mAddBtn.selected = NO;
    [_mAddBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //表情按钮
    _mSymbolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mSymbolBtn.bounds = makeRect(0, 0, SSChatBtnSize, SSChatBtnSize);
    _mSymbolBtn.right = _mAddBtn.left - SSChatBtnDistence;
    _mSymbolBtn.bottom  = self.height - SSChatBBottomDistence;
    _mSymbolBtn.backgroundColor = [UIColor whiteColor];
    _mSymbolBtn.tag  = 11;
    [self addSubview:_mSymbolBtn];
    [_mSymbolBtn setBackgroundImage:makeImage(@"icon_biaoqing") forState:UIControlStateNormal];
    [_mSymbolBtn setBackgroundImage:makeImage(@"icon_shuru") forState:UIControlStateSelected];
    _mSymbolBtn.selected = NO;
    [_mSymbolBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // 语音按钮   输入框
    _mTextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _mTextBtn.bounds = makeRect(0, 0, SSChatTextWidth, SSChatTextHeight);
    _mTextBtn.left = _mLeftBtn.right+SSChatBtnDistence;
    _mTextBtn.bottom = self.height - SSChatTBottomDistence;
    _mTextBtn.backgroundColor = [UIColor whiteColor];
    _mTextBtn.layer.borderWidth = 0.5;
    _mTextBtn.layer.borderColor = CellLineColor.CGColor;
    _mTextBtn.clipsToBounds = YES;
    _mTextBtn.layer.cornerRadius = 3;
    [self addSubview:_mTextBtn];
    _mTextBtn.userInteractionEnabled = YES;
    _mTextBtn.titleLabel.font = makeBlodFont(14);
    [_mTextBtn setTitleColor:makeColorRgb(100, 100, 100) forState:UIControlStateNormal];
    [_mTextBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_mTextBtn setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [_mTextBtn addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
    
    [_mTextBtn addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mTextBtn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [_mTextBtn addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_mTextBtn addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    
 
    _mTextView = [[UITextView alloc]init];
    _mTextView.frame = _mTextBtn.bounds;
    _mTextView.left = 5;
    _mTextView.width = _mTextBtn.width - 10;
    _mTextView.delegate = self;
    [_mTextBtn addSubview:_mTextView];
    _mTextView.backgroundColor = [UIColor whiteColor];
    _mTextView.returnKeyType = UIReturnKeySend;
    _mTextView.font = makeFont(15);
}

-(void)setKeyBordHieght:(CGFloat)keyBordHieght{
    _keyBordHieght = keyBordHieght;
    
}


-(void)btnPressed:(UIButton *)sender{

    SSChatController *controller = (SSChatController *)[self getViewController];
    _mKeyBordView = controller.mKeyBordView;
    
        switch (self.type) {
            case SSChatBottomTypeDefault:{
                if(sender.tag==10){
                    self.type = SSChatBottomTypeVoice;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    self.mTextView.hidden = YES;
                    _mKeyBordView.mCoverView.hidden = NO;
                }
                else if (sender.tag==11){
                    self.type = SSChatBottomTypeSymbol;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    self.keyBordHieght = SafeAreaBottom_Height+SSChatKeyBordHeight;
                    _mKeyBordView.type = KeyBordViewFouctionSymbol;
                    [controller addSSChatKeyBordView];
                }else{
                    self.type = SSChatBottomTypeAdd;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    _mKeyBordView.type = KeyBordViewFouctionAdd;
                    [controller addSSChatKeyBordView];
                }
            }
                break;
            case SSChatBottomTypeVoice:{
                if(sender.tag==10){
                    _mKeyBordView.mCoverView.hidden = NO;
                    [self.mTextView becomeFirstResponder];
                }else if (sender.tag==11){
                    self.type = SSChatBottomTypeSymbol;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    self.mTextView.hidden = NO;
                    self.keyBordHieght = SafeAreaBottom_Height+_mKeyBordView.height;
                    _mKeyBordView.type = KeyBordViewFouctionSymbol;
                    [controller addSSChatKeyBordView];
                }else{
                    self.type = SSChatBottomTypeAdd;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    _mKeyBordView.type = KeyBordViewFouctionAdd;
                    self.mTextView.hidden = NO;
                    [controller addSSChatKeyBordView];
                }
                [self textViewDidChange:self.mTextView];
            }
                break;
            case SSChatBottomTypeEdit:{
                if(sender.tag==10){
                    self.type = SSChatBottomTypeVoice;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = NO;
                    self.mTextView.hidden = YES;
                    [self.mTextView endEditing:YES];
                    self.mTextView.height = SSChatTextHeight;
                    [self setNewSizeWithBootm];
                }else if (sender.tag==11){
                    self.type = SSChatBottomTypeSymbol;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    self.keyBordHieght = SafeAreaBottom_Height+SSChatKeyBordHeight;
                    _mKeyBordView.type = KeyBordViewFouctionSymbol;
                    [self.mTextView endEditing:YES];
                }else{
                    self.type = SSChatBottomTypeAdd;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    _mKeyBordView.type = KeyBordViewFouctionAdd;
                    [self.mTextView endEditing:YES];
                }
            }
                break;
            case SSChatBottomTypeSymbol:{
                if(sender.tag==10){
                    self.type = SSChatBottomTypeVoice;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = NO;
                    self.mTextView.hidden = YES;
                    self.keyBordHieght = SafeAreaBottom_Height;
                    [controller deleteSSChatKeyBordView];
                    self.mTextView.height = SSChatTextHeight;
                    [self setNewSizeWithBootm];
                }else if (sender.tag==11){
                    [self.mTextView becomeFirstResponder];
                    _mKeyBordView.mCoverView.hidden = YES;
                }else{
                    self.type = SSChatBottomTypeAdd;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    _mKeyBordView.type = KeyBordViewFouctionAdd;
                }
            }
                
                break;
            case SSChatBottomTypeAdd:{
                if(sender.tag==10){
                    self.type = SSChatBottomTypeVoice;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = NO;
                    self.mTextView.hidden = YES;
                    self.keyBordHieght = SafeAreaBottom_Height;
                    [controller deleteSSChatKeyBordView];
                    self.mTextView.height = SSChatTextHeight;
                    [self setNewSizeWithBootm];
                }else if (sender.tag==11){
                    self.type = SSChatBottomTypeSymbol;
                    self.currentBtn.selected = NO;
                    self.currentBtn = sender;
                    self.currentBtn.selected = YES;
                    _mKeyBordView.mCoverView.hidden = YES;
                    self.mTextView.hidden = NO;
                    self.keyBordHieght = SafeAreaBottom_Height+_mKeyBordView.height;
                    _mKeyBordView.type = KeyBordViewFouctionSymbol;
                }else{
                    [self.mTextView becomeFirstResponder];
                    _mKeyBordView.mCoverView.hidden = YES;
                }
            }
                break;
                
            default:
                break;
        }
    
}

//添加表情来了
-(void)setEmojiText:(NSObject *)emojiText{
    _emojiText = emojiText;
    
    //删除表情字符串
    if ([emojiText isEqual: DeleteButtonId]) {
        [[SSChartEmotionImages ShareSSChartEmotionImages] deleteEmtionString:_mTextView];
    }
    //系统自带表情直接拼接
    else if (![_emojiText isKindOfClass:[UIImage class]]) {
        [self.mTextView replaceRange:self.mTextView.selectedTextRange withText:(NSString *)_emojiText];
    }
    //其他的表情用可变字符来处理
    else {
        NSString * emtionString = [[SSChartEmotionImages ShareSSChartEmotionImages] emotionStringWithImg:(UIImage *)_emojiText];
        self.mTextView.text = makeString(_mTextView.text, emtionString);
    }
    
    [self textViewDidChange:_mTextView];
}


//设置输入框高度
-(void)setTextViewHeight:(CGFloat)height{
    [UIView animateWithDuration:0.1 animations:^{
        _mTextView.height = height;
    } completion:^(BOOL finished) {
        
    }];
}


//设置所有控件新的尺寸位置
-(void)setNewSizeWithBootm{
    [UIView animateWithDuration:0.25 animations:^{
        self.height = 8 + 8 + _mTextView.height;
        self.bottom   = SCREEN_Height-_keyBordHieght;
        
        _mTextBtn.height = _mTextView.height;
        _mTextBtn.bottom = self.height-SSChatTBottomDistence;
        _mTextView.top = 0;
        _mLeftBtn.bottom = self.height-SSChatBBottomDistence;
        _mAddBtn.bottom = self.height-SSChatBBottomDistence;
        _mSymbolBtn.bottom = self.height-SSChatBBottomDistence;
    } completion:^(BOOL finished) {
        
    }];
}

//拦截发送按钮
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(text.length==0){
        [[SSChartEmotionImages ShareSSChartEmotionImages] deleteEmtionString:_mTextView];
        [self textViewDidChange:_mTextView];
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self startSendMessage];
        return NO;
    }
    
    return YES;
}

//开始发送消息
-(void)startSendMessage{
    NSString *message = [_mTextView.attributedText string];
    if(message.length==0){
        [[AppDelegate sharedAppDelegate].window.rootViewController showTime:@"发送消息不能为空"];
    }
    else if(_delegate && [_delegate respondsToSelector:@selector(SSChatBottomBtnClick:)]){
        [_delegate SSChatBottomBtnClick:message];
    }
    
    _mTextView.text = nil;
    _textString = _mTextView.text;
    _mTextView.contentSize = CGSizeMake(_mTextView.contentSize.width, 30);
    [_mTextView setContentOffset:CGPointZero animated:YES];
    [_mTextView scrollRangeToVisible:_mTextView.selectedRange];
    
    [self setTextViewHeight:SSChatTextHeight];
    [self setNewSizeWithBootm];
    [self sendNotifCation:NotiTextChange];
    
}



//监听输入框的操作 输入框高度动态变化 输入框不能小于最小高度 不能大于最大高度
- (void)textViewDidChange:(UITextView *)textView{

    _textString = textView.text;
    [self sendNotifCation:NotiTextChange];
    
    CGFloat textViewContentH = textView.contentSize.height;

    if (textViewContentH < SSChatTextHeight) {
        _mTextView.height = SSChatTextHeight;
    }
    else if (textViewContentH > SSChatTextMaxHeight) {
        _mTextView.height = SSChatTextMaxHeight;
    }
    else {
        [self setTextViewHeight:textViewContentH];
    }
    
    [self setNewSizeWithBootm];
}



#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryRecord error:&err];
    if (err) {
        NSLog(@"audioSession: %@ %zd %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&err];
    if (err) {
        NSLog(@"audioSession: %@ %zd %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    
    NSDictionary *recordSetting = @{
                                    AVEncoderAudioQualityKey : [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderBitRateKey : [NSNumber numberWithInt:16],
                                    AVFormatIDKey : [NSNumber numberWithInt:kAudioFormatLinearPCM],
                                    AVNumberOfChannelsKey : @2,
                                    AVLinearPCMBitDepthKey : @8
                                    };
    NSError *error = nil;
    //    NSString *docments = [NSHomeDirectory() stringByAppendingString:@"Documents"];
    NSString *docments = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    _docmentFilePath = [NSString stringWithFormat:@"%@/%@",docments,@"123"];
    
    NSURL *pathURL = [NSURL fileURLWithPath:_docmentFilePath];
    _recorder = [[AVAudioRecorder alloc] initWithURL:pathURL settings:recordSetting error:&error];
    if (error || !_recorder) {
        NSLog(@"recorder: %@ %zd %@", [error domain], [error code], [[error userInfo] description]);
        return;
    }
    _recorder.delegate = self;
    [_recorder prepareToRecord];
    _recorder.meteringEnabled = YES;
    
    if (!audioSession.inputIsAvailable) {
        
        return;
    }
    
    
    [_recorder record];
    _playTime = 0;
    _playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    [_recorder stop];
    [_playTimer invalidate];
    _playTimer = nil;
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (_playTimer) {
        [_recorder stop];
        [_recorder deleteRecording];
        [_playTimer invalidate];
        _playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"Cancel"];
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Release to cancel"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Slide up to cancel"];
}


- (void)countVoiceTime
{
    _playTime ++;
    if (_playTime>=59) {
        [self endRecordVoice:nil];
    }
}


#pragma mark - Mp3RecorderDelegate

//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate SSChatBottomBtnClick:self sendVoice:voiceData time:_playTime+1];
    [UUProgressHUD dismissWithSuccess:@"Success"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"Too short"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}



#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSURL *url = [NSURL fileURLWithPath:_docmentFilePath];
    NSError *err = nil;
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options:0 error:&err];
    if (audioData) {
        [self endConvertWithData:audioData];
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    
}





@end
