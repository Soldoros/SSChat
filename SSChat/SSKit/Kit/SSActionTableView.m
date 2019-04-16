//
//  SSActionTableView.m
//  htcm
//
//  Created by soldoros on 2018/4/28.
//  Copyright © 2018年 soldoros. All rights reserved.
//


//弹窗多选列表
#import "SSActionTableView.h"



//弹窗多选列表cell
@implementation SSActionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor grayColor];
        self.textLabel.font = makeFont(14);
        
        _mRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mRightBtn.bounds = makeRect(0, 0, 18, 18);
        [self.contentView addSubview:_mRightBtn];
        _mRightBtn.right =  SSActionTableW - 15;
        _mRightBtn.centerY = SSActionCellH * 0.5;
        [_mRightBtn setImage:[UIImage imageNamed:@"fuxuan_weixuanzhong"] forState:UIControlStateNormal];
        [_mRightBtn setImage:[UIImage imageNamed:@"fuxuan_xuanzhong"] forState:UIControlStateSelected];
        _mRightBtn.selected = NO;
        [_mRightBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)setBtnSelected:(BOOL)btnSelected{
    _btnSelected = btnSelected;
    _mRightBtn.selected = _btnSelected;
}

//优惠券1  退款原因2  取消订单3
-(void)setDataStyle:(NSInteger)dataStyle{
    if(dataStyle==1){
        if(self.indexPath.row==0){
            self.textLabel.text = @"满100减10";
        }else if (self.indexPath.row==1){
            self.textLabel.text = @"满50减2";
        }else{
            self.textLabel.text = @"不使用";
        }
    }else if (dataStyle==2){
        if(self.indexPath.row==0){
            self.textLabel.text = @"太贵了";
        }else if (self.indexPath.row==1){
            self.textLabel.text = @"点错了";
        }else{
            self.textLabel.text = @"没时间去";
        }
    }else{
        if(self.indexPath.row==0){
            self.textLabel.text = @"我不想买";
        }else if (self.indexPath.row==1){
            self.textLabel.text = @"信息填错了";
        }else{
            self.textLabel.text = @"其他原因";
        }
    }
}

-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSActionCellBtnClick:)]){
        [_delegate SSActionCellBtnClick:sender];
    }
}


@end


//弹窗多选列表
@implementation SSActionTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        
        //默认是优惠券
        _dataStyle = 1;
        
        _mTitleLab = [UILabel new];
        _mTitleLab.frame = makeRect(15, 0, SSActionTableW-30, 50);
        [self addSubview:_mTitleLab];
        _mTitleLab.text = @"请选择优惠券";
        _mTitleLab.textAlignment = NSTextAlignmentCenter;
        _mTitleLab.textColor = makeColorHex(@"333333");
        _mTitleLab.font = makeBlodFont(14);
        
        
        UIView *line = [[UIView alloc]initWithFrame:makeRect(0, _mTitleLab.bottom-0.5, SSActionTableW, 0.5)];
        line.backgroundColor = CellLineColor;
        [self addSubview:line];
        
        
        //返回按钮
        _mBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mBackBtn.bounds = makeRect(0, 0, self.width * 0.5, 45);
        _mBackBtn.left = 0;
        _mBackBtn.bottom = self.height;
        [self addSubview:_mBackBtn];
        _mBackBtn.tag = 10;
        _mBackBtn.titleLabel.font = makeFont(14);
        [_mBackBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_mBackBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mBackBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //确认
        _mOKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mOKBtn.bounds = makeRect(0, 0, self.width * 0.5, 45);
        _mOKBtn.left = _mBackBtn.right;
        _mOKBtn.bottom = self.height;
        [self addSubview:_mOKBtn];
        _mOKBtn.tag = 11;
        _mOKBtn.titleLabel.font = makeBlodFont(14);
        [_mOKBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_mOKBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mOKBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //两个按钮之间的分割线
        UIView *line2 = [[UIView alloc]init];
        line2.bounds = makeRect(0, 0, 0.5, 45);
        line2.centerX = self.width * 0.5;
        line2.bottom = self.height;
        line2.backgroundColor = CellLineColor;
        [self addSubview:line2];
        
        
        _mTableView =  [[UITableView alloc]initWithFrame:makeRect(0, 50, self.width, self.height-95) style:UITableViewStylePlain];
        _mTableView.top = 50;
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.rowHeight =  SSActionCellH;
        _mTableView.backgroundView.backgroundColor = [UIColor whiteColor];
        _mTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_mTableView];

        [_mTableView registerClass:@"SSActionCell" andCellId:SSActionCellId];
        
    }
    return self;
}

-(void)setDataStyle:(NSInteger)dataStyle{
    _dataStyle = dataStyle;
    [_mTableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSActionCell *cell = [tableView dequeueReusableCellWithIdentifier:SSActionCellId];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.dataStyle = _dataStyle;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for(int i=0;i<3;++i){
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        SSActionCell *cell = [tableView cellForRowAtIndexPath:ip];
        if(cell.mRightBtn.selected){
            cell.mRightBtn.selected = NO;
            break;
        }
    }
    SSActionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.mRightBtn.selected = !cell.mRightBtn.selected;
    
}

#pragma SSActionCellDelegate cell右侧按钮点击回调
-(void)SSActionCellBtnClick:(UIButton *)sender{
    for(int i=0;i<3;++i){
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        SSActionCell *cell = [_mTableView cellForRowAtIndexPath:ip];
        if(cell.mRightBtn.selected){
            cell.mRightBtn.selected = NO;
            break;
        }
    }
    sender.selected = !sender.selected;
}

//取消10  确认11
-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSActionTableViewBtnClick:)]){
        [_delegate SSActionTableViewBtnClick:sender.tag];
    }
}





@end
