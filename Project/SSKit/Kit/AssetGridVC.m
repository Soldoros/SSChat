//
//  AssetGridVC.m
//  SamplePhotosDemo
//
//  Created by iTruda on 2018/6/18.
//  Copyright © 2018年 iTruda. All rights reserved.
//


#import "AssetGridVC.h"
#import "GridViewCell.h"
#import <PhotosUI/PhotosUI.h>


#define SCR_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCR_HEIGHT  [[UIScreen mainScreen] bounds].size.height

@interface AssetGridVC ()<UICollectionViewDelegateFlowLayout>
{
    CGSize thumbnailSize;
    CGRect previousPreheatRect;
}

@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) PHImageRequestOptions *requestOption;

@property (nonatomic, strong) NSMutableArray *choices;
@property (nonatomic, strong) NSMutableArray *imageArr;


@end

@implementation AssetGridVC

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    if(self = [super init]){
        
        _choiceStatus = 1;
        _choiceType = @"";
        
        _type = 1;
        _videoTime = @"10";
        _maxNumer = 1;
        _imageArr = [NSMutableArray new];
        _choices = [NSMutableArray new];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    CGFloat item_WH = (SCR_WIDTH-20.f-2.f*3)/4.f;
    thumbnailSize = CGSizeMake(item_WH * scale, item_WH * scale);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateCachedAssets];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"请选择视频和图片"];
    [self setRightOneBtnTitle:@"确定"];
    
    
    
    

    self.mCollectionView.backgroundColor = [UIColor whiteColor];
    self.mCollectionView.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.mCollectionView registerClass:[GridViewCell class]  forCellWithReuseIdentifier:reuseIdentifier];
    self.mCollectionView.dataSource = self;
    [self.mCollectionView reloadData];
    
    
    [self initData];
    [self initView];
    
}


- (void)initData{
    
    
    self.assetCollection = nil;
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    // 按创建时间升序
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//
//    // 获取所有视频和图片
    _alls = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
//    _alls = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    
    //获取图片 视频
    NSMutableArray *imgArr = [NSMutableArray new];
    NSMutableArray *videoArr = [NSMutableArray new];
    for(PHAsset *asset in _alls){
        
        if (asset.mediaType == PHAssetMediaTypeVideo) {
            [videoArr addObject:asset];
        }else{
            [imgArr addObject:asset];
        }
    }
    _imgs = (PHFetchResult *)imgArr;
    _videos = (PHFetchResult *)videoArr;
    
    if(_type == 1)_currents = _alls;
    if(_type == 2)_currents = _imgs;
    if(_type == 3)_currents = _videos;
    
    [self setDataSort];
}

-(void)setDataSort{
    
    if (!_currents) {
        PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
        allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        _currents = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    }
    
    _imageManager = [[PHCachingImageManager alloc] init];
    _requestOption = [[PHImageRequestOptions alloc] init];
    // 若设置 PHImageRequestOptionsResizeModeExact 则 requestImageForAsset 下来的图片大小是 targetSize 的
    _requestOption.resizeMode = PHImageRequestOptionsResizeModeExact;
    // 若 _requestOption = nil，则承载图片的 UIImageView 需要添加如下代码
    /*
     _imageView.contentMode = UIViewContentModeScaleAspectFill;
     _imageView.clipsToBounds = YES;
     */
    _requestOption = nil;
    
    [_imageManager stopCachingImagesForAllAssets];
    previousPreheatRect = CGRectZero;
    
    
    //未选中
    [_choices removeAllObjects];
    for(int i=0;i<_currents.count;++i){
        [_choices addObject:@"0"];
    }
    
    //倒序
    NSMutableArray *array = [NSMutableArray new];
    for(int i=0;i<_currents.count;++i){
        [array addObject:_currents[i]];
    }
    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    _currents = (PHFetchResult *)array;
    
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.mCollectionView.backgroundColor = [UIColor whiteColor];
}

- (void)updateCachedAssets
{
    if (!self.isViewLoaded || self.view.window == nil) {
        return;
    }
    
    // 预热区域 preheatRect 是 可见区域 visibleRect 的两倍高
    CGRect visibleRect = CGRectMake(0.f, self.mCollectionView.contentOffset.y, self.mCollectionView.bounds.size.width, self.mCollectionView.bounds.size.height);
    CGRect preheatRect = CGRectInset(visibleRect, 0, -0.5*visibleRect.size.height);
    
    // 只有当可见区域与最后一个预热区域显著不同时才更新
    CGFloat delta = fabs(CGRectGetMidY(preheatRect) - CGRectGetMidY(previousPreheatRect));
    if (delta > self.view.bounds.size.height / 3.f) {
        // 计算开始缓存和停止缓存的区域
        [self computeDifferenceBetweenRect:previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            [self imageManagerStopCachingImagesWithRect:removedRect];
        } addedHandler:^(CGRect addedRect) {
            [self imageManagerStartCachingImagesWithRect:addedRect];
        }];
        previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        //添加 向下滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        //添加 向上滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        //移除 向上滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        //移除 向下滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外顶部的预热区域）
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    }
    else {
        //当 oldRect 与 newRect 没有相交区域时
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (void)imageManagerStartCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *addAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager startCachingImagesForAssets:addAssets targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption];
}

- (void)imageManagerStopCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *removeAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager stopCachingImagesForAssets:removeAssets targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption];
}

- (NSMutableArray<PHAsset *> *)indexPathsForElementsWithRect:(CGRect)rect
{
    UICollectionViewLayout *layout = self.mCollectionView.collectionViewLayout;
    NSArray<__kindof UICollectionViewLayoutAttributes *> *layoutAttributes = [layout layoutAttributesForElementsInRect:rect];
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    for (__kindof UICollectionViewLayoutAttributes *layoutAttr in layoutAttributes) {
        NSIndexPath *indexPath = layoutAttr.indexPath;
        PHAsset *asset = [_currents objectAtIndex:indexPath.item];
        [assets addObject:asset];
    }
    return assets;
}

#pragma mark - UIScrollViewDelegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCachedAssets];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _currents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    PHAsset *asset = [_currents objectAtIndex:indexPath.item];
    
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        cell.type = 2;
    }else{
        cell.choice = [_choices[indexPath.row]integerValue];
        cell.type = 1;
        
    }
    
    // 给 Live Photo 添加一个标记
    if (@available(iOS 9.1, *)) {
        if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
            cell.livePhotoBadgeImage = [PHLivePhotoView livePhotoBadgeImageWithOptions:PHLivePhotoBadgeOptionsOverContent];
        }
    }
    
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    [_imageManager requestImageForAsset:asset targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
            cell.thumbnailImage = result;
        }
    }];

    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat item_WH = (SCR_WIDTH-20.f-2.f*3)/4.f;
    return CGSizeMake(item_WH, item_WH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10.f, 10.f, 10.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.f;
}

#pragma SSCollectionViewFlowLayoutDelegate  分组返回灰色
-(UIColor *)backgroundColorForSection:(NSInteger)section collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout{
    return [UIColor whiteColor];
}


-(void)PubilcCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender dic:(NSDictionary *)dic{
    
    for(int i=0;i<_choices.count;++i){
        if(i == indexPath.row){
            if([_choices[i]integerValue] == 0){
                _choices[i] = @"1";
            }else{
                _choices[i] = @"0";
            }
            break;
        }
    }
    [self.mCollectionView reloadData];
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAsset *asset = [_currents objectAtIndex:indexPath.item];
    
    //视频
    if(asset.mediaType == PHAssetMediaTypeVideo) {
        
        if([_choiceType isEqual:@"1"]){
            [self showTime:@"已选择图片，不能再选视频"];
            return;
        }
        _choiceType = @"2";
        
        PHVideoRequestOptions *options = [PHVideoRequestOptions new];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        PHImageManager *manager = [PHImageManager defaultManager];

        [self addSysIndicatorView];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *videoURL = urlAsset.URL;
            NSString *path = videoURL.path;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self deleteSysIndicatorView];
                self.videoBlock(path);
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }
    
    
    //图片
    else{
        
        if([_choiceType isEqual:@"2"]){
            [self showTime:@"已选择视频，不能再选图片"];
            return;
        }
        _choiceType = @"1";
        
        for(int i=0;i<_choices.count;++i){
            if(i == indexPath.row){
                if([_choices[i]integerValue] == 0){
                    
                    if([self getChoice] == _maxNumer){
                        [self showTime:makeMoreStr(@"最多选择",@(_maxNumer),@"张",nil)];
                        break;
                    }
                    _choices[i] = @"1";
                }else{
                    _choices[i] = @"0";
                }
                break;
            }
        }
        [self.mCollectionView reloadData];
        
    }
    
    //清空选项
    if([self getChoice] == 0){
        _choiceType = @"";
    }
    
}

-(void)navgationButtonPressed:(UIButton *)sender{
    if(sender.tag == 10){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        
        if([self getChoice] == 0){
            [self showTime:@"请选择要上传的图片"];
            return;
        }
        
        [_imageArr removeAllObjects];
        
        NSMutableArray *assetArr = [NSMutableArray new];
        for(int i=0;i<_choices.count;++i){
            if([_choices[i] integerValue] == 1){
                [assetArr addObject:_currents[i]];
            }
        }
        
        [self getAllImgs:0 arr:assetArr sender:sender];
        
    }
}

-(NSInteger)getChoice{
    NSInteger num = 0;
    for(int i=0;i<_choices.count;++i){
        NSInteger index = [_choices[i]integerValue];
        if(index == 1){
            num ++;
        }
    }
    return num;
}

-(void)getAllImgs:(NSInteger)index arr:(NSArray *)arr sender:(UIButton *)sender{
    
    PHAsset *asset = arr[index];
    
    __block NSInteger cancelled = 0;
    [sender addActivityOnBtn];
    [_imageManager requestImageForAsset:asset  targetSize:makeSize(SCREEN_Width*10,  SCREEN_Height*10) contentMode:PHImageContentModeDefault options:_requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        [sender closeActivityByBtn:@"确定"];
        
        cancelled ++ ;
        if (cancelled == 2) {
            [self.imageArr addObject:result];
            if(index<arr.count-1){
                [self getAllImgs:index+1 arr:arr sender:sender];
            }
            else{
                self.imageBlock(self.imageArr);
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}




//拍照或者选取照片后的保存和刷新操作
-(void)saveImageAndUpdataHeader:(UIImage *)image{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"/image.png"];
    BOOL success = [imageData writeToFile:fullPath atomically:NO];
    if(success){
        
    }else{
        cout(@"保存失败");
    }
}


//videoURL:本地视频路径    time：用来控制视频播放的时间点图片截取
-(UIImage *) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
   
  AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
  NSParameterAssert(asset);
  AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
  assetImageGenerator.appliesPreferredTrackTransform = YES;
  assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
   
  CGImageRef thumbnailImageRef = NULL;
  CFTimeInterval thumbnailImageTime = time;
  NSError *thumbnailImageGenerationError = nil;
  thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
   
  if(!thumbnailImageRef)
      NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
   
  UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
   
    return thumbnailImage;
}


@end
