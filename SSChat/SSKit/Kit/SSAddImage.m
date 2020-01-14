//
//  SSAddImage.m
//  DEShop
//
//  Created by soldoros on 2017/5/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSAddImage.h"
#import <Photos/Photos.h>


@implementation SSAddImage


-(void)pickerWithController:(UIViewController *)controller pickerBlock:(SSAddImagePicekerBlock)pickerBlock{
    
    [self pickerWithController:controller wayStyle:SSImagePickerWayFormIpc modelType:SSImagePickerModelImage pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
        pickerBlock(wayStyle,modelType,object);
    }];
}


-(void)pickerWithController:(UIViewController *)controller wayStyle:(SSImagePickerWayStyle)wayStyle modelType:(SSImagePickerModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock{
    
    _controller = controller;
    _pickerBlock = pickerBlock;
    _wayStyle = wayStyle;
    _modelType = modelType;
    
}


-(void)getImagePickerWithAlertController:(UIViewController *)controller modelType:(SSImagePickerModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock{
    
    NSArray *alerts = @[@{SSPickerWayGallery:@"相册"},
                        @{SSPickerWayCamer:@"拍摄"}];
    [self getImagePickerWithAlertController:controller alerts:alerts modelType:modelType pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
        pickerBlock(wayStyle,modelType,object);
    }];
}


-(void)getImagePickerWithAlertController:(UIViewController *)controller alerts:(NSArray *)alerts modelType:(SSImagePickerModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock{
    
    _controller = controller;
    _modelType = modelType;
    _pickerBlock = pickerBlock;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    for(int i=0;i<alerts.count;++i){
        
        NSDictionary * wayDic = alerts[i];
        NSString *wayKey = wayDic.allKeys[0];
        NSString *wayTitle = wayDic[wayKey];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:wayTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if([wayKey isEqualToString:SSPickerWayFormIpc]){
                self.wayStyle = SSImagePickerWayGallery;
                [self addImagePickerFromIpc:modelType];
            }
            else if ([wayKey isEqualToString:SSPickerWayGallery]){
                self.wayStyle = SSImagePickerWayGallery;
                [self addImagePickerFromIpc:modelType];
            }
            else{
                self.wayStyle = SSImagePickerWayCamer;
                [self addImagePickerFromCamer:modelType];
            }
            
        }];
        
        [alertController addAction:action];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                             
    [_controller presentViewController: alertController animated: YES completion: nil];
}



//通过摄像头获取资源
-(void)addImagePickerFromCamer:(SSImagePickerModelType)modelType{
    
    if(![self isCameraAvailable]){
        NSLog(@"摄像头不可用");
        return;
    }
    
    
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    //进入摄像头模式
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 10;
    
    //视频上传质量
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //可编辑
    _imagePickerController.allowsEditing = YES;
    
    //显示照片
    if(modelType == SSImagePickerModelImage){
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    }
    //显示视频
    else if(modelType == SSImagePickerModelVideo){
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    //显示 照片+视频
    else{
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage,];
    }
    _imagePickerController.modalPresentationStyle=UIModalPresentationOverFullScreen;
    [_controller presentViewController:_imagePickerController animated:YES completion:nil];
    
}



//通过相册访问资源
- (void)addImagePickerFromIpc:(SSImagePickerModelType)modelType{
    
    if(![self isPhotoLibraryAvailable]){
        NSLog(@"相册不可用");
        return;
    }
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = NO;
    
    
    //访问相册
    if(_wayStyle == SSImagePickerWayFormIpc){
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //访问图库
    else{
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    if(modelType == SSImagePickerModelImage){
        _imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil ,nil];
        
    }else if(modelType == SSImagePickerModelVideo){
        _imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil ,nil];
    }else{
        _imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil ,nil];
    }
   
    
    _imagePickerController.modalPresentationStyle=UIModalPresentationOverFullScreen;
    [_controller presentViewController:_imagePickerController animated:YES completion:nil];
}




#pragma  mark UIImagePickerControllerDelegate协议的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = info[@"UIImagePickerControllerMediaType"];
    NSURL *imgUrl = info[@"UIImagePickerControllerImageURL"];
    NSString *imgString = [imgUrl absoluteString];
    NSArray *arr = [imgString componentsSeparatedByString:@"."];
    NSString *type = arr.lastObject;
    
    //获取到图片 判断是否裁剪
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        
         //获取到gif图
        if([type isEqualToString:@"gif"]){
            _modelType = SSImagePickerModelGif;
            _pickerBlock(_wayStyle,_modelType,imgUrl);
        }
        //获取普通图片
        else{
            _modelType = SSImagePickerModelImage;
            
            if(_imagePickerController.editing == YES){
                [self saveImageAndUpdataHeader:[info objectForKey:UIImagePickerControllerEditedImage]];
            }else{
                [self saveImageAndUpdataHeader:[info objectForKey:UIImagePickerControllerOriginalImage]];
            }
        }
    }
    
    //获取到视频
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
       _modelType = SSImagePickerModelVideo;
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];
        NSString *urlPath=[url path];
        
        //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlPath)) {
            if(_modelType != SSImagePickerWayFormIpc && _modelType != SSImagePickerWayGallery){
                UISaveVideoAtPathToSavedPhotosAlbum(urlPath,self,@selector(video:didFinishSavingWithError:contextInfo:),nil);
            }else{
                if(_pickerBlock){
                    _pickerBlock(_wayStyle,_modelType,urlPath);
                }else{
                    _pickerBlock = nil;
                }
            }
        }

    }
 
    [picker  dismissViewControllerAnimated:YES completion:nil];
}

//保存视频
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        if(_pickerBlock){
            _pickerBlock(_wayStyle,_modelType,videoPath);
        }else{
            _pickerBlock = nil;
        }
    }
}


//当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker  dismissViewControllerAnimated:YES completion:nil];
}


//拍照或者选取照片后的保存和刷新操作
-(void)saveImageAndUpdataHeader:(UIImage *)image{
    
    if(_pickerBlock){
        _pickerBlock(_wayStyle,_modelType,image);
    }else{
        _pickerBlock = nil;
    }
}

//判断设备是否有摄像头
-(BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
-(BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
-(BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//相册是否可用
-(BOOL)isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

//是否可以在相册中选择视频
-(BOOL)canUserPickVideosFromPhotoLibrary{
    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

//是否可以在相册中选择照片
-(BOOL)canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

// 判断是否支持某种多媒体类型：拍照，视频,
-(BOOL)cameraSupportsMedia:(NSString*)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result=NO;
    if ([paramMediaType length]==0) {
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray*availableMediaTypes=[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}



//检查是否支持录像
-(BOOL)doesCameraSupportShootingVideos{
    /*在此处注意我们要将MobileCoreServices 框架添加到项目中，
     然后将其导入：#import <MobileCoreServices/MobileCoreServices.h> 。不然后出现错误使用未声明的标识符 'kUTTypeMovie'
     */
    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

//检查摄像头是否支持拍照
-(BOOL)doesCameraSupportTakingPhotos{
    /*在此处注意我们要将MobileCoreServices 框架添加到项目中，
     然后将其导入：#import <MobileCoreServices/MobileCoreServices.h> 。不然后出现错误使用未声明的标识符 'kUTTypeImage'
     */
    
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}









@end
