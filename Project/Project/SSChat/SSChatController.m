//
//  SSChatController.m
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "SSChatController.h"
#import "SSInputController.h"
#import "SSChatMessageController.h"
#import "SSChatMessage.h"

@interface SSChatController ()<SSInputControllerDelegate>

//消息列表部分
@property(nonatomic,strong)SSChatMessageController *mMessageController;
//多媒体键盘部分
@property(nonatomic,strong)SSInputController *mInputController;

@end

@implementation SSChatController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavgationBarColorImg:[UIColor clearColor]];
}

//录音底部按钮响应延迟 需要做这个处理
- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return UIRectEdgeBottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"我爱罗"];
    //录音底部按钮左右响应时间不一致 需要做这个处理
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
    
    //导航栏增加毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
    effe.frame = self.navtionBar.bounds;
    effe.height -= 1;
    [self.navtionBar insertSubview:effe atIndex:0];
    
    //消息输入框
    _mInputController = [SSInputController new];
    _mInputController.viewFrame = CGRectMake(0, self.view.height - SSInputViewHeight - SafeAreaBottom_Height, self.view.width, SSInputViewHeight + SafeAreaBottom_Height);
    _mInputController.delegate = self;
    [self addChildViewController:_mInputController];
    [self.view insertSubview:_mInputController.view atIndex:0];
    
    
    //消息列表
    _mMessageController = [SSChatMessageController new];
    _mMessageController.viewFrame = CGRectMake(0, SafeAreaTop_Height, self.view.width, MainViewRoot_Height);
    [self addChildViewController:_mMessageController];
    [self.view addSubview:_mMessageController.view];
    
}


//height应有的总高度
- (void)inputController:(SSInputController *)inputController didChangeHeight:(CGFloat)height{
    
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

        CGRect msgFrame = wself.mMessageController.view.frame;
        msgFrame.size.height = wself.view.height - SafeAreaTop_Height - height;
        wself.mMessageController.viewFrame = msgFrame;
        
        CGRect inputFrame = wself.mInputController.view.frame;
        inputFrame.origin.y = msgFrame.origin.y + msgFrame.size.height;
        inputFrame.size.height = height;
        wself.mInputController.view.frame = inputFrame;
        
    } completion:nil];
}


//发送消息回调
-(void)inputController:(SSInputController *)inputController didSendMessage:(SSChatMessage *)message{
    
    [_mMessageController sendMessage:message];
}


@end
