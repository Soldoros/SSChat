//
//  SSShareViewController.m
//  Petun
//
//  Created by soldoros on 2019/11/8.
//  Copyright © 2019 soldoros. All rights reserved.
//


//从底部弹起分享按钮
#import "SSShareViewController.h"

#define shareUrl   @"https://grant.petun.com/appTo.html"

//分享弹窗
@implementation SSShareView{
    UIButton *mButton[4];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        
        _mBackView = [UIView new];
        _mBackView.frame = makeRect(0, 0, SCREEN_Width, SSShareViewH + 6 + SafeAreaBottom_Height);
        _mBackView.clipsToBounds = YES;
        _mBackView.layer.cornerRadius = 12;
        _mBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_mBackView];
        
        
      _mTitleLab = [UILabel new];
      _mTitleLab.bounds = makeRect(0, 0, 200, 20);
      _mTitleLab.textColor = makeColorHex(@"#333333");
      [_mBackView addSubview:_mTitleLab];
      _mTitleLab.textAlignment = NSTextAlignmentLeft;
      _mTitleLab.font = [UIFont boldSystemFontOfSize:16];
        _mTitleLab.text = @"分享到";
        [_mTitleLab sizeToFit];
        _mTitleLab.centerX = SCREEN_Width * 0.5;
        _mTitleLab.top = 23;
          
        
     NSArray *imgs = @[@"weixin",@"pengyouquan",@"qqShare",@"weibo"];
          NSArray *titles = @[@"微信好友",@"朋友圈",@"QQ好友",@"微博"];
      for(int i=0;i<2;++i){
          
          mButton[i] = [UIButton buttonWithType:UIButtonTypeCustom];
          mButton[i].bounds = makeRect(0, 0, _mBackView.width/2, 80);
          mButton[i].left = i*mButton[i].width;
          mButton[i].top = 70;
          [mButton[i] setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
          mButton[i].tag = 10+i;
          [mButton[i] setTitle:titles[i] forState:UIControlStateNormal];
          [mButton[i] setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
          mButton[i].titleLabel.font = [UIFont systemFontOfSize:11];
          [_mBackView addSubview:mButton[i]];
          mButton[i].tag = i + 10;
          [mButton[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
          [mButton[i] setBtnCenterHeight:18 distTance:0];
      }
        
      
        _mLine = [UIView new];
        _mLine.bounds = makeRect(0, 0, SCREEN_Width, 1);
        _mLine.bottom = _mBackView.height - 56 - SafeAreaBottom_Height;
        _mLine.left = 0;
        _mLine.backgroundColor = BackGroundColor;
        [self addSubview:_mLine];
        
        
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mButton.bounds = makeRect(0, 0, SCREEN_Width, 50);
        _mButton.top = _mLine.bottom;
        _mButton.left = 0;
        _mButton.tag = 50;
        [_mBackView addSubview:_mButton];
        [_mButton setTitle:@"取消" forState:UIControlStateNormal];
        _mButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_mButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//微信10 朋友圈11  qq12  微博13  取消50
-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSShareViewBtnClick:)]){
        [_delegate SSShareViewBtnClick:sender];
    }
}


@end



//分享控制器
@interface SSShareViewController ()<SSShareViewDelegate>


@end

@implementation SSShareViewController

-(instancetype)init{
    if(self = [super init]){

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _backView = [[UIView alloc]initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.01;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
    [_backView addGestureRecognizer: tap];
    
    
    _shareView = [[SSShareView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SSShareViewH)];
    _shareView.top = SCREEN_Height;
    _shareView.centerX = SCREEN_Width*0.5;
    _shareView.delegate = self;
    
    
    [self.view addSubview:_backView];
    [self.view addSubview:_shareView];
    
}

-(void)setViewAnimation{
    
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.5;
        self.shareView.bottom = SCREEN_Height - SafeAreaBottom_Height;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    
}


-(void)viewClick{
    
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.shareView.top = SCREEN_Height;
        self.backView.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        [self.shareView removeFromSuperview];
        [self.backView removeFromSuperview];
        self.backView = nil;
        self.shareView = nil;
         [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

//取消50  @[@"微信好友",@"朋友圈",@"QQ好友",@"微博"];
-(void)SSShareViewBtnClick:(UIButton *)sender{

    [self viewClick];
   
   NSInteger index = sender.tag - 10;
    
     //分享APP
    UIImage *img = [UIImage imageNamed:@"Logo"];
    NSString *title = @"一锤定音";
    NSString *detail = @"一锤定音提供各种在线古玩展示与购买，欢迎访问";
//    _urlString = @"http://www.baidu.com";
     NSString *new_url=[_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
     
     
     switch (index) {
         case 0:{
             
             cout(@"分享到微信");
             
             
         }
             break;
             
         case 1:{
             
             
         }
             break;
         case 2:{
             
             
         }
             break;
         case 3:{
             
             
         }
             break;
           
         case 4:{
             
             UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
             pasteboard.string = new_url;
            [[AppDelegate sharedAppDelegate].window showTime:@"链接已复制"];
         }
             break;
         case 50:
             break;
             
         default:
             break;
     }
}



@end
