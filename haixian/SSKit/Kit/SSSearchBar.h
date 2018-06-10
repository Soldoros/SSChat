//
//  SSSearchBar.h
//  haixian
//
//  Created by soldoros on 2017/10/16.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSSearchBarDelegate <NSObject>

//开始搜索
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;

//完成搜索
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;

//点击键盘的return
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end



@interface SSSearchBar : UIView<UISearchBarDelegate>

@property(nonatomic,assign)id<SSSearchBarDelegate>ssdelegate;

@property(nonatomic,strong) UISearchBar *mSearchBar;
@property(nonatomic,strong) NSString *text;

@property(nonatomic,assign) BOOL isRoot;

- (instancetype)initWithFrame:(CGRect)frame isRoot:(BOOL)root;
-(void)ssSearchBarIsEndEidting;


@end
