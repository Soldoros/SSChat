//
//  SSInputController.h
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "BaseViewController.h"
#import "SSInputView.h"
#import "SSInputMoreView.h"
#import "SSInputFaceView.h"
@class SSInputController;


//无状态 输入 表情 更多 语音
typedef NS_ENUM(NSUInteger, SSInputStatus) {
    SSInputStatusDefault = 1,
    SSInputStatusInput = 2,
    SSInputStatusFace = 3,
    SSInputStatusMore = 4,
    SSInputStatusTalk = 5,
};


@protocol SSInputControllerDelegate <NSObject>

//当前输入框高度改变时的回调。
- (void)inputController:(SSInputController *)inputController didChangeHeight:(CGFloat)height;

//点击更多弹窗里面的按钮回调
- (void)inputController:(SSInputController *)inputController didSelect:(NSDictionary *)dic;

//发送消息回调
- (void)inputController:(SSInputController *)inputController didSendMessage:(NSDictionary *)message;

//有 @ 字符输入回调
- (void)inputControllerDidInputAt:(SSInputController *)inputController;
 
@end


@interface SSInputController : BaseViewController


@property(nonatomic,weak)id<SSInputControllerDelegate>delegate;

//当前输入框的状态
@property(nonatomic,  assign) SSInputStatus mStatus;
//输入条
@property (nonatomic, strong) SSInputView *mInpuView;
//加号窗口
@property (nonatomic, strong) SSInputMoreView *mMoreView;
//表情窗口
@property (nonatomic, strong) SSInputFaceView *mFaceView;

@end


