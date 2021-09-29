//
//  SSAddImgView.m
//  DEShop
//
//  Created by soldoros on 2017/5/18.
//  Copyright © 2017年 soldoros. All rights reserved.
//



#import "SSAddImgView.h"
#import "AssetGridVC.h"


#define   max   9

@implementation SSAddImgView{
    UIImageView *mImgView[max];
    UIButton *mDelBtn[max];
    UILabel *mSecLab[max];
    
    UIImageView *mBackView[max];
    UIImageView *mPlayImg[max];
    
    UIButton *mCoverbtn[max];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _maxNumber = max;
        _rowNumber = 4;
        _rowSpace = 10;
        _colSpace = 10;
        _keyword = @"resource";
        _haveCover = NO;
        _type = @"";
        _modelType = SSImageModelAll;
        _imgDatas = [NSMutableArray new];
        
        _controls = @[@"相册",@"拍摄"];
        
        
        
        _mController = [UIViewController getCurrentController];
        _size = (self.width - (_rowNumber-1)*_colSpace)/_rowNumber;
        
        for(int i=0;i<max;++i){
            
            mImgView[i] = [UIImageView new];
            [self addSubview:mImgView[i]];
            mImgView[i].bounds = makeRect(0, 0, _size, _size);
            mImgView[i].left = i%_rowNumber * (_size + _colSpace);
            mImgView[i].top = i/_rowNumber * (_size + _rowSpace);
            mImgView[i].clipsToBounds = YES;
            mImgView[i].layer.cornerRadius = 4;
            mImgView[i].backgroundColor = BackGroundColor;
            mImgView[i].userInteractionEnabled = YES;
            mImgView[i].hidden = YES;
            mImgView[i].tag = 10+i;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewClick:)];
            [mImgView[i] addGestureRecognizer: tap];
            
            
            mBackView [i] = [UIImageView new];
            mBackView[i].frame = mImgView[i].bounds;
            [mImgView[i] addSubview:mBackView[i]];
            mBackView[i].image = [UIImage imageFromColor:makeColorRgbAlpha(0, 0, 0, 0.5)];
            
            mPlayImg[i] = [UIImageView new];
            mPlayImg[i].bounds = makeRect(0, 0, 30, 30);
            mPlayImg[i].centerX = mBackView[i].width * 0.5;
            mPlayImg[i].centerY = mBackView[i].height * 0.5;
            mPlayImg[i].image = [UIImage imageNamed:@"dynamic_play"];
            [mBackView[i] addSubview:mPlayImg[i]];
            
            
            mDelBtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            [mImgView[i] addSubview:mDelBtn[i]];
            mDelBtn[i].bounds = makeRect(0, 0, 20, 20);
            mDelBtn[i].clipsToBounds = YES;
            mDelBtn[i].layer.cornerRadius = 10;
            mDelBtn[i].top = 2;
            mDelBtn[i].right = mImgView[i].width - 2;
            mDelBtn[i].backgroundColor = [UIColor redColor];
            [mDelBtn[i] setTitle:@"-" forState:UIControlStateNormal];
            mDelBtn[i].titleLabel.font = makeBlodFont(20);
            [mDelBtn[i] setTitleColor:makeColorHex(@"#FFFFFF") forState:UIControlStateNormal];
            mDelBtn[i].tag = 100+i;
            [mDelBtn[i] addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            mCoverbtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            [mImgView[i] addSubview:mCoverbtn[i]];
            mCoverbtn[i].bounds = makeRect(0, 0, mImgView[i].width, 20);
            mCoverbtn[i].bottom = mImgView[i].height;
            mCoverbtn[i].left = 0;
            mCoverbtn[i].tag = 200+i;
            mCoverbtn[i].titleLabel.font = makeFont(10);
            [mCoverbtn[i] setTitle:@"设置封面" forState:UIControlStateNormal];
            [mCoverbtn[i] setBackgroundImage:[UIImage imageFromColor:makeColorRgbAlpha(0, 0, 0, 0.4)] forState:UIControlStateNormal];
            [mCoverbtn[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mCoverbtn[i] addTarget:self action:@selector(coverBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_mButton];
        _mButton.frame = makeRect(0, 0, _size, _size);
        _mButton.clipsToBounds = YES;
        _mButton.layer.cornerRadius = 4;
        _mButton.backgroundColor = BackGroundColor;
        [_mButton setImage:[UIImage imageNamed:@"addAsset"] forState:UIControlStateNormal];
        _mButton.tag = 500;
        [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        _totalHeight = _mButton.bottom;
        self.height = _totalHeight;
    }
    return self;
}


//设置图片视图的高度  并回调
-(void)setTotalHeight:(CGFloat)totalHeight{
    _totalHeight = totalHeight;
    self.height = _totalHeight;
}


//每行放置多少张图片
-(void)setRowNumber:(NSInteger)rowNumber{
    _rowNumber = rowNumber;
    [self refreshLayout];
}

//设置列间距
-(void)setColSpace:(CGFloat)colSpace{
    _colSpace = colSpace;
    [self refreshLayout];
}

//设置行间距
-(void)setRowSpace:(CGFloat)rowSpace{
    _rowSpace = rowSpace;
    [self refreshLayout];
}

//刷新布局
-(void)refreshLayout{
    
    _size = (self.width - (_rowNumber-1)*_colSpace)/_rowNumber;
    
    for(int i=0;i<_maxNumber;++i){
        mImgView[i].bounds = makeRect(0, 0, _size, _size);
        mImgView[i].left = i%_rowNumber * (_size + _colSpace);
        mImgView[i].top = i/_rowNumber * (_size + _rowSpace);
        
        mDelBtn[i].top = 2;
        mDelBtn[i].right = mImgView[i].width - 2;
        
        mBackView[i].frame = mImgView[i].bounds;
        mPlayImg[i].centerX = mBackView[i].width * 0.5;
        mPlayImg[i].centerY = mBackView[i].height * 0.5;
        
        mCoverbtn[i].bounds = makeRect(0, 0, mImgView[i].width, 20);
        mCoverbtn[i].bottom = mImgView[i].height;
        mCoverbtn[i].left = 0;
    }
    _mButton.frame = makeRect(0, 0, _size, _size);
    self.totalHeight = _mButton.bottom;
}


//设置数据和回调
-(void)setImgBlock:(SSAddImgViewBlock)imgBlock clickBlock:(SSAddImgClickBlock)clickBlock{
    self.imgBlock = imgBlock;
    self.clickBlock = clickBlock;
    
}

//设置数据
-(void)setImgDatas:(NSMutableArray *)imgDatas{
    
    if(_imgDatas.count<imgDatas.count){
        [_imgDatas removeAllObjects];
        [_imgDatas addObjectsFromArray:imgDatas];
        [self updateUserInterface];
    }
}


//刷新界面
-(void)updateUserInterface{
    
    for(int i=0;i<_maxNumber;++i){
        mImgView[i].hidden = YES;
    }
    _mButton.frame = mImgView[0].frame;
    _mButton.hidden = NO;
    
    for(int i=0;i<_imgDatas.count;++i){
        NSDictionary *imgDic = _imgDatas[i];
        
        if([imgDic[@"type"]integerValue] == SSImageModelVideo){
            
            NSString *imgString = imgDic[_keyword];
            mImgView[i].hidden = NO;
            [mImgView[i] setImageURL:[NSURL URLWithString:imgString]];
            
            mBackView[i].hidden = NO;
            mCoverbtn[i].hidden = YES;
        }
        else{
            
            NSString *imgString = imgDic[_keyword];
            mImgView[i].hidden = NO;
            [mImgView[i] setImageURL:[NSURL URLWithString:imgString]];
            
            mBackView[i].hidden = YES;
            mCoverbtn[i].hidden = YES;
            
            if(_haveCover == YES){
                
                mCoverbtn[i].hidden = NO;
                if([imgDic[@"choice"]integerValue] == 1){
                    [mCoverbtn[i] setTitle:@"封面" forState:UIControlStateNormal];
                    [mCoverbtn[i] setBackgroundImage:[UIImage imageFromColor:TitleColor] forState:UIControlStateNormal];
                    [mCoverbtn[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                else{
                    [mCoverbtn[i] setTitle:@"设置封面" forState:UIControlStateNormal];
                    [mCoverbtn[i] setBackgroundImage:[UIImage imageFromColor:makeColorRgbAlpha(0, 0, 0, 0.4)] forState:UIControlStateNormal];
                    [mCoverbtn[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
        
        if(i!=_maxNumber-1){
            _mButton.hidden = NO;
            _mButton.frame = mImgView[i+1].frame;
        }
        else{
            _mButton.hidden = YES;
        }
    }
    
    self.totalHeight = _mButton.bottom;
    self.imgBlock(self.imgDatas, self.totalHeight);
}


//点击图片10+
-(void)pickerViewClick:(UITapGestureRecognizer *)sender{
    
    UIImageView *imgView = (UIImageView *)sender.view;
    self.clickBlock(_imgDatas, imgView);
}

//设置封面200+
-(void)coverBtnPressed:(UIButton *)sender{
    
    for(int i=0;i<self.imgDatas.count;++i){
        NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:self.imgDatas[i]];
        [dd setValue:@"0" forKey:@"choice"];
        if((sender.tag - 200 )  == i){
            [dd setValue:@"1" forKey:@"choice"];
        }
        self.imgDatas[i] = dd;
    }
    
    [self updateUserInterface];
}

//删除图片 100+
-(void)deleteBtnPressed:(UIButton *)sender{
    
    NSInteger index = sender.tag-99;
    NSString *str = [NSString stringWithFormat:@"%@%ld%@",@"删除第",(long)index,@"张图片"];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil  message: nil  preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle:str  style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //有封面&&删除了封面图&&还有图 就设置剩余第一张为封面
        if(self.haveCover == YES && [self.imgDatas[index-1][@"choice"] isEqual:@"1"] && self.imgDatas.count>1){
            [self.imgDatas removeObjectAtIndex:index-1];
            [self coverBtnPressed:self->mCoverbtn[0]];
        }
        else{
            [self.imgDatas removeObjectAtIndex:index-1];
            [self updateUserInterface];
        }
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    [_mController presentViewController: alertController animated: YES completion: nil];
}


//添加按钮1000
-(void)buttonPressed:(UIButton *)sender{
    
    
    NSArray *arr = @[@"相册",@"拍摄"];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil   message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for(int i=0;i<arr.count;++i){
        UIAlertAction *action = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //相册
            if([action.title isEqualToString:@"相册"]){
                if(self.modelType == SSImageModelImage || self.modelType == SSImageModelGif){
                    [self meitku:2];
                }
                if(self.modelType == SSImageModelVideo){
                    [self meitku:3];
                }
                if(self.modelType == SSImageModelAll){
                    [self meitku:1];
                }
            }
            
            //拍摄
            if([action.title isEqualToString:@"拍摄"]){
                [self paishe];
            }
            
        }];
        
        [alertController addAction:action];
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [[UIViewController getCurrentController] presentViewController: alertController animated: YES completion: nil];
    
}

//相册
-(void)meitku:(NSInteger)index{
    
    AssetGridVC *vc = [AssetGridVC new];
    vc.type = index;
    vc.videoTime = @"10";
    vc.maxNumer = self.maxNumber;
    vc.imageBlock = ^(NSArray *imageArr) {
        [self headerImgNetWorking:imageArr index:0];
    };
    
    vc.videoBlock = ^(NSString *path) {
        
        [self videoNetWorking:path];
    };
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [[UIViewController getCurrentController] presentViewController:nav animated:YES completion:nil];
    
}


//拍摄
-(void)paishe{
    
    if(!_mAddImage){
        _mAddImage = [SSAddImage new];
    }
    
    [_mAddImage getImgWithModelType:_modelType pickerBlock:^(SSImageModelType modelType, id object) {
        
        NSData *data = [NSData dataWithContentsOfFile:(NSString *)object];
           
        //图片
        if(modelType == SSImageModelImage ||
           modelType == SSImageModelGif){
            UIImage *img = [UIImage imageWithData:data];
            [self headerImgNetWorking:@[img] index:0];
        }
        //视频
        if(modelType == SSImageModelVideo){
            
            [self videoNetWorking:(NSString *)object];
        }
    }];
    
}


//上传图片1
-(void)headerImgNetWorking:(NSArray *)images index:(NSInteger)index{
    
    UIImage *image = images[index];
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
     
    NSString *url = makeString(URLContentString, @"");
      NSDictionary *dic = @{@"key":_type};
      
    __weak typeof(self) weakSelf = self;
    [_mButton addActivityOnBtn:makeColorHex(@"#666666") scale:0.85];
    
    [SSAFRequest PostWithFile:dic method:url imgData:data name:@"file" requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
          
          
          if(error){
              [self.imgDatas removeAllObjects];
              [self showTime:error.description];
              dispatch_async(dispatch_get_main_queue(), ^{
                  [weakSelf.mButton closeActivityByBtnImg:@"addAsset"];
              });
          }else{
              NSDictionary *dd = makeDicWithJsonStr(object);
              cout(dd);
              if([dd[@"code"]integerValue] != 1){
                  [self.imgDatas removeAllObjects];
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [weakSelf.mButton closeActivityByBtnImg:@"addAsset"];
                  });
                  if([dd[@"code"]integerValue] == 1001){
                      [self sendNotifCation:NotiLoginStatusChange data:@(NO)];
                  }
                  else{
                      [self showTime:dd[@"msg"]];
                  }
              }else{
                  
                  NSMutableDictionary *ddd = [NSMutableDictionary new];
                  [ddd setValuesForKeysWithDictionary:dd[@"data"][self.type][@"origin"]];
                  [ddd setValue:@(SSImageModelImage) forKey:@"type"];
                  
                  if(self.haveCover == YES){
                      if(self.imgDatas.count == 0){
                          [ddd setValue:@"1" forKey:@"choice"];
                      }else{
                          [ddd setValue:@"0" forKey:@"choice"];
                      }
                  }
                  
                  [self.imgDatas addObject:ddd];
                  
                  if(index<images.count-1){
                      [self headerImgNetWorking:images index:index+1];
                  }
                  else{
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [weakSelf.mButton closeActivityByBtnImg:@"addAsset"];
                          [self updateUserInterface];
                      });
                  }
                  
               }
           }
       }];
}


//上传视频2
-(void)videoNetWorking:(NSString *)filePath{
    
    NSData *data = [NSData dataWithContentsOfFile:(NSString *)filePath];
     
    NSString *url = makeString(URLContentString, @"");
      NSDictionary *dic = @{@"key":_type};
      
    __weak typeof(self) weakSelf = self;
    [_mButton addActivityOnBtn:makeColorHex(@"#666666") scale:0.85];
    
    [SSAFRequest PostWithFile:dic method:url imgData:data name:@"file" requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
          
          
          if(error){
              [self.imgDatas removeAllObjects];
              [self showTime:error.description];
              dispatch_async(dispatch_get_main_queue(), ^{
                  [weakSelf.mButton closeActivityByBtnImg:@"addAsset"];
              });
          }else{
              NSDictionary *dd = makeDicWithJsonStr(object);
              cout(dd);
              
              if([dd[@"code"]integerValue] != 1){
                  [self.imgDatas removeAllObjects];
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [weakSelf.mButton closeActivityByBtnImg:@"addAsset"];
                  });
                  if([dd[@"code"]integerValue] == 1001){
                      [self sendNotifCation:NotiLoginStatusChange data:@(NO)];
                  }
                  else{
                      [self showTime:dd[@"msg"]];
                  }
              }else{
                  
                  NSMutableDictionary *ddd = [NSMutableDictionary new];
                  [ddd setValuesForKeysWithDictionary:dd[@"data"][self.type][@"origin"]];
                  [ddd setValue:@(SSImageModelImage) forKey:@"type"];
                  
                  if(self.haveCover == YES){
                      if(self.imgDatas.count == 0){
                          [ddd setValue:@"1" forKey:@"choice"];
                      }else{
                          [ddd setValue:@"0" forKey:@"choice"];
                      }
                  }
                  
                  [self.imgDatas addObject:ddd];
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [weakSelf.mButton closeActivityByBtnImg:@"addAsset"];
                      [self updateUserInterface];
                  });
                  
               }
           }
       }];
    
}



@end

