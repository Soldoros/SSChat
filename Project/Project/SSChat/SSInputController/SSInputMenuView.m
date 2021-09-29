//
//  SSInputMenuView.m
//  Project
//
//  Created by soldoros on 2021/9/16.
//

//表情弹窗分类视图
#import "SSInputMenuView.h"


@implementation SSInputMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        
        _mSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mSendBtn .frame = CGRectMake(SCREEN_Width-85, 2.5, 70, 35);
        _mSendBtn.centerY = self.height * 0.5;
        _mSendBtn.tag = 50;
        _mSendBtn.layer.cornerRadius = 4;
        [_mSendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _mSendBtn.backgroundColor = [UIColor whiteColor];
        _mSendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_mSendBtn setTitleColor:makeColorHex(@"#999999") forState:UIControlStateNormal];
        [_mSendBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mSendBtn];
        
        
        UIImage *img = [UIImage imageNamed:@"DeleteEmoticonBtn"];
        UIImage *img2 = [UIImage imageNamed:@"DeleteEmoticonBtnHL"];
        _mDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mDeleteBtn.frame = CGRectMake(0, 2.5, 40, 35);
        _mDeleteBtn.backgroundColor = [UIColor whiteColor];
        _mDeleteBtn.right = _mSendBtn.left - 10;
        _mDeleteBtn.centerY = self.height * 0.5;
        _mDeleteBtn.tag = 51;
        _mDeleteBtn.layer.cornerRadius = 4;
        [_mDeleteBtn setImage:img forState:UIControlStateNormal];
        [_mDeleteBtn setImage:img2 forState:UIControlStateHighlighted];
        [_mDeleteBtn addTarget:self action:@selector(buttonPressed:)  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mDeleteBtn];
        
        
        _mFaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mFaceBtn.tag = 100;
        [self addSubview:_mFaceBtn];
        _mFaceBtn.frame = makeRect(10, 0, 40, 35);
        _mFaceBtn.centerY = self.height * 0.5;
        _mFaceBtn.layer.cornerRadius = 4;
        _mFaceBtn.backgroundColor = [UIColor whiteColor];
        [_mFaceBtn addTarget:self action:@selector(buttonPressed:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//发送50 删除51  标签分类100+
-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(inputMenuViewButtonClick:)]){
        [_delegate inputMenuViewButtonClick:sender];
    }
}

-(void)setFaceString:(NSString *)faceString{
    _faceString = faceString;
    
    [_mFaceBtn setTitle:_faceString forState:UIControlStateNormal];
}

@end
