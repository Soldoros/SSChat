//
//  SSMediaRecordView.h
//  Project
//
//  Created by soldoros on 2021/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSMediaRecordView : UIView

//背景
@property (nonatomic, strong) UIView *mBackView;
//图标
@property (nonatomic, strong) UIImageView *mImgView;
//提示信息
@property(nonatomic,strong)UILabel *mLabel;

//声音大小
@property(nonatomic,assign)NSInteger power;


@end

NS_ASSUME_NONNULL_END
