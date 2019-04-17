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
//环信会话
@property(nonatomic,strong)EMConversation *conversation;
//当前用户
@property(nonatomic,strong)NSString *currentUser;
//数据模型
@property(nonatomic,strong)SSChatDatas *chatData;

@end

@implementation SSChatController

-(instancetype)init{
    if(self = [super init]){
        _chatType = SSChatConversationTypeChat;
        _datas = [NSMutableArray new];
        _chatData = [SSChatDatas new];
    }
    return self;
}

//根据_sessionId获取会话
-(void)setSessionId:(NSString *)sessionId{
    _sessionId = sessionId;
    
    _currentUser = [[EMClient sharedClient] currentUsername];
    if(_chatType == SSChatConversationTypeChat){
        _conversation = [[EMClient sharedClient].chatManager getConversation:_sessionId type:EMConversationTypeChat createIfNotExist:YES];
    }
    else if(_chatType == SSChatConversationTypeGroupChat){
        _conversation = [[EMClient sharedClient].chatManager getConversation:_sessionId type:EMConversationTypeGroupChat createIfNotExist:YES];
    }
}

//不采用系统的旋转
- (BOOL)shouldAutorotate{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
}

//消息发生变化+接收消息
-(void)registerNoti{
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessages:) name:NotiReceiveMessages object:nil];
}

-(void)receiveMessages:(NSNotification *)noti{
    
    NSArray *layouts = [_chatData getLayoutsWithMessages:noti.object];
    [_datas addObjectsFromArray:layouts];
    [self updateTableView:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNoti];
    self.navigationItem.title = _sessionId;
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
    
}

-(void)netWorking:(BOOL)animation{
    
    [_conversation loadMessagesStartFromId:nil count:100 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        
        NSArray *layouts = [self.chatData getLayoutsWithMessages:aMessages];
        [self.datas addObjectsFromArray:layouts];
        [self updateTableView:animation];
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
    SSChatBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:layout.message.cellString];
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


//发送文本 列表滚动至底部
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string{
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:string];
    [self sendMessage:body messageType:EMChatTypeChat];
}


//发送语音
-(void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view sendVoice:(NSData *)voice time:(NSInteger)second{

    NSDictionary *dic = @{@"voice":voice,
                          @"second":@(second)};
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
                    NSDictionary *dic = @{@"imageLocalPath":imgUrl};
                   
                    
                }
            }
            
            else{
                NSString *localPath = (NSString *)object;
                NSLog(@"%@",localPath);
                NSDictionary *dic = @{@"videoLocalPath":localPath};
                
                
            }
        }];
        
    }else{
        SSChatLocationController *vc = [SSChatLocationController new];
        vc.locationBlock = ^(NSDictionary *locationDic, NSError *error) {
            
            
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


-(void)sendImageMessage:(UIImage *)image{
    
    NSData *data = UIImagePNGRepresentation(image);
    //压缩图片为0.6倍 并创建消息体
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"image"];
    body.compressionRatio = 0.6f;
    [self sendMessage:body messageType:EMChatTypeChat];
}


//发送消息
-(void)sendMessage:(EMMessageBody *)body messageType:(EMChatType)messageType{

    EMMessage *message = [[EMMessage alloc] initWithConversationID:_sessionId from:_currentUser to:_sessionId body:body ext:nil];
    message.chatType = messageType;
    
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        cout(@(progress));
    } completion:^(EMMessage *message, EMError *error) {
        
        [self sendNotifCation:NotiMessageChange];
        SSChatMessagelLayout *layout = [self.chatData getLayoutWithMessage:message];
        [self.datas addObject:layout];
        [self updateTableView:YES];
        
    }];
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
        if(mLayout.message.messageType == SSChatMessageTypeImage){
            item.imageType = SSImageGroupImage;
            item.fromImgView = cell.mImgView;
            item.fromImage = nil;
        }
        else if(mLayout.message.messageType == SSChatMessageTypeGif){
            item.imageType = SSImageGroupGif;
            item.fromImgView = cell.mImgView;
            item.fromImages = mLayout.message.imageArr;
        }
        else if (mLayout.message.messageType == SSChatMessageTypeVideo){
            item.imageType = SSImageGroupVideo;
            item.videoPath = mLayout.message.videoLocalPath;
            item.fromImgView = cell.mImgView;
            item.fromImage = mLayout.message.videoImage;
        }
        else continue;
        
        item.contentMode = mLayout.message.contentMode;
        item.itemTag = groupItems.count + 10;
        if([mLayout isEqual:layout])currentIndex = groupItems.count;
        [groupItems addObject:item];
        
    }
    
    SSImageGroupView *imageGroupView = [[SSImageGroupView alloc]initWithGroupItems:groupItems currentIndex:currentIndex];
    [self.navigationController.view addSubview:imageGroupView];
    
    __block SSImageGroupView *blockView = imageGroupView;
    blockView.dismissBlock = ^{
        [blockView removeFromSuperview];
        blockView = nil;
    };
    
    [self.mInputView SetSSChatKeyBoardInputViewEndEditing];
}

#pragma SSChatBaseCellDelegate 点击定位
-(void)SSChatMapCellClick:(NSIndexPath *)indexPath layout:(SSChatMessagelLayout *)layout{
    
    SSChatMapController *vc = [SSChatMapController new];
    vc.latitude = layout.message.latitude;
    vc.longitude = layout.message.longitude;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
