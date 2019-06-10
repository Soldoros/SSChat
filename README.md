<div align=center> 
  <img src= "https://github.com/Soldoros/SSChat/blob/master/datu/Hello.png" width="500"> 
</div>

<h3>友情提示：客官们下载代码后需要执行pod update 加载网易的IM库 才能运行</h3>

<h3>有需要静态版本的伙伴们可以添加我的钉钉 13540033103</h3><br><br>


<span>Hello是基于SSChat开发的一款聊天系统，支持在线发送文本、Emojo、图片、动图、音频、视频、位置等。整体功能和界面参照主流的社交软件进行设计，借鉴了微信、QQ、钉钉的一些风格。在此要十分感谢云淡风轻提供的素材，感谢网易云IM！ </span>

<span>邮箱：765970680@qq.com  <br>
      钉钉：13540033103 <br>
      简书：https://www.jianshu.com/p/a65905cb3072 </span><br>
  
<span>测试账号1：13540033101 &nbsp;&nbsp;&nbsp; aaaa1111  <br>
      测试账号2：13540033103 &nbsp;&nbsp;&nbsp; aaaa1111 <br></span><br>

<br><br>
<div align=center> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/1.PNG" width="345"> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/4.PNG" width="345">
</div>
<br>

<h2>使用到的第三方工具</h2>

```Objective-C
pod 'IQKeyboardManager'
pod 'MJRefresh'
pod 'YYKit'
pod 'NIMSDK'
pod 'BmobSDK'
```

<h2>一、使用键盘</h2>

1.plist文件需要设置权限 https配置 访问相机 麦克风 相册  <br>
```Objective-C

[App Transport Security Settings -> Allow Arbitrary Loads + YES ]
[App Transport Security Settings -> Allow Arbitrary Loads in Web Content + YES]

[Privacy - Camera Usage Description 是否允许此App使用你的相机]
[Privacy - Location Always and When In Use Usage Description 系统想要访问您的位置]
[Privacy - Location When In Use Usage Description 系统想要访问您的位置]
[Privacy - Microphone Usage Description 系统想要访问您的麦克风]
[Privacy - Photo Library Additions Usage Description 系统需要访问您的相册]
[Privacy - Photo Library Usage Description 系统需要访问您的相册]

```
2.在需要用键盘的控制器引用头文件并设置代理,声明多媒体键盘全局对象

```Objective-C
#import "SSChatKeyBoardInputView.h" 
<SSChatKeyBoardInputViewDelegate>

//多媒体键盘
@property(nonatomic,strong)SSChatKeyBoardInputView *mInputView;
```
3.初始化多媒体键盘

```Objective-C
_mInputView = [SSChatKeyBoardInputView new];
_mInputView.delegate = self;
[self.view addSubview:_mInputView]; 
```
4.聊天界面通常是一个表单UITableView，这个时候需要在表单点击回调和滚动视图的滚动回调里面对键盘弹出收起做一个简单处理。

```Objective-C
//Keyboard and list view homing
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

```
5.在键盘的回调方法中，改变输入框高度和键盘位置的方法回调中，需要处理当前表单的frame，具体frame调整需要针对界面的布局来定，这里只对UITableView和它的父视图做个简单调整。

```Objective-C
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

-(void)updateTableView:(BOOL)animation{
    [self.mTableView reloadData];
    if(self.datas.count>0){
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animation];
    }
}

```
6.其它功能根据需求而定，文本消息在跟后台对接时只能使用字符串，布局是需要做图文混排处理，生成富文本。多功能视图简单处理了图片、视频和定位，大家可以自己拓展需要的功能，并在回调方法直接编写逻辑。

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

<h2>二、图片和短视频缩放</h2>

1.添加AVFoundation.framework系统库,引用头文件#import "SSImageGroupView.h"

2.在点击图片或短视频的时候对图片、短视频的数组做处理，有一些必传的参数

```Objective-C

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

```

<h2>三、直接使用SSChat</h2>

1.引用头文件#import "SSChatController.h"，有一部分的类别大家参考使用，可以改成自己封装的，后期完善后再更新上来。

2.初始化聊天界面，sessionId为会话Id，对接后台时需要传递，这里在做时间5分钟间隔的时候用到了。chatType为会话类型，区分群聊和单聊。群聊和单聊界面相似，后期会更新上来。

```Objective-C
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NIMRecentSession *recentSession = self.datas[indexPath.row];
    SSChatController *vc = [SSChatController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.session = recentSession.session;
    [self.navigationController pushViewController:vc animated:YES];
}

```
