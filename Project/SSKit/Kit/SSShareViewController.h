//
//  SSShareViewController.h
//  Petun
//
//  Created by soldoros on 2019/11/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "BaseViewController.h"

@protocol  SSShareViewDelegate <NSObject>

-(void)SSShareViewBtnClick:(UIButton *)sender;

@end



//分享弹窗
#define SSShareViewH  220

@interface SSShareView : UIView

@property(nonatomic,assign)id<SSShareViewDelegate>delegate;

@property(nonatomic,strong)UIView *mBackView;

@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UIView *mLine;
@property(nonatomic,strong)UIButton *mButton;


@end



//分享控制器
typedef void (^ShareViewControllerBlock)(UIButton *sender);


@interface SSShareViewController : BaseViewController

@property(nonatomic,copy)ShareViewControllerBlock shareViewBlock;

@property(nonatomic,strong)NSString *urlString;

@property(nonatomic,strong)SSShareView *shareView;
@property(nonatomic,strong)UIView *backView;
-(void)setViewAnimation;

@end



