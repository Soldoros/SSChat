//
//  SSInputController.m
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "SSInputController.h"
#import "SSFaceConfig.h"

@interface SSInputController ()<SSInputViewDelegate,SSInputMoreViewDelegate,SSInputFaceViewDelegate>

@end

@implementation SSInputController

-(instancetype)init{
    if(self = [super init]){
        _mStatus = SSInputStatusDefault;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationNil];
    self.view.backgroundColor = BackGroundColor;
    
    
    _mInpuView = [[SSInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SSInputViewHeight)];
    [self.view addSubview:_mInpuView];
    _mInpuView.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//如果是点击其他按钮导致输入框变成非响应者 不必走这步的刷新位置
//否则其他视图跟键盘回收动作冲突 会造成刷新位置时的闪动
- (void)keyboardWillHide:(NSNotification *)notification{
    
    if(_mStatus == SSInputStatusInput){
        if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
            [_delegate inputController:self didChangeHeight: _mInpuView.height + SafeAreaBottom_Height];
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if(_mStatus == SSInputStatusFace) {
        [self hideFaceAnimation];
    }
    if(_mStatus == SSInputStatusMore) {
        [self hideMoreAnimation];
    }
    _mStatus = SSInputStatusInput;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:keyboardFrame.size.height + _mInpuView.height];
    }
}


//输入条总高度变化回调
-(void)inputView:(SSInputView *)textView didChangeHeight:(CGFloat)offset{
    
    if(_mStatus == SSInputStatusFace)[self showFaceAnimation];
    if(_mStatus == SSInputStatusMore)[self showMoreAnimation];

    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:self.view.height + offset];
    }
}

//点击喇叭回调
-(void)inputViewDidTouchVoice:(SSInputView *)textView{
    
    _mStatus = SSInputStatusTalk;
    [_mInpuView.mTextView resignFirstResponder];
    [self hideFaceAnimation];
    [self hideMoreAnimation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:SSInputViewHeight + SafeAreaBottom_Height];
    }
}

//加号按钮点击回调
-(void)inputViewDidTouchMore:(SSInputView *)textView{
    
    if(_mStatus == SSInputStatusFace){
        [self hideFaceAnimation];
    }
    _mStatus = SSInputStatusMore;
    [_mInpuView.mTextView resignFirstResponder];
    [self showMoreAnimation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:_mInpuView.height + SafeAreaBottom_Height + self.mMoreView.height];
    }
}

//表情按钮点击
-(void)inputViewDidTouchFace:(SSInputView *)textView{
    
    if(_mStatus == SSInputStatusMore){
        [self hideMoreAnimation];
    }
    _mStatus = SSInputStatusFace;
    [_mInpuView.mTextView resignFirstResponder];
    [self showFaceAnimation];
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:_mInpuView.height + _mFaceView.height  + SafeAreaBottom_Height];
    }
}

//点击输入框
-(void)inputViewDidTouchKeyboard:(SSInputView *)textView{
    
    if(_mStatus == SSInputStatusFace){
        [self hideFaceAnimation];
    }
    if(_mStatus == SSInputStatusMore){
        [self hideMoreAnimation];
    }
    _mStatus = SSInputStatusInput;
    [_mInpuView.mTextView becomeFirstResponder];
}


-(SSInputMoreView *)mMoreView{
    if(!_mMoreView){
        _mMoreView = [[SSInputMoreView alloc] initWithFrame:CGRectMake(0, _mInpuView.bottom, self.view.width, SSInputMoreViewH)];
        _mMoreView.delegate = self;
    }
    return _mMoreView;
}

- (void)showMoreAnimation{
    
    [self.view addSubview:self.mMoreView];
    self.mMoreView.hidden = NO;
    self.mMoreView.top = SCREEN_Height;
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 animations:^{
        ws.mMoreView.top = ws.mInpuView.bottom;
    }];
}

- (void)hideMoreAnimation{
    
    self.mMoreView.hidden = NO;
    self.mMoreView.alpha = 1.0;
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.mMoreView.alpha = 0.01;
    } completion:^(BOOL finished) {
        ws.mMoreView.hidden = YES;
        ws.mMoreView.alpha = 1.0;
        [ws.mMoreView removeFromSuperview];
    }];
}


- (SSInputFaceView *)mFaceView{
    
    if(!_mFaceView){
        _mFaceView = [[SSInputFaceView alloc] initWithFrame:CGRectMake(0, _mInpuView.top + _mInpuView.height, self.view.width,  SSInputFaceViewH)];
        _mFaceView.delegate = self;
        _mFaceView.datas = [SSFaceConfig shareFaceConfig].systemImages;
    }
    return _mFaceView;
}

- (void)showFaceAnimation
{
    [self.view addSubview:self.mFaceView];

    _mFaceView.hidden = NO;
    CGRect frame = _mFaceView.frame;
    frame.origin.y = SCREEN_Height;
    _mFaceView.frame = frame;
    
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect newFrame = ws.mFaceView.frame;
        newFrame.origin.y = ws.mInpuView.top + ws.mInpuView.height;
        ws.mFaceView.frame = newFrame;
    } completion:nil];
}


- (void)hideFaceAnimation
{
    self.mFaceView.hidden = NO;
    self.mFaceView.alpha = 1.0;
    
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.mFaceView.alpha = 0.01;
    } completion:^(BOOL finished) {
        ws.mFaceView.hidden = YES;
        ws.mFaceView.alpha = 1.0;
        [ws.mFaceView removeFromSuperview];
    }];
}

//点击更多弹窗里面的按钮回调 {@"img":@"",@"name":@""}
-(void)inputMoreView:(SSInputMoreView *)moreView didSelect:(NSDictionary *)dic{
    cout(dic);
    if(_delegate && [_delegate respondsToSelector:@selector(inputController:didSelect:)]){
        [_delegate inputController:self didSelect:dic];
    }
}

//点击表情里面的表情或者按钮回调 表情10 发送50  删除51  标签分类100+
-(void)inputFaceViewDidBtnClick:(SSInputFaceView *)faceView sender:(UIButton *)sender{
    cout(sender);
    
    //发送
    if(sender.tag == 50){
        [self inputView:_mInpuView didSendText:_mInpuView.mTextView.text];
    }
    
    //表情
    if(sender.tag == 10){
        [_mInpuView addEmoji:sender.titleLabel.text];
    }
    
    //删除
    if(sender.tag == 51){
        [_mInpuView deletText];
    }
}

//发送文本
-(void)inputView:(SSInputView *)textView didSendText:(NSString *)text{
    
    if([text isEqualToString:@""])return;
    
    NSDictionary *dic = @{@"body":text,
                          @"type":@(SSChatMessageTypeText),
                          @"from":@(SSChatMessageFromMe),
                          @"name":@"神经萝卜"
    };
    NSDictionary *dic2 = @{@"body":text,
                          @"type":@(SSChatMessageTypeText),
                          @"from":@(SSChatMessageFromOther),
                           @"name":@"我爱罗"
    };
    SSChatMessage *message = [[SSChatMessage alloc] initWithDic:dic];
    SSChatMessage *message2 = [[SSChatMessage alloc] initWithDic:dic2];
    [_mInpuView clearInput];
    
    if(_delegate && [_delegate  respondsToSelector:@selector(inputController:didSendMessage:)]){
        [_delegate inputController:self didSendMessage:message];
        [_delegate inputController:self didSendMessage:message2];
    }
}


@end
