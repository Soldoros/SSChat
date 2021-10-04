//
//  SSChatTextCell.h
//  Project
//
//  Created by soldoros on 2021/9/29.
//

#import "SSChatBaseCell.h"


NS_ASSUME_NONNULL_BEGIN

@interface SSChatTextCell : SSChatBaseCell

@property(nonatomic,strong)UIButton *mHeaderBtn;
@property(nonatomic,strong)UIButton *mBackImgBtn;
@property(nonatomic,strong)UITextView *mTextView;

@end

NS_ASSUME_NONNULL_END
