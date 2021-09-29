//
//  SSAddImage.m
//  DEShop
//
//  Created by soldoros on 2017/5/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSAddImage.h"

@implementation SSAddImage

-(instancetype)init{
    if(self = [super init]){
        self.mController= [UIViewController getCurrentController];
    }
    return self;
}

//通过摄像头获取资源
-(void)getImgWithModelType:(SSImageModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock{
    _pickerBlock = pickerBlock;
    _modelType = modelType;
    
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
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
    
    //可编辑
    _imagePickerController.allowsEditing = YES;
    
    //显示照片
    if(_modelType == SSImageModelImage){
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    }
    //显示视频
    else if(_modelType == SSImageModelVideo){
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    //显示 照片+视频
    else{
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage,];
    }
    _imagePickerController.modalPresentationStyle=UIModalPresentationOverFullScreen;
    [_mController presentViewController:_imagePickerController animated:YES completion:nil];
    
}



//通过相册访问资源
//- (void)addImagePickerFromIpc{
//
//    if(![self isPhotoLibraryAvailable]){
//        NSLog(@"相册不可用");
//        return;
//    }
//
//    _imagePickerController = [[UIImagePickerController alloc] init];
//    _imagePickerController.delegate = self;
//    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    _imagePickerController.allowsEditing = NO;
//
    
    //访问相册
//    if(_wayStyle == SSImagePickerWayFormIpc){
//        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    //访问图库
//    else{
//        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    }
    
//    if(modelType == SSImagePickerModelImage){
//        _imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil ,nil];
//
//    }else if(modelType == SSImagePickerModelVideo){
//        _imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*) kUTTypeMovie, (NSString*) kUTTypeVideo, nil];
//    }else{
//        _imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil ,nil];
//    }
   
    
//    _imagePickerController.modalPresentationStyle=UIModalPresentationOverFullScreen;
//    [_mController presentViewController:_imagePickerController animated:YES completion:nil];
//}


#pragma  mark UIImagePickerControllerDelegate协议的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = info[@"UIImagePickerControllerMediaType"];
    
    //获取到图片 判断是否裁剪
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        
        NSURL *imgUrl = info[@"UIImagePickerControllerImageURL"];
        NSString *imgString = [imgUrl absoluteString];
        NSArray *arr = [imgString componentsSeparatedByString:@"."];
        NSString *type = arr.lastObject;
        
         //获取到gif图
        if([type isEqualToString:@"gif"]){
            _modelType = SSImageModelGif;
            _pickerBlock(_modelType,imgUrl);
        }
        //获取普通图片
        else{
            _modelType = SSImageModelImage;
            
            if(imgUrl && imgString){
                _pickerBlock(_modelType,[imgString substringFromIndex:7]);
            }else{
                if(_imagePickerController.editing == YES){
                    [self saveImageAndUpdataHeader:[info objectForKey:UIImagePickerControllerEditedImage]];
                }else{
                    [self saveImageAndUpdataHeader:[info objectForKey:UIImagePickerControllerOriginalImage]];
                }
            }
        }
    }
    
    //获取到视频
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        
       _modelType = SSImageModelVideo;
        
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        NSURL *mp4 = [self convertVideoToFormatWithMP4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        
        if(_pickerBlock){
            _pickerBlock(_modelType,mp4.path);
        }else{
            _pickerBlock = nil;
        }

    }
 
    [picker  dismissViewControllerAnimated:YES completion:nil];
}



//拍照或者选取照片后的保存和刷新操作
-(void)saveImageAndUpdataHeader:(UIImage *)image{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"/image.jpg"];
    BOOL success = [imageData writeToFile:fullPath atomically:NO];
    if(success){
        cout(@"保存成功");
        if(_pickerBlock){
            _pickerBlock(_modelType,fullPath);
        }else{
            _pickerBlock = nil;
        }
    }else{
        cout(@"保存失败");
    }
}

+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)contextInfo{
    
    if(error){
        cout(@"图片保存失败");
    }else{
        cout(@"图片保存成功");
        cout(contextInfo);
    }
}

//保存视频
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        if(_pickerBlock){
            _pickerBlock(_modelType,videoPath);
        }else{
            _pickerBlock = nil;
        }
    }
}


//当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker  dismissViewControllerAnimated:YES completion:nil];
}


//将视频转换成mp4格式
- (NSURL *)convertVideoToFormatWithMP4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        NSString *mp4Path = [NSString stringWithFormat:@"%@/%d%d.mp4", [self getAudioOrVideoPath], (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

- (NSString *)getAudioOrVideoPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"EMDemoRecord"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
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
