//
//  SSAddImgView.m
//  DEShop
//
//  Created by soldoros on 2017/5/18.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSAddImgView.h"



@implementation SSAddImgView{
    UIImageView *mImgView[100];
    UIButton *mImgBtn[100];
}

-(instancetype)init{
    if(self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.bounds = makeRect(0, 0, AddImgWidth, AddimgViewH);
        _images = [NSMutableArray new];
        _mAddImage = [SSAddImage new];

        _mAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mAddBtn.bounds = makeRect(0, 0, BtnSize, BtnSize);
        _mAddBtn.tag = 100;
        _mAddBtn.left = AddLRSpace;
        _mAddBtn.top = AddTBSpace;
        [self addSubview:_mAddBtn];
        [_mAddBtn setBackgroundImage:[UIImage imageNamed:@"addbtnimg"] forState:UIControlStateNormal];
        _mAddBtn.selected = NO;
        [_mAddBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


//图片tag从50开始
-(void)setImg:(UIImage *)img{
    [self.images addObject:img];
    NSInteger i = self.images.count-1;
    
    mImgView[i] = [UIImageView new];
    mImgView[i].frame = _mAddBtn.frame;
    mImgView[i].image = img;
    [self addSubview:mImgView[i]];
    mImgView[i].userInteractionEnabled = YES;
    
    mImgBtn[i]= [UIButton buttonWithType:UIButtonTypeCustom];
    mImgBtn[i].bounds = makeRect(0, 0, 20, 20);
    mImgBtn[i].top = 2;
    mImgBtn[i].right = mImgView[i].width-2;
    mImgBtn[i].tag = i+50;
    [mImgView[i] addSubview:mImgBtn[i]];
    mImgBtn[i].clipsToBounds = YES;
    mImgBtn[i].layer.cornerRadius = mImgBtn[i].height*0.5;
    mImgBtn[i].backgroundColor = [UIColor redColor];
    [mImgBtn[i] setTitle:@"-" forState:UIControlStateNormal];
    [mImgBtn[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mImgBtn[i] addTarget:self action:@selector(imgBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _mAddBtn.left = self.images.count%AddImgNum * (BtnSize+AddImgLRSpace)+AddLRSpace;
    _mAddBtn.top  = self.images.count/AddImgNum * (BtnSize+AddImgTBSpace)+AddTBSpace;
    
    [self setImgViwHeight];
}

//设置图片视图的高度
-(void)setImgViwHeight{
    if(self.images.count<AddImgNum-1){
        self.height = AddimgViewH ;
        self.imgheight = self.height;
        return;
    }
    //计算图片数量加上按钮后占用的行数
    NSInteger mo = (self.images.count+1)%AddImgNum==0?0:1;
    NSInteger lines = (self.images.count+1)/AddImgNum + mo;
    self.height = AddTBSpace*2+(lines-1)*AddImgTBSpace+lines*BtnSize;
    self.imgheight = self.height;
}

//图片按钮从50开始 红色的删除按钮
-(void)imgBtnPressed:(UIButton *)sender{
    NSInteger index = sender.tag-49;
    NSString *str = makeMoreStr(@"删除第",makeStrWithInt(index),@"张图片",nil);
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle:str  style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self delateImg:index];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [_mController presentViewController: alertController animated: YES completion: nil];
}

-(void)delateImg:(NSInteger)index{
    NSInteger k = self.images.count-1;
    _mAddBtn.frame = mImgView[k].frame;
    [mImgView[k] removeFromSuperview];
    [mImgBtn[k] removeFromSuperview];
    mImgBtn[k] = nil;
    mImgView[k] = nil;
    
    [_images removeObjectAtIndex:index-1];
    for(int i=0;i<_images.count;++i){
        mImgView[i].image = _images[i];
    }
    [self setImgViwHeight];
}


//添加按钮100
-(void)buttonPressed:(UIButton *)sender{
    if(self.images.count==AddImgMaxNum){
        [(BaseVirtualController *)_mController showTime:makeMoreStr(@"最多上传",makeStrWithInt(AddImgMaxNum) ,@"张图片",nil)];
        return;
    }
    
    [_mAddImage getImagePickerWithAlertController:[self getViewController] modelType:SSImagePickerModelImage pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
        
        [self setImg:(UIImage *)object];
        
    }];
    
}













@end
