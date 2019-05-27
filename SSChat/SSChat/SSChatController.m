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


@interface SSChatController ()<SSChatKeyBoardInputViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SSChatBaseCellDelegate,NIMChatManagerDelegate,NIMConversationManagerDelegate>

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
        _datas = [NSMutableArray new];
        _chatData = [SSChatDatas new];
        
    }
    return self;
}

//不采用系统的旋转
- (BOOL)shouldAutorotate{
    return NO;
}

-(void)dealloc{
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    
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
    
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    [[NIMSDK sharedSDK].mediaManager stopPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [SSChatDatas getNavagationTitle:_session];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    
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
    
    NSArray<NIMMessage *> *messages = [[[NIMSDK sharedSDK] conversationManager] messagesInSession:_session message:nil limit:20];
 
    
    NSArray *layouts = [self.chatData getLayoutsWithMessages:messages sessionId:_session.sessionId];
    
    [self.datas insertObjects:layouts atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [layouts count])]];
    if(animation == NO){
        [self updateTableView:NO];
    }else{
        [self.mTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:messages.count inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
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
                    [self sendImageMessage:(NSString *)object];
                }
                else{
                   
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


//发送文本
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string{
    
    NIMMessage *message = [NIMMessage new];
    message.text = string;
    [[[NIMSDK sharedSDK] chatManager] sendMessage:message toSession:_session error:nil];
}

//发送普通图片
-(void)sendImageMessage:(NSString *)path{

    NIMImageObject *object = [[NIMImageObject alloc]initWithFilepath:path];
    NIMMessage *message = [NIMMessage new];
    message.messageObject = object;
    [[[NIMSDK sharedSDK] chatManager] sendMessage:message toSession:_session error:nil];
}

//发送视频
-(void)sendVideoMessage:(NSString *)videoPath{
    
    NIMVideoObject *object = [[NIMVideoObject alloc]initWithSourcePath:videoPath];
    NIMMessage *message = [NIMMessage new];
    message.messageObject = object;
    [[[NIMSDK sharedSDK] chatManager] sendMessage:message toSession:_session error:nil];
}

//发送语音
-(void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view voicePath:(NSString *)voicePath time:(int)second{

    cout(voicePath);
    NIMAudioObject *audioObject = [[NIMAudioObject alloc] initWithSourcePath:voicePath scene:NIMNOSSceneTypeMessage];
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = audioObject;
    message.text = @"发来了一段语音";
    NIMMessageSetting *setting = [[NIMMessageSetting alloc] init];
    setting.scene = NIMNOSSceneTypeMessage;
    message.setting = setting;
    [[[NIMSDK sharedSDK] chatManager] sendMessage:message toSession:_session error:nil];
}


#pragma mark - NIMChatManagerDelegate
//接收到消息
-(void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    
    dispatch_async(dispatch_queue_create(0, 0), ^{
        NSArray *layouts = [self.chatData getLayoutsWithMessages:messages sessionId:self.session.sessionId];
        [self.datas addObjectsFromArray:layouts];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateTableView:YES];
        });
    });
}

//消息即将发送 更新本地列表
-(void)willSendMessage:(NIMMessage *)message{
    SSChatMessagelLayout *layout = [self.chatData getLayoutWithMessage:message];
    [self.datas addObject:layout];
    [self updateTableView:YES];
}

//消息发送完成 刷新本地列表
-(void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    if([message.session isEqual:_session]){
        for(int i=0;i<self.datas.count;++i){
            
            SSChatMessagelLayout *layout = self.datas[i];
            NSString *messageId = layout.chatMessage.message.messageId;
            
            if([messageId isEqualToString:message.messageId]){
                [self.datas replaceObjectAtIndex:i withObject:layout];
                break;
            }
        }
        [self.mTableView reloadData];
    }
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
    blockView.dismissBlock = ^(SSImageGroupItem *item) {
        if(item.imageType == SSImageGroupVideo){
            NSString *path = item.chatMessage.videoObject.url;
            [[NIMSDK sharedSDK].resourceManager cancelTask:path];
        }
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
