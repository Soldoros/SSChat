<div align=center> 
  <h1>一个比较通用的聊天界面 SSChat</h1> 
</div>
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
//视图归位
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

```
