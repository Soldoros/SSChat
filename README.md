<div align=center> 
  <h1>一个比较通用的聊天界面 SSChat</h1> 
</div>
<br>
<h4>SSChat参考目前比较主流的聊天系统做的布局，整体功能是比较通用的。每个模块都支持高度自定义，包括聊天气泡、头像、多媒体键盘的Emotion、键盘的功能拓展等，更新都挺方便。值得注意的是目前短视频播放采用的AVPlayerLayer不能在模拟器打开，大家可以用真机运行，后期更新后再行通知。SSChat的图片短视频缩放，键盘模块，消息数据模块和布局模块都单独封装，可以单独使用，也可以直接使用SSChat来对接环信或其他IM接口！</h4>
<br>
<div align=center> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/1.PNG" width="345"> 
  <img src= "https://raw.githubusercontent.com/Soldoros/SSChat/master/datu/4.PNG" width="345">
</div>


<h2>一、键盘的使用</h2>

1.将 SSChatKeyBoard 文件夹拖入到工程

2.plist文件需要设置权限 访问相机 麦克风 相册

3.在需要用键盘的控制器引用头文件 #import "SSChatKeyBoardInputView.h" 并设置代理 SSChatKeyBoardInputViewDelegate

4.声明对象

```Objective-C
//底部输入框 携带表情视图和多功能视图
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
//键盘和列表视图归位
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

```
7.在键盘的回调方法中，改变输入框高度和键盘位置的方法回调中，需要处理当前表单的frame，具体frame调整需要针对界面的布局来定，这里只对UITableView和它的父视图做个简单调整。

```Objective-C
#pragma SSChatKeyBoardInputViewDelegate 底部输入框代理回调
//点击按钮视图frame发生变化 调整当前列表frame
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
8.其它功能根据需求而定

```Objective-C
//发送文本信息
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string;

//发送语音消息
- (void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view sendVoice:(NSData *)voice time:(NSInteger)second;

//多功能视图按钮点击回调
-(void)SSChatKeyBoardInputViewBtnClickFunction:(NSInteger)index;
```


