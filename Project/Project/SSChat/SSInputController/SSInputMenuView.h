//
//  SSInputMenuView.h
//  Project
//
//  Created by soldoros on 2021/9/16.
//

#import <UIKit/UIKit.h>

#define SSInputMenuViewH   45

@protocol SSInputMenuViewDelegate <NSObject>

//点击按钮回调
- (void)inputMenuViewButtonClick:(UIButton *)sender;

@end

@interface SSInputMenuView : UIView

@property(nonatomic,weak)id<SSInputMenuViewDelegate>delegate;

@property(nonatomic,strong)UIButton *mSendBtn;
@property(nonatomic,strong)UIButton *mDeleteBtn;
@property(nonatomic,strong)UIButton *mFaceBtn;

@property(nonatomic,strong)NSString *faceString;

@end


