//
//  SSSearchBar.m
//  haixian
//
//  Created by soldoros on 2017/10/16.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSSearchBar.h"

@implementation SSSearchBar



- (CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}


- (instancetype)initWithFrame:(CGRect)frame isRoot:(BOOL)root
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        _isRoot = root;
        
        _mSearchBar = [[UISearchBar alloc]init];
        [self addSubview:_mSearchBar];
        _mSearchBar.clipsToBounds = YES;
        _mSearchBar.layer.cornerRadius = 6;
        [_mSearchBar setReturnKeyType:UIReturnKeyDone];
        _mSearchBar.delegate = self;
        [_mSearchBar changeLeftPlaceholder:@"生鲜水产"];
        _mSearchBar.showsCancelButton = NO;
        _mSearchBar.enablesReturnKeyAutomatically = NO;
        _mSearchBar.barTintColor = [UIColor clearColor];
        _mSearchBar.tintColor=[UIColor blackColor];
        [[[[_mSearchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
        [_mSearchBar setBackgroundColor:[UIColor clearColor]];
        _mSearchBar.frame = CGRectMake(7, 27, self.frame.size.width-7-65-35, 30);
       
        
    }
    return self;
}

-(void)setText:(NSString *)text{
    _text = text;
    _mSearchBar.text = _text;
}

//开始搜索
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    if(_ssdelegate && [_ssdelegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [_ssdelegate searchBarTextDidBeginEditing:searchBar];
    }
}

//结束搜索
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    if(_ssdelegate && [_ssdelegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [_ssdelegate searchBarTextDidEndEditing:searchBar];
    }
}

//点击键盘的return
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self ssSearchBarIsEndEidting];
    
    if(_ssdelegate && [_ssdelegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [_ssdelegate searchBarSearchButtonClicked:searchBar];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _text = searchText;
}

-(void)ssSearchBarIsEndEidting{
    [_mSearchBar endEditing:YES];

}










@end
