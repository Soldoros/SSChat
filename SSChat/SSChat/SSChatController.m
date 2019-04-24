//
//  SSChatController.m
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//if (IOS7_And_Later) {
//    self.automaticallyAdjustsScrollViewInsets = NO;
//}

#import "SSChatController.h"
#import "SSChatKeyBoardInputView.h"
#import "SSAddImage.h"
#import "SSChatBaseCell.h"
#import "SSChatLocationController.h"
#import "SSImageGroupView.h"
#import "SSChatMapController.h"


@interface SSChatController ()<SSChatKeyBoardInputViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SSChatBaseCellDelegate>

//聊天列表
@property (strong, nonatomic) UIView    *mBackView;
@property (assign, nonatomic) CGFloat   backViewH;
@property(nonatomic,strong)UITableView *mTableView;
@property(nonatomic,strong)NSMutableArray *datas;
//多媒体键盘
@property(nonatomic,strong)SSChatKeyBoardInputView *mInputView;
//访问相册+摄像头
@property(nonatomic,strong)SSAddImage *mAddImage;
//当前用户
@property(nonatomic,strong)NSString *currentUser;
//数据模型
@property(nonatomic,strong)SSChatDatas *chatData;

//开始翻页的messageId
@property(nonatomic,strong)NSString *startMsgId;

//图片 gif 短视频展开
@property(nonatomic,strong)SSImageGroupView *imageGroupView;

@end

@implementation SSChatController

-(instancetype)init{
    if(self = [super init]){
        _chatType = SSChatConversationTypeChat;
        _datas = [NSMutableArray new];
        _chatData = [SSChatDatas new];
        _currentUser = [[EMClient sharedClient] currentUsername];
    }
    return self;
}

//不采用系统的旋转
- (BOOL)shouldAutorotate{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self registerNoti];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    [_conversation markAllMessagesAsRead:nil];
    
    if(_imageGroupView){
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//接收消息 消息已读回执
-(void)registerNoti{
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessages:) name:NotiReceiveMessages object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagesDidRead:) name:NotiMessageReadBack object:nil];
}

-(void)receiveMessages:(NSNotification *)noti{
    
    dispatch_async(dispatch_queue_create(0, 0), ^{
        NSArray *layouts = [self.chatData getLayoutsWithMessages:noti.object conversationId:self.conversation.conversationId];
        [self.datas addObjectsFromArray:layouts];
        
        dispatch_async(dispatch_get_main_queue(), ^{
             [self updateTableView:YES];
        });
    });
}

//已读回执
-(void)messagesDidRead:(NSNotification *)noti{
    
    dispatch_async(dispatch_queue_create(0, 0), ^{
      
        for(EMMessage *message in noti.object){
            
            for(int i=0;i<self.datas.count;++i){
                SSChatMessagelLayout *layout = self.datas[i];
                if(![layout.chatMessage.message.conversationId isEqualToString:self.conversation.conversationId]){
                    return;
                }else{
                    if([layout.chatMessage.message.messageId isEqualToString:message.messageId]){
                        layout.chatMessage.message.isReadAcked = YES;
                        self.datas[i] = layout;
                    }
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _conversation.conversationId;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _mInputView = [SSChatKeyBoardInputView new];
    _mInputView.delegate = self;
    [self.view addSubview:_mInputView];
    
    _backViewH = SCREEN_Height-SSChatKeyBoardInputViewH-SafeAreaTop_Height-SafeAreaBottom_Height;
    
    _mBackView = [UIView new];
    _mBackView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, _backViewH);
    _mBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mBackView];
    
    _mTableView = [[UITableView alloc]initWithFrame:_mBackView.bounds style:UITableViewStylePlain];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.backgroundColor = SSChatCellColor;
    _mTableView.backgroundView.backgroundColor = SSChatCellColor;
    [_mBackView addSubview:self.mTableView];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _mTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _mTableView.scrollIndicatorInsets = _mTableView.contentInset;
    if (@available(iOS 11.0, *)){
        _mTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _mTableView.estimatedRowHeight = 0;
        _mTableView.estimatedSectionHeaderHeight = 0;
        _mTableView.estimatedSectionFooterHeight = 0;
    }
    
    [_mTableView registerClass:NSClassFromString(@"SSChatTextCell") forCellReuseIdentifier:SSChatTextCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatImageCell") forCellReuseIdentifier:SSChatImageCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatVoiceCell") forCellReuseIdentifier:SSChatVoiceCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatMapCell") forCellReuseIdentifier:SSChatMapCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatVideoCell") forCellReuseIdentifier:SSChatVideoCellId];

    
    [self netWorking:NO];
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self netWorking:YES];
    }];
}


-(void)netWorking:(BOOL)animation{
    
    [_conversation loadMessagesStartFromId:self.startMsgId count:36 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        
        [self.mTableView.mj_header endRefreshing];
        
        if(aMessages.count > 0){
            EMMessage *message = aMessages[0];
            self.startMsgId = message.messageId;
        }
        NSArray *layouts = [self.chatData getLayoutsWithMessages:aMessages conversationId:self.conversation.conversationId];
        [self.datas insertObjects:layouts atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [layouts count])]];
        if(animation == NO){
            [self updateTableView:NO];
        }else{
            [self.mTableView reloadData];
            NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:aMessages.count inSection:0];
            [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }];
    
}


-(void)updateTableView:(BOOL)animation{
    [self.mTableView reloadData];
    if(self.datas.count>0){
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animation];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [(SSChatMessagelLayout *)_datas[indexPath.row] cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSChatMessagelLayout *layout = _datas[indexPath.row];
    SSChatBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:layout.chatMessage.cellString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.layout = layout;
    return cell;
}


//视图归位
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}


#pragma SSChatKeyBoardInputViewDelegate 底部输入框代理回调
//点击按钮视图frame发生变化 调整当前列表frame
-(void)SSChatKeyBoardInputViewHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime{
 
    CGFloat height = _backViewH - keyBoardHeight;
    [UIView animateWithDuration:changeTime animations:^{
        self.mBackView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, height);
        self.mTableView.frame = self.mBackView.bounds;
        [self updateTableView:YES];
    } completion:^(BOOL finished) {
        
    }];
}

//多功能视图点击回调  图片10  视频11  位置12
-(void)SSChatKeyBoardInputViewBtnClickFunction:(NSInteger)index{
    
    if(index==10 || index==11){
        
        if(!_mAddImage) _mAddImage = [[SSAddImage alloc]init];
        [_mAddImage getImagePickerWithAlertController:self modelType:SSImagePickerModelImage + index-10 pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
            
            //发送图片和gif图
            if(index==10){
                if(modelType == SSImagePickerModelImage){
                    [self sendImageMessage:(UIImage *)object];
                }
                else{
                    NSURL *imgUrl = (NSURL *)object;
                }
            }
            //发送视频
            else{
                
                NSString *localPath = (NSString *)object;
                [self sendVideoMessage:localPath];
            }
        }];
        
    }else{
        SSChatLocationController *vc = [SSChatLocationController new];
        vc.locationBlock = ^(NSDictionary *locationDic, NSError *error) {
            
            
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



//发送文本 列表滚动至底部
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string{
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:string];
    [self sendMessage:body messageType:EMChatTypeChat];
}

//发送普通图片
-(void)sendImageMessage:(UIImage *)image{
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"image"];
    body.compressionRatio = 0.6f;
    [self sendMessage:body messageType:EMChatTypeChat];
}

//发送视频
-(void)sendVideoMessage:(NSString *)videoPath{
    
    EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithLocalPath:videoPath displayName:@"video.mp4"];
    [self sendMessage:body messageType:EMChatTypeChat];
}

//发送语音
-(void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view voicePath:(NSString *)voicePath time:(int)second{

    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:voicePath displayName:@"voice"];
    body.duration = second;
    [self sendMessage:body messageType:EMChatTypeChat];
}


//发送消息
-(void)sendMessage:(EMMessageBody *)body messageType:(EMChatType)messageType{

    EMMessage *msg = [[EMMessage alloc] initWithConversationID:_conversation.conversationId from:_currentUser to:_conversation.conversationId body:body ext:nil];
    msg.chatType = messageType;
    NSLog(@"是否已读回执%d",msg.isReadAcked);

    [self updateTableViewWithMessage:msg startSend:YES];
    
    [[EMClient sharedClient].chatManager sendMessage:msg progress:^(int progress) {
        cout(@(progress));
        [self updateTableViewWithMessage:msg startSend:NO];
       
    } completion:^(EMMessage *message, EMError *error) {
        
        [self updateTableViewWithMessage:msg startSend:NO];
        [self sendNotifCation:NotiMessageChange];
    }];
    
}


-(void)updateTableViewWithMessage:(EMMessage *)message startSend:(BOOL)startSend{
   
    dispatch_async(dispatch_queue_create(0, 0), ^{
        if([message.conversationId isEqualToString:self.conversation.conversationId]){
            
            SSChatMessagelLayout *layout = [self.chatData getLayoutWithMessage:message];
            
            if(!startSend){
                self.datas[self.datas.count-1] = layout;
            }
            else [self.datas addObject:layout];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateTableView:YES];
        });
    });
}


#pragma SSChatBaseCellDelegate 点击图片 点击短视频
-(void)SSChatImageVideoCellClick:(NSIndexPath *)indexPath layout:(SSChatMessagelLayout *)layout{
    
    
    NSInteger currentIndex = 0;
    NSMutableArray *groupItems = [NSMutableArray new];
    
    for(int i=0;i<self.datas.count;++i){
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        SSChatBaseCell *cell = [_mTableView cellForRowAtIndexPath:ip];
        SSChatMessagelLayout *mLayout = self.datas[i];
        
        SSImageGroupItem *item = [SSImageGroupItem new];
        if(mLayout.chatMessage.messageType == SSChatMessageTypeImage){
            item.imageType = SSImageGroupImage;
            item.fromImgView = cell.mImgView;
            item.fromImage = nil;
            item.chatMessage = mLayout.chatMessage;
        }
        else if(mLayout.chatMessage.messageType == SSChatMessageTypeGif){
            item.imageType = SSImageGroupGif;
            item.fromImgView = cell.mImgView;
            item.fromImages = mLayout.chatMessage.imageArr;
        }
        else if (mLayout.chatMessage.messageType == SSChatMessageTypeVideo){
           
            item.imageType = SSImageGroupVideo;
            item.fromImgView = cell.mImgView;
            item.chatMessage = mLayout.chatMessage;
        }
        else continue;
        
        item.contentMode = mLayout.chatMessage.contentMode;
        item.itemTag = groupItems.count + 10;
        if([mLayout isEqual:layout])currentIndex = groupItems.count;
        [groupItems addObject:item];
    }
    
    _imageGroupView = [[SSImageGroupView alloc]initWithGroupItems:groupItems currentIndex:currentIndex];
    [self.navigationController.view addSubview:_imageGroupView];

    __block SSImageGroupView *blockView = _imageGroupView;
    blockView.dismissBlock = ^{
        [blockView removeFromSuperview];
        blockView = nil;
    };
    
    [self.mInputView SetSSChatKeyBoardInputViewEndEditing];
}

#pragma SSChatBaseCellDelegate 点击定位
-(void)SSChatMapCellClick:(NSIndexPath *)indexPath layout:(SSChatMessagelLayout *)layout{
    
    SSChatMapController *vc = [SSChatMapController new];
    vc.latitude = layout.chatMessage.latitude;
    vc.longitude = layout.chatMessage.longitude;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
