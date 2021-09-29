//
//  SSInputView.m
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "SSInputView.h"
#import "SSMediaManager.h"


@interface SSInputView() <UITextViewDelegate,SSMediaManagerDelegate>


@property (nonatomic, strong) SSMediaManager *mediaManager;

@end

@implementation SSInputView



-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        
        _mLine = [UIView new];
        [self addSubview:_mLine];
        _mLine.frame = makeRect(0, 0, self.width, 0.5);
        _mLine.backgroundColor = CellLineColor;
        
        //喇叭+键盘按钮
        _mVoiceBtn = [[UIButton alloc] init];
        _mVoiceBtn.bounds = makeRect(0, 0, SSInputBtnSize, SSInputBtnSize);
        _mVoiceBtn.top = SSInputSpaceTop;
        _mVoiceBtn.left = SSInputSpaceWid;
        [_mVoiceBtn setImage:[[UIImage imageNamed:@"voice"] imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_mVoiceBtn setImage:[[UIImage imageNamed:@"keyboard"]imageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
        [_mVoiceBtn setImage:[[UIImage imageNamed:@"voice"]imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [self addSubview:_mVoiceBtn];
        [_mVoiceBtn addTarget:self action:@selector(clickVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
        _mVoiceBtn.selected = NO;
        
        
        //表情+键盘按钮
        _mFaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mFaceBtn.bounds = makeRect(0, 0, SSInputBtnSize, SSInputBtnSize);
        _mFaceBtn.top = SSInputSpaceTop;
        _mFaceBtn.right = self.width - SSInputBtnSize - 2*SSInputSpaceWid;
        [_mFaceBtn setImage:[[UIImage imageNamed:@"face"]imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_mFaceBtn setImage:[[UIImage imageNamed:@"keyboard"]imageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
        [_mFaceBtn setImage:[[UIImage imageNamed:@"face"]imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [self addSubview:_mFaceBtn];
        [_mFaceBtn addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
        _mFaceBtn.selected = NO;
        
        
        //加号按钮
        _mMoreBtn = [[UIButton alloc] init];
        _mMoreBtn.bounds = makeRect(0, 0, SSInputBtnSize, SSInputBtnSize);
        _mMoreBtn.top = SSInputSpaceTop;
        _mMoreBtn.right = self.width - SSInputSpaceWid;
        [_mMoreBtn setImage:[[UIImage imageNamed:@"more"]imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        [_mMoreBtn setImage:[[UIImage imageNamed:@"more"]imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [self addSubview:_mMoreBtn];
        [_mMoreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        _mMoreBtn.selected = NO;
        
        
        
        //录音按钮
        _mRecordBtn = [[UIButton alloc] init];
        _mRecordBtn.bounds = CGRectMake(0, 0, SSInputTextWidth, SSInputTextHeight);
        [_mRecordBtn setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_mRecordBtn setBackgroundImage:[UIImage imageFromColor:makeColorRgb(235, 235, 235)] forState:UIControlStateHighlighted];
        _mRecordBtn.centerY = self.height * 0.5;
        _mRecordBtn.left = SSInputBtnSize + 2*SSInputSpaceWid;
        _mRecordBtn.titleLabel.font = makeBlodFont(16);
        [_mRecordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_mRecordBtn setTitleColor:makeColorHex(@"#333333") forState:UIControlStateNormal];
        [_mRecordBtn.layer setMasksToBounds:YES];
        [_mRecordBtn.layer setCornerRadius:4];
        _mRecordBtn.backgroundColor = [UIColor whiteColor];
        [_mRecordBtn addTarget:self action:@selector(voideBtnDown:) forControlEvents:UIControlEventTouchDown];
        [_mRecordBtn addTarget:self action:@selector(voideBtnUp:) forControlEvents:UIControlEventTouchUpInside];
        [_mRecordBtn addTarget:self action:@selector(voideBtnCancel:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_mRecordBtn addTarget:self action:@selector(voideBtnExit:) forControlEvents:UIControlEventTouchDragExit];
        [_mRecordBtn addTarget:self action:@selector(voideBtnEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:_mRecordBtn];
        _mRecordBtn.hidden = YES;
        
        //根据字符换行
//        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
        
        //输入框
        _mTextView = [SSInputTextView new];
        _mTextView.frame = _mRecordBtn.frame;
        _mTextView.delegate = self;
        _mTextView.textContainer.lineFragmentPadding = 0;
        _mTextView.enablesReturnKeyAutomatically = YES;
        _mTextView.layoutManager.allowsNonContiguousLayout = NO;
        _mTextView.font = [UIFont systemFontOfSize:16];
        _mTextView.layer.masksToBounds = YES;
        _mTextView.layer.cornerRadius = 4;
        [_mTextView setReturnKeyType:UIReturnKeySend];
        _mTextView.textContainerInset = UIEdgeInsetsMake(10, 5, 7, 5);
        [self addSubview:_mTextView];
         
    }
    return self;
}

//更新控件的位置  height是当前视图应有的总高度
- (void)layoutButton:(CGFloat)height{
    
    CGRect frame = self.frame;
    CGFloat offset = height - frame.size.height;
    frame.size.height = height;
    self.frame = frame;
    
    _mVoiceBtn.bottom = self.height - SSInputSpaceTop;
    _mFaceBtn.bottom  = self.height - SSInputSpaceTop;
    _mMoreBtn.bottom  = self.height - SSInputSpaceTop;

    if(_delegate && [_delegate respondsToSelector:@selector(inputView:didChangeHeight:)]){
        [_delegate inputView:self didChangeHeight:offset];
    }
}

//点击喇叭+键盘按钮
-(void)clickVoiceBtn:(UIButton *)sender{
    
    _mVoiceBtn.selected = !_mVoiceBtn.selected;
    _mRecordBtn.hidden = !_mVoiceBtn.selected;
    _mTextView.hidden = _mVoiceBtn.selected;
    _mFaceBtn.selected = NO;
    _mMoreBtn.selected = NO;
    
    if(!_mVoiceBtn.selected){
        [self clickKeyBordBtn:sender];
    }
    else{
        [self layoutButton:SSInputViewHeight];
        if(_delegate && [_delegate respondsToSelector:@selector(inputViewDidTouchVoice:)]){
            [_delegate inputViewDidTouchVoice:self];
        }
    }
}

//点击表情+键盘按钮
-(void)clickFaceBtn:(UIButton *)sender{
    
    _mFaceBtn.selected = !_mFaceBtn.selected;
    _mVoiceBtn.selected = NO;
    _mMoreBtn.selected = NO;
    _mRecordBtn.hidden = YES;
    _mTextView.hidden = NO;
    
    if(!_mFaceBtn.selected){
        [self clickKeyBordBtn:sender];
    }
    else{
        [self layoutButton:_mTextView.height + (SSInputViewHeight - SSInputTextHeight)];
        if(_delegate && [_delegate respondsToSelector:@selector(inputViewDidTouchFace:)]){
            [_delegate inputViewDidTouchFace:self];
        }
    }
}

//点击+按钮
-(void)clickMoreBtn:(UIButton *)sender{
    
    _mMoreBtn.selected = !_mMoreBtn.selected;
    _mVoiceBtn.selected = NO;
    _mFaceBtn.selected = NO;
    _mRecordBtn.hidden = YES;
    _mTextView.hidden = NO;
    
    if(!_mMoreBtn.selected){
        [self clickKeyBordBtn:sender];
    }
    else{
        [self layoutButton:_mTextView.height + (SSInputViewHeight - SSInputTextHeight)];
        if(_delegate && [_delegate respondsToSelector:@selector(inputViewDidTouchMore:)]){
            [_delegate inputViewDidTouchMore:self];
        }
    }
}

//点击键盘
-(void)clickKeyBordBtn:(UIButton *)sender{
    
    [self layoutButton:_mTextView.height + (SSInputViewHeight - SSInputTextHeight)];
    if(_delegate && [_delegate respondsToSelector:@selector(inputViewDidTouchKeyboard:)]){
        [_delegate inputViewDidTouchKeyboard:self];
    }
}

//清空输入框
- (void)clearInput{
    _mTextView.text = @"";
    [self textViewDidChange:_mTextView];
}

//输入表情
-(void)addEmoji:(NSString *)emoji{
    
    cout(emoji);
    
    [_mTextView replaceRange:_mTextView.selectedTextRange withText:emoji];
    if(_mTextView.contentSize.height > SSInputTextMaxHeight){
        float offset = _mTextView.contentSize.height - _mTextView.height;
        [_mTextView scrollRectToVisible:CGRectMake(0, offset,  _mTextView.width, _mTextView.height) animated:YES];
    }
    [self textViewDidChange:_mTextView];
}

//删除
- (void)deletText{
    
    [_mTextView deleteBackward];
    [self textViewDidChange:_mTextView]; 
}

//开始输入
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.mVoiceBtn.selected = NO;
    self.mFaceBtn.selected = NO;
    self.mMoreBtn.selected = NO;
}

//输入中
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        if(_delegate && [_delegate respondsToSelector:@selector(inputView:didSendText:)]) {
            NSString *sp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (sp.length == 0) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [ac addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil]];
                [[self getViewController] presentViewController:ac animated:YES completion:nil];
            } else {
                [_delegate inputView:self didSendText:textView.text];
                [self clearInput];
            }
        }
        return NO;
    }
    
    // 监听 @ 字符的输入，包含全角/半角
    else if ([text isEqualToString:@"@"] || [text isEqualToString:@"＠"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(inputViewDidInputAt:)]) {
            [self.delegate inputViewDidInputAt:self];
        }
    }
    return YES;
}

//输入结束
- (void)textViewDidChange:(UITextView *)textView{
    
    CGSize size = [_mTextView sizeThatFits:CGSizeMake(_mTextView.width, SSInputTextMaxHeight)];
    CGFloat oldHeight = _mTextView.height;
    CGFloat newHeight = size.height;

    if(newHeight > SSInputTextMaxHeight) newHeight = SSInputTextMaxHeight;
    if(newHeight < SSInputTextHeight) newHeight = SSInputTextHeight;
    if(oldHeight == newHeight) return;

    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect textFrame = wself.mTextView.frame;
        textFrame.size.height += newHeight - oldHeight;
        wself.mTextView.frame = textFrame;
        [wself layoutButton:newHeight + (SSInputViewHeight - SSInputTextHeight)];
    }];
}


//按下录音按钮
-(void)voideBtnDown:(UIButton *)sender{
    
    [_mRecordBtn setTitle:@"松开 结束" forState:UIControlStateNormal];
    _mediaManager = [SSMediaManager shareMediaManager];
    _mediaManager.delegate = self;
    [_mediaManager isRecordGranted];
}

//松开录音按钮
-(void)voideBtnUp:(UIButton *)sender{
    [_mediaManager stopRecord];
}

//取消录音
-(void)voideBtnCancel:(UIButton *)sender{
    _mRecordBtn.backgroundColor = [UIColor whiteColor];
    [_mRecordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
}

-(void)voideBtnExit:(UIButton *)sender{
    [_mRecordBtn setTitle:@"松开 取消" forState:UIControlStateNormal];
}

-(void)voideBtnEnter:(UIButton *)sender{
    _mRecordBtn.backgroundColor = makeColorRgb(235, 235, 235);
    [_mRecordBtn setTitle:@"松开 结束" forState:UIControlStateNormal];
}

//是否可以录音回调
-(void)recordAudioGranted:(BOOL)granted{
    if(granted == NO){
        [SSAlert pressentAlertControllerWithTitle:@"温馨提示" message:@"您的app还没有获取麦克风授权，请先设置！" okButton:@"设置" cancelButton:@"取消" alertBlock:^(UIAlertAction *action) {
            if([action.title isEqual:@"设置"]){
                [AppDelegate jumpToSetting];
            }
        }];
    }else{
        [self addMediaView];
        [self.mediaManager startRecord];
    }
}

//开始录音
-(void)recordAudio:(NSString *)filePath didBeganWithError:(NSError *)error{
    
}

//录音进度回调 更新录音视图倒计时和分贝
-(void)recordAudioProgress:(NSTimeInterval)currentTime{
    
    _mRecordView.power = [_mediaManager recordSoundAveragePower];
    
    if(currentTime >= 50 && currentTime < 60){
         cout(@"倒计时");
        _mRecordView.mLabel.text = @"倒计时N秒";
    }
    if(currentTime >= 60){
        [_mediaManager stopRecord];
    }
}

//录音完成 发送录音消息
-(void)recordAudio:(NSString *)filePath didCompletedWithError:(NSError *)error{
    cout(filePath);
    _mRecordBtn.backgroundColor = [UIColor whiteColor];
    [_mRecordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self removeMediaView];
    if(filePath){
        if(_delegate && [_delegate respondsToSelector:@selector(inputView:didSendVoice:)]){
            [_delegate inputView:self didSendVoice:filePath];
        }
    }
}

//录音被取消的回调
- (void)recordAudioDidCancelled{
    _mRecordBtn.backgroundColor = [UIColor whiteColor];
    [_mRecordBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self removeMediaView];
}

//录音开始被打断回调
- (void)recordAudioInterruptionBegin{
    
}

//录音结束被打断回调
- (void)recordAudioInterruptionEnd{
    
}

//添加录音视图
-(void)addMediaView{
    
    self.mRecordView = [SSMediaRecordView new];
    [[AppDelegate sharedAppDelegate].window addSubview:self.mRecordView];
}

//删除录音视图
-(void)removeMediaView{
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
      
        [wself.mRecordView removeFromSuperview];
        wself.mRecordView = nil;
    });
}

@end
