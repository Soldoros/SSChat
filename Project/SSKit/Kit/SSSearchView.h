//
//  SSSearchView.h
//  YongHui
//
//  Created by soldoros on 2019/10/12.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
设置搜索框的功能

- SSSearchButton: 点击
- SSSearchButton: 搜索
*/
typedef NS_ENUM(NSInteger, SSSearchViewType) {
    SSSearchButton = 1,
    SSSearchTextField ,
};


typedef void (^SSSearchViewSendBlock)(NSString *string);


@interface SSSearchView : UIView<UITextFieldDelegate>

@property(nonatomic,assign)SSSearchViewType searchType;

@property(nonatomic,copy)SSSearchViewSendBlock handle;

@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIImageView *mSearchImg;
@property(nonatomic,strong)UITextField *searchField;

@property(nonatomic,strong)NSString *searchString;

@end


