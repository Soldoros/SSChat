<div align=center> 
  <h1>聊天界面 SSChat</h1> 
</div>
<br>
<span>SSChat refers to the current more mainstream chat system layout, the overall function is more general. Each module supports a high degree of customization, including chat bubbles, avatars, Emotion for multimedia keyboards, keyboard extensions, etc., which are easy to update. It is worth noting that the AVPlayerLayer used for short video playback at present cannot be opened in the simulator. You can use the real machine to run, and you will be notified after the later update. SSChat picture short video zoom, keyboard module, message data module and layout module are individually encapsulated, can be used alone, can also use SSChatController directly！</span><br><br>

<span>email：765970680@qq.com  <br>
      dingTalk：13540033103 <br>
      Jane's book：https://www.jianshu.com/p/fdda35fd2897 </span><br><br>


<div align=center> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/1.PNG" width="345"> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/4.PNG" width="345">
</div>


<h2>一、Keyboard usage</h2>

1.Drag the SSChatKeyBoard folder into the project

2.The plist file needs to set permissions to access the camera microphone album

3.In the need to use the keyboard controller header file reference # import "SSChatKeyBoardInputView. H" and set the proxy SSChatKeyBoardInputViewDelegate

4.A statement object

```Objective-C
//The input box at the bottom carries the expression view and the multifunctional view
@property(nonatomic,strong)SSChatKeyBoardInputView *mInputView;
```
5.初始化多媒体键盘Initializes the multimedia keyboard

```Objective-C
_mInputView = [SSChatKeyBoardInputView new];
_mInputView.delegate = self;
[self.view addSubview:_mInputView]; 
```
6.The chat interface is usually a form UITableView, which requires a simple process to pop up the keyboard in the form by clicking back and scrolling back in the scroll view.

```Objective-C
//Keyboard and list view homing
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

```
7.In the keyboard callback method, the method callback that changes the height of the input box and the keyboard position needs to deal with the frame of the current form. The specific frame adjustment needs to be specific to the layout of the interface. Here, only a simple adjustment is made to the UITableView and its parent view.

```Objective-C
#pragma SSChatKeyBoardInputViewDelegateThe bottom input box proxy callback
//Click the button view frame to change the current list frame
-(void)SSChatKeyBoardInputViewHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime{
 
    CGFloat height = _backViewH - keyBoardHeight;
    [UIView animateWithDuration:changeTime animations:^{
        self.mBackView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, height);
        self.mTableView.frame = self.mBackView.bounds;
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
}

```
8.Other functions depend on requirements, text messages can only use strings when docking with the background, layout is the need to do mixed processing of graphics and text, generate rich text. Multi-function view simple processing of images, video and positioning, you can extend the required function, and directly write logic in the callback method.

```Objective-C
//Send text messages
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string;

//Send voice messages
- (void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view sendVoice:(NSData *)voice time:(NSInteger)second;

//Multi-function view button click callback
-(void)SSChatKeyBoardInputViewBtnClickFunction:(NSInteger)index;
```
<br>
<div align=center> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/6.PNG" width="345"> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/10.PNG" width="345">
</div>
<br>

<h2>二、The image zooms in with the short video</h2>

1.Add avfoundation.framework system library

2.Refer to header file #import "ssimagegroupview.h"

3.Click on the picture or short video when the image, short video array to do processing, there are some must pass parameters

```Objective-C
#pragma SSChatBaseCellDelegate Click on the picture and click on the short video
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
            item.fromImage = mLayout.message.image;
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
    
    //This section is the chat interface keyboard recovery process alone using the media zoom function can not be written
    [self.mInputView SetSSChatKeyBoardInputViewEndEditing];
}
```

<h2>三、Use SSChat directly</h2>

1.Reference header file #import "sschatcontroller.h", there are some categories you refer to use, can be changed to their own packaging, later improved and then updated.

2.Initializes the chat interface. The sessionId is the sessionId and needs to be passed when docking with the background. ChatType - chatType is a session type that distinguishes a group chat from a single chat. Group chat and single chat interface is similar, later will be updated.

```Objective-C
SSChatController *vc = [SSChatController new];
vc.chatType = (SSChatConversationType)[_datas[indexPath.row][@"type"]integerValue];
vc.sessionId = _datas[indexPath.row][@"sectionId"];
vc.titleString = _datas[indexPath.row][@"title"];
[self.navigationController pushViewController:vc animated:YES];

```



