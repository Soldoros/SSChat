//
//  AccountView.m
//  QuFound
//
//  Created by soldoros on 2020/5/14.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "AccountView.h"


//手机号登录界面的顶部视图
@implementation AccountMoblieLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _mImgView = [UIImageView new];
        _mImgView.frame = self.bounds;
        [self addSubview:_mImgView];
        _mImgView.image = [UIImage imageNamed:@"login_bg"];
        
    }
    return self;
}


-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
   
    
}


@end
