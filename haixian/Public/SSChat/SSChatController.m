//
//  SSChatController.m
//  haixian

//  Created by soldoros on 2017/10/25.
//  Copyright © 2017年 soldoros. All rights reserved.



#import "SSChatController.h"

#import "SSChatView.h"
#import "SSChatKeyBordView.h"
#import "SSAddImage.h"
#import "SSChatLocationController.h"
#import "SSChatVideoController.h"
#import "SSChatIMEmotionModel.h"

@interface SSChatController ()<UITableViewDelegate,UITableViewDataSource,SSChatBaseCellDelegate,SSChatKeyBordViewDelegate,SSChatLocationControllerDelegate,SSChatBottomDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIView          *mBackView;
@property (strong, nonatomic) NSArray         *cells;

@property(nonatomic,strong)SSChartEmotionImages *emotion;

@property(nonatomic,strong)SSChatView *chatTopView;

//刚进来聊天界面  滚动到最后一行
@property(nonatomic,assign)BOOL frist;

//加载图片
@property(nonatomic,strong)SSAddImage *mAddImage;

@end

@implementation SSChatController

-(instancetype)init{
    if(self = [super init]){
        _frist = YES;
        self.datas = [NSMutableArray new];
        _cells = [SSChatDatas getCells];
        _mAddImage = [SSAddImage new];
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _cHeight = 0;
    _cTime   = 0.25;
    
    //键盘显示 回收的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillHideNotification object:nil];
    
    //普通消息接收回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessage:) name:NotiReceiveMessages object:nil];
    
    //透传消息接收回调(删除 撤销)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getReceiveMessage:) name:NotiReceiveCMDMessages object:nil];
    
    //输入框文字发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textStringChange) name:NotiTextChange object:nil];
}

//接收普通消息
-(void)getMessage:(NSNotification *)noti{
 
    NSArray *arr = [SSChatDatas receiveMessages:[noti object][NotiReceiveMessages]];
    
    for(int i=0;i<arr.count;++i){
        SSChatModel *model = arr[i];
        [SSChatDatas setReadWithUsername:_userName type:_conversationType messageId:model.conversationId];

        SSChatModelLayout *ly = [SSChatDatas layoutWithMessageArray:self.datas model:model];
        [self.datas addObject:ly];
    }
    [self tableReloadData];
    
}

//接收透传消息
-(void)getReceiveMessage:(NSNotification *)noti{
    NSArray *array = [noti object][NotiReceiveCMDMessages];
    
    for (EMMessage *message in array) {
        
        EMCmdMessageBody *body = (EMCmdMessageBody *)message.body;
        NSLog(@"收到的action是 -- %@",body.action);
        
        if ([body.action isEqualToString:REVOKE_FLAG]) {
            NSString *messageId = message.ext[@"msgId"];
            cout(messageId);
            [self recallMessage:message messageId:messageId];
        }
    }
}

//发送按钮状态根据输入框文字变化
-(void)textStringChange{
    if(_mBottomView.textString.length==0 || _mBottomView.textString==nil){
        _mKeyBordView.symbolView.footer.sendButton.enabled = NO;
    }else _mKeyBordView.symbolView.footer.sendButton.enabled = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:_userName];

    self.view.backgroundColor = SSChatCellColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.mBackView = [UIView new];
    self.mBackView.frame = makeRect(0, SafeAreaTop_Height, SCREEN_Width, SSChatBackViewHeight);
    self.mBackView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mBackView];

    self.mTableView = [[UITableView alloc]initWithFrame:_mBackView.bounds style:UITableViewStylePlain];
    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    self.mTableView.backgroundColor = SSChatCellColor;
    self.mTableView.backgroundView.backgroundColor = SSChatCellColor;
    [self.mTableView registerClass:_cells andCellIds:_cells];
    [self.mTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.mBackView addSubview:self.mTableView];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //输入框
    _mBottomView = [[SSChatBottom alloc]init];
    _mBottomView.delegate = self;
    [self.view addSubview:_mBottomView];
    [self.view bringSubviewToFront:_mBottomView];
    
    
    [self.view showActivity];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _emotion = [SSChartEmotionImages ShareSSChartEmotionImages];
        [_emotion initEmotionImages];
        [_emotion initSystemEmotionImages];
        [self netWorking];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view closeActivity];
            
            //多功能视图 + 表情视图
            _mKeyBordView = [[SSChatKeyBordView alloc]initWithFrame:makeRect(0, _mBottomView.bottom, SCREEN_Width, SSChatKeyBordHeight)];
            _mKeyBordView.delegate = self;
            [self.view addSubview:_mKeyBordView];
            
            
        });
    });

}


-(void)netWorking{
    
    EMConversationType type = (EMConversationType)_conversationType;
    
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:_userName type:type createIfNotExist:YES];
    
    [conversation loadMessagesStartFromId:nil count:50 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        cout(aMessages);
        
        for(EMMessage *message in aMessages){
            SSChatModel *model;
            
            //接收的消息
            if(message.direction == EMMessageDirectionReceive){
                
                [SSChatDatas setReadWithUsername:_userName type:_conversationType messageId:message.messageId];
                
                model = [SSChatDatas receiveMessage:message];
                [self.datas addObject:model];
            }
            
            //发送的消息
            else{
                [SSChatDatas setReadWithUsername:_userName type:_conversationType messageId:message.messageId];
                model = [SSChatDatas sendMessage:message];
                [self.datas addObject:model];
            }
            
        }
        
        self.datas = [SSChatDatas arrayWithMessageArray:self.datas];
        [self.mTableView reloadData];
        [self scrollTableViewAnimated:NO];
        
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((SSChatModelLayout *)self.datas[indexPath.row]).height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSChatModelLayout *layout = self.datas[indexPath.row];
    SSChatBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:layout.cellString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selected = NO;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.layout = layout;
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if(scrollView == self.mTableView){
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_mBottomView.type == SSChatBottomTypeEdit){
        [self.view endEditing:YES];
    }else{
        [self deleteSSChatKeyBordView];
    }
    _mBottomView.type = SSChatBottomTypeDefault;
    _mBottomView.currentBtn.selected = NO;
    _mBottomView.mTextView.hidden = NO;
    _mKeyBordView.mCoverView.hidden = NO;
}

//表单加载完成回调
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_frist){
        _frist = NO;
        [self tableReloadData];
    }
}

-(void)tableReloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mTableView reloadData];
        [self scrollTableViewAnimated:YES];
    });
}

//滚动到底部
-(void)scrollTableViewAnimated:(BOOL)animated{
    if(self.datas.count==0 || self.datas == nil)return;
    NSIndexPath *lastIndex = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
    [self.mTableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

//点击头像
-(void)SSChatBaseCellImgBtnClick:(NSInteger)index indexPath:(NSIndexPath *)indexPath{
    SSChatModelLayout *yout = self.datas[indexPath.row];
    if(yout.model.messageFrom == SSChatMessageFromMe){
      
        
    }
}


#pragma mark SSChatBaseCellDelegate
//cell按钮点击事件
-(void)SSChatBaseCellBtnClick:(NSIndexPath *)indexPath index:(NSInteger)index messageType:(SSChatMessageType)messageType{
    SSChatModelLayout *yout = self.datas[indexPath.row];

    cout(yout.model.message.messageId);
    
    //点击文本 撤销11 删除12
    if(messageType == SSChatMessageTypeText){
        
        
        
        if(index==11){
            if(yout.model.messageFrom == SSChatMessageFromOther){
                [self showTime:@"只能撤销自己的消息"];
                return;
            }
            NSTimeInterval time1 = (yout.model.messageTime) / 1000.0;
            // 当前的时间戳
            NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
            NSTimeInterval cha = nowTime - time1;
            NSInteger timecha = cha;
            if (timecha <= 120) {
                // 开始调用发送消息回撤的方法
                [self revokeMessageWithMessageId:yout.model.message.messageId conversationId:self.userName indexPath:indexPath];
            } else {
                [self showTime:@"消息已经超过两分钟 无法撤回"];
            }
            
        }else{
            [self removeRevokeMessageWithChatter:_userName messageId:yout.model.message.messageId indexPath:indexPath];
        }
    }
    //点击图片
    else if (messageType == SSChatMessageTypeText){
        
    }
    //点击地图
    else if (messageType == SSChatMessageTypeText){
        
    }
    //点击视频
    else{
        
        SSChatVideoController *vc = [SSChatVideoController new];
        vc.layout = yout;
        [self.navigationController pushViewController:vc animated:NO];
        
    }
}

//发送透传消息
- (void)revokeMessageWithMessageId:(NSString *)aMessageId   conversationId:(NSString *)conversationId indexPath:(NSIndexPath *)indexPath{
    
    EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:REVOKE_FLAG];
    NSString *me = [[EMClient sharedClient] currentUsername];
    NSDictionary *ext = @{@"msgId":aMessageId};

    EMMessage *message = [[EMMessage alloc] initWithConversationID:conversationId from:me to:conversationId body:body ext:ext];
    message.chatType = EMChatTypeChat;
    
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            NSLog(@"发送成功");
//            SSChatModel *model = (SSChatModel *)[self.datas[indexPath.row] model];
//            model.messageType =  SSChatMessageTypeRecallMsg;
//
//            self.datas[indexPath.row] = [[SSChatModelLayout alloc]initWithModel:model];
//            [self.mTableView reloadData];
            NSString *messageId = message.ext[@"msgId"];
            
            [self recallMessage:message messageId:messageId];
            
        }  else {
            NSLog(@"发送失败");
        }
    }];
}



//撤回消息
-(void)recallMessage:(EMMessage *)message messageId:(NSString *)messageId{
    
    [[EMClient sharedClient].chatManager recallMessage:message  completion:^(EMMessage *aMessage, EMError *aError) {
        
        [self showTime:@"撤回消息成功"];
        for(int i=0;i<self.datas.count;++i){
            SSChatModel *model = (SSChatModel *)[self.datas[i] model];
            if([model.messageId isEqualToString:messageId]){
                model.messageType =  SSChatMessageTypeRecallMsg;
                self.datas[i] = [[SSChatModelLayout alloc]initWithModel:model];
                break;
            }
        }
        [self.mTableView reloadData];
        
    }];
}

// 删除消息
- (void)removeRevokeMessageWithChatter:(NSString *)userName
                             messageId:(NSString *)messageId indexPath:(NSIndexPath *)indexPath{
    
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:userName type:EMConversationTypeChat createIfNotExist:YES];
    EMError *error = nil;
    [conversation deleteMessageWithId:messageId error:&error];
    if(!error){
        [self showTime:@"消息成功删除"];
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.mTableView reloadData];
    }
    
}


//撤回消息重新编辑
- (void)SSChatBaseCellLabClick:(NSIndexPath *)indexPath index:(NSInteger)index yout:(SSChatModelLayout *)yout{
    _mBottomView.emojiText = yout.model.textString;
    [_mBottomView.mTextView becomeFirstResponder];
}

//添加多功能视图
-(void)addSSChatKeyBordView{
    [UIView animateWithDuration:_cTime animations:^{
        _mBackView.height  = SSChatBackViewHeight2;
        self.mTableView.height = _mBackView.height;
        _mBottomView.keyBordHieght = SafeAreaBottom_Height+_mKeyBordView.height;
        _mBottomView.bottom   = SCREEN_Height-SafeAreaBottom_Height-_mKeyBordView.height;
        _mKeyBordView.top = _mBottomView.bottom;
        [self scrollTableViewAnimated:YES];
    } completion:^(BOOL finished) {
        self.changeHeight = 0;
    }];
}

//删除多功能视图
-(void)deleteSSChatKeyBordView{
    [UIView animateWithDuration:_cTime animations:^{
        _mBackView.height  = SSChatBackViewHeight;
        self.mTableView.height = _mBackView.height;
        _mBottomView.bottom   = SCREEN_Height-SafeAreaBottom_Height;
        _mKeyBordView.top = _mBottomView.bottom;
        [self scrollTableViewAnimated:YES];
    } completion:^(BOOL finished) {
        self.changeHeight = 0;
        _mKeyBordView.mCoverView.hidden = NO;
    }];
}


//键盘显示监听事件
- (void)keyboardWillChange:(NSNotification *)noti{
    
    _cTime = [[noti userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    _cHeight = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if(noti.name == UIKeyboardWillShowNotification){
        _mBottomView.keyBordHieght = _cHeight;
        _mKeyBordView.mCoverView.hidden = NO;
        _mBottomView.type = SSChatBottomTypeEdit;
        _mBottomView.currentBtn.selected = NO;
        _mBottomView.mTextView.hidden = NO;
    }
    
    [UIView animateWithDuration:_cTime animations:^{
        if(noti.name == UIKeyboardWillShowNotification){
            
            _mBackView.height  = SCREEN_Height-SSChatBotomHeight-SafeAreaTop_Height - _cHeight;
            self.mTableView.height = _mBackView.height;
            _mBottomView.bottom   = SCREEN_Height-_cHeight;
            _mKeyBordView.top = _mBottomView.bottom;
            
        }else{
            if(_mBottomView.type == SSChatBottomTypeSymbol ||
               _mBottomView.type == SSChatBottomTypeAdd){
                _mBackView.height  = SSChatBackViewHeight2;
                self.mTableView.height = _mBackView.height;
                _mBottomView.bottom   = SCREEN_Height-SafeAreaBottom_Height-_mKeyBordView.height;
                _mKeyBordView.top = _mBottomView.bottom;
                _mBottomView.keyBordHieght = SafeAreaBottom_Height+_mKeyBordView.height;
            }else{
                _mBackView.height  = SSChatBackViewHeight;
                self.mTableView.height = _mBackView.height;
                _mBottomView.bottom   = SCREEN_Height-SafeAreaBottom_Height;
                _mKeyBordView.top = _mBottomView.bottom;
                _mBottomView.keyBordHieght = SafeAreaBottom_Height;
            }
        }
        [self scrollTableViewAnimated:YES];
    } completion:^(BOOL finished) {
        self.changeHeight = 0;
        
    }];
}


#pragma SSChatKeyBordViewDelegate 底部多功能视图或表情视图点击回调
//照片10  拍摄11  位置12     表情切换100+  发送200
-(void)SSChatKeyBordViewBtnClick:(NSInteger)index type:(KeyBordViewFouctionType)type{
    
    if(type==KeyBordViewFouctionAdd){
        if(index==10){
            [_mAddImage getImagePickerWithAlertController:self modelType:SSImagePickerModelImage pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
                [self SSAddImageGetimage:(UIImage *)object];
            }];
            
        }else if (index==11){
            
            [_mAddImage getImagePickerWithAlertController:self modelType:SSImagePickerModelVideo pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
                [self SSChatBottomSendVideo:(NSString *)object];
            }];

        }else{
            SSChatLocationController *vc = [SSChatLocationController new];
            vc.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
    }
    //表情切换100+ 发送200
    else{
        if (index==200){
            [_mBottomView startSendMessage];
        }
    }
}


//点击表情回调
-(void)SSChatKeyBordSymbolViewBtnClick:(NSObject *)emojiText{
    _mBottomView.emojiText = emojiText;
}

#pragma SSChatBottomDelegate 点击键盘发送按钮回调10 发送文本消息200
-(void)SSChatBottomBtnClick:(NSString *)string{
    NSDictionary *dic = @{@"text":string,
                          @"userName":_userName};
    [self sendMessage:dic messageType:SSChatMessageTypeText];
}

#pragma SSAddImageDelegate 处理图片回调
-(void)SSAddImageGetimage:(UIImage *)theImage{
    NSDictionary *dic = @{@"img":theImage,
                          @"userName":_userName};
    [self sendMessage:dic messageType:SSChatMessageTypeImage];
}

#pragma  SSChatBottomDelegate  录音完毕回调
-(void)SSChatBottomBtnClick:(SSChatBottom *)view sendVoice:(NSData *)voice time:(NSInteger)second{
    NSDictionary *dic = @{@"voice":voice,
                          @"second":[NSNumber numberWithInteger:second],
                          @"userName":_userName};
    [self sendMessage:dic messageType:SSChatMessageTypeVoice];
}

#pragma SSChatLocationControllerDelegate 位置定位回调
-(void)SSChatLocationControllerSendLatitude:(double)latitude longitude:(double)longitude address:(NSString *)address{
    NSDictionary *dic = @{@"latitude":@(latitude),
                          @"longitude":@(longitude),
                          @"address":address,
                          @"userName":_userName};
    [self sendMessage:dic messageType:SSChatMessageTypeMap];
}

#pragma   发送短视频
-(void)SSChatBottomSendVideo:(NSString *)localPath{
    NSDictionary *dic = @{@"video":localPath,
                          @"userName":_userName};
    [self sendMessage:dic messageType:SSChatMessageTypeVideo];
}

//发送消息
-(void)sendMessage:(NSDictionary *)dict messageType:(SSChatMessageType)messageType{
    
    [SSChatDatas sendMessage:dict messageType:messageType progressBlock:^(int progress) {
        
    } messageBlock:^(EMMessage *message, EMError *error) {
        SSChatModel *md = [SSChatDatas sendMessage:message];
        md.message = message;
        md.sendError = error?YES:NO;
        
        SSChatModelLayout *ly = [SSChatDatas layoutWithMessageArray:self.datas model:md];
        [self.datas addObject:ly];
        [self tableReloadData];
    }];
}








@end
