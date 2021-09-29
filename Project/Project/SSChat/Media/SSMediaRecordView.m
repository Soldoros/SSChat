//
//  SSMediaRecordView.m
//  Project
//
//  Created by soldoros on 2021/9/22.
//

#import "SSMediaRecordView.h"

@implementation SSMediaRecordView

-(instancetype)init{
    if(self = [super init]){
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];

        _mBackView = [[UIView alloc] init];
        _mBackView.bounds = makeRect(0, 0, self.width*0.4, self.width*0.4);
        _mBackView.centerX = self.width * 0.5;
        _mBackView.centerY = self.height * 0.5;
        _mBackView.backgroundColor = makeColorRgbAlpha(0, 0, 0, 0.6);
        _mBackView.layer.cornerRadius = 5;
        [_mBackView.layer setMasksToBounds:YES];
        [self addSubview:_mBackView];

        _mImgView = [[UIImageView alloc] init];
        _mImgView.frame = makeRect(0, 0, _mBackView.width, _mBackView.height * 0.7);
        _mImgView.image = [UIImage imageNamed:@"record_1"];
        _mImgView.alpha = 0.8;
        _mImgView.contentMode = UIViewContentModeCenter;
        [_mBackView addSubview:_mImgView];

        _mLabel = [[UILabel alloc] init];
        _mLabel.frame = makeRect(0, 0, _mBackView.width, 30);
        _mLabel.bottom = _mBackView.height;
        _mLabel.font = [UIFont systemFontOfSize:14];
        _mLabel.textColor = [UIColor whiteColor];
        _mLabel.textAlignment = NSTextAlignmentCenter;
        _mLabel.layer.cornerRadius = 5;
        [_mLabel.layer setMasksToBounds:YES];
        [_mBackView addSubview:_mLabel];
        _mLabel.text = @"上滑取消录音";
        
    }
    return self;
}

-(void)setPower:(NSInteger)power{
    _power = power;
    
    cout(@(_power));
    NSString *imageName = [self getRecordImage:power];
    _mImgView.image = [UIImage imageNamed:imageName];
}

- (NSString *)getRecordImage:(NSInteger)power{
    power = power + 60;
    int index = 0;
    if (power < 25){
        index = 1;
    } else{
        index = ceil((power - 25) / 5.0) + 1;
    }

    return [NSString stringWithFormat:@"record_%d", index];
}

@end
