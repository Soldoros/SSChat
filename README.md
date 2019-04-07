<div align=center> 
  <h1>SSChat（OC）</h1> 
</div>
<br>

<span>SSChat参考目前比较主流的聊天系统做的布局，整体功能是比较通用的。每个模块都支持高度自定义，包括聊天气泡、头像、多媒体键盘的Emotion、键盘的功能拓展等，更新都挺方便。值得注意的是目前短视频播放采用的AVPlayerLayer不能在模拟器打开，大家可以用真机运行，后期更新后再行通知。SSChat的图片短视频缩放，键盘模块，消息数据模块和布局模块都单独封装，可以单独使用，也可以直接使用SSChatController！</span></br>


<span>邮箱：765970680@qq.com  <br>
      钉钉：13540033103 <br>
      简书：https://www.jianshu.com/p/fdda35fd2897 </span><br><br><br>


<div align=center> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/1.PNG" width="345"> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/4.PNG" width="345">
</div>


<h2>一、键盘的使用</h2>

1.将 SSChatKeyBoard 文件夹拖入到工程

2.plist文件需要设置权限 访问相机 麦克风 相册

3.在需要用键盘的控制器引用头文件 #import "SSChatKeyBoardInputView.h" 并设置代理 SSChatKeyBoardInputViewDelegate

4.声明对象来

```Objective-C
//The input box at the bottom carries the expression view and the multifunctional view
@property(nonatomic,strong)SSChatKeyBoardInputView *mInputView;
```
5.初始化多媒体键盘

```Objective-C
_mInputView = [SSChatKeyBoardInputView new];
_mInputView.delegate = self;
[self.view addSubview:_mInputView]; 
```
6.聊天界面通常是一个表单UITableView，这个时候需要在表单点击回调和滚动视图的滚动回调里面对键盘弹出收起做一个简单处理。

```Objective-C
//Keyboard and list view homing
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

```
7.在键盘的回调方法中，改变输入框高度和键盘位置的方法回调中，需要处理当前表单的frame，具体frame调整需要针对界面的布局来定，这里只对UITableView和它的父视图做个简单调整。

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
8.其它功能根据需求而定，文本消息在跟后台对接时只能使用字符串，布局是需要做图文混排处理，生成富文本。多功能视图简单处理了图片、视频和定位，大家可以自己拓展需要的功能，并在回调方法直接编写逻辑。

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

1.添加AVFoundation.framework系统库

2.引用头文件#import "SSImageGroupView.h"

3.在点击图片或短视频的时候对图片、短视频的数组做处理，有一些必传的参数

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

<h2>三、直接使用SSChat</h2>

1.引用头文件#import "SSChatController.h"，有一部分的类别大家参考使用，可以改成自己封装的，后期完善后再更新上来。

2.初始化聊天界面，sessionId为会话Id，对接后台时需要传递，这里在做时间5分钟间隔的时候用到了。chatType为会话类型，区分群聊和单聊。群聊和单聊界面相似，后期会更新上来。

```Objective-C
SSChatController *vc = [SSChatController new];
vc.chatType = (SSChatConversationType)[_datas[indexPath.row][@"type"]integerValue];
vc.sessionId = _datas[indexPath.row][@"sectionId"];
vc.titleString = _datas[indexPath.row][@"title"];
[self.navigationController pushViewController:vc animated:YES];

```



