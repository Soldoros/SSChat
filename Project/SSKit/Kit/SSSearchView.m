//
//  SSSearchView.m
//  YongHui
//
//  Created by soldoros on 2019/10/12.
//  Copyright © 2019 soldoros. All rights reserved.
//


//只初始化搜索框部分 椭圆形的部分
#import "SSSearchView.h"

//CGRectMake(0, 0, SCREEN_Width-100, 32)
@implementation SSSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        _searchType = SSSearchTextField;
        
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = self.bounds;
        _searchBtn.right = SCREEN_Width - 20;
        _searchBtn.centerY = NavBar_Height * 0.5 + StatuBar_Height;
        [self addSubview:_searchBtn];
        _searchBtn.clipsToBounds = YES;
        _searchBtn.layer.cornerRadius = 4;
        [_searchBtn setBackgroundImage:[UIImage imageWithColor:makeColorHex(@"#333333")] forState:UIControlStateNormal];
        _searchBtn.showsTouchWhenHighlighted = NO;
        
        _mSearchImg = [UIImageView new];
        _mSearchImg.bounds = makeRect(0, 0, 15, 15);
        _mSearchImg.image = [[UIImage imageNamed:@"icon_sousuo"] imageWithColor:makeColorHex(@"#999999")];
        [_searchBtn addSubview:_mSearchImg];
        _mSearchImg.left = 10;
        _mSearchImg.centerY = _searchBtn.height * 0.5;
      
        _searchField = [UITextField new];
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.frame = makeRect(40, 0, _searchBtn.width - 50, _searchBtn.height);
        [_searchBtn addSubview:_searchField];
        _searchField.delegate = self;
        _searchField.font = [UIFont systemFontOfSize:14];
        _searchField.textColor = makeColorHex(@"#DDDDDD");
        _searchField.tintColor = makeColorHex(@"#999999");
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"搜索商家" attributes:@{NSForegroundColorAttributeName : makeColorHex(@"#666666")}];
        _searchField.attributedPlaceholder = placeholderString;
        [_searchField addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventEditingChanged];
    
    }
    return self;
}



-(void)textClick:(UITextField *)textField{
    _searchString = textField.text;
    
    if(self.handle){
        self.handle(_searchString);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    _searchString = textField.text;
    return YES;
}

@end
