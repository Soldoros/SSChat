//
//  SSScanningController.m
//  SSScanningCard
//
//  Created by soldoros on 2018/9/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSScanningController.h"
#import <AVFoundation/AVFoundation.h>
//#import <AssetsLibrary/AssetsLibrary.h>
//#import "excards.h"
#import "LHSIDCardScaningView.h"


@interface SSScanningController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate>

//身份证数据模型
@property (nonatomic,strong) SSCardModel *model;

// 摄像头设备
@property (nonatomic,strong) AVCaptureDevice *device;
// AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic,strong) AVCaptureSession *session;
// 输出格式
@property (nonatomic,strong) NSNumber *outPutSetting;
// 出流对象
@property (nonatomic,strong) AVCaptureVideoDataOutput *videoDataOutput;
// 元数据（用于人脸识别）
@property (nonatomic,strong) AVCaptureMetadataOutput *metadataOutput;
// 队列
@property (nonatomic,strong) dispatch_queue_t queue;

// 预览图层
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
// 人脸检测框区域
@property (nonatomic,assign) CGRect faceDetectionFrame;
// 是否打开手电筒
@property (nonatomic,assign) BOOL torchOn;
@property (nonatomic,strong) UIButton *rightBtn;


@end

@implementation SSScanningController


//默认关闭手电筒
-(instancetype)init{
    if(self = [super init]){
        _torchOn = NO;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillAppear:animated];
    _torchOn = NO;
    _rightBtn.selected = NO;
    [self runSession];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillDisappear:animated];
    [self stopSession];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"扫描身份证";
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"nav_torch_off"] forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"nav_torch_on"] forState:UIControlStateSelected];
    _rightBtn.bounds = CGRectMake(0, 0, 40, 35);
    [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = refreshItem;
    
    
    //初始化ret
    const char *thePath = [[[NSBundle mainBundle] resourcePath] UTF8String];
//    int ret = EXCARDS_Init(thePath);
//    if (ret != 0) {
//        NSLog(@"初始化失败：ret=%d", ret);
//    }
    
    
    //初始化摄像头设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    if ([_device lockForConfiguration:nil]) {
        // 平滑对焦
        if ([_device isSmoothAutoFocusSupported]){
            _device.smoothAutoFocusEnabled = YES;
        }
        // 自动持续对焦
        if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
            _device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        }
        // 自动持续曝光
        if ([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure ]){
            _device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        }
        // 自动持续白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]){
            _device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
        }
        [_device unlockForConfiguration];
    }
    
    
    
    //设置输出格式
    //    kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange = '420v'，表示输出的视频格式为NV12；范围： (luma=[16,235] chroma=[16,240])
    //    kCVPixelFormatType_420YpCbCr8BiPlanarFullRange = '420f'，表示输出的视频格式为NV12；范围： (luma=[0,255] chroma=[1,255])
    //    kCVPixelFormatType_32BGRA = 'BGRA', 输出的是BGRA的格式
    _outPutSetting = @(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange);
    
    
    //将元数据加入队列
    _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _metadataOutput = [[AVCaptureMetadataOutput alloc]init];
    [_metadataOutput setMetadataObjectsDelegate:self queue:_queue];
    
    
    //初始化输出流对象
    _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    _videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
    _videoDataOutput.videoSettings = @{(id)kCVPixelBufferPixelFormatTypeKey:_outPutSetting};
    
    
    //执行输入设备和输出设备之间的数据传递 有很多Device的input和很多类型的Output，都通过CaptureSession来控制进行传输，即：CaputureDevice适配AVCaptureInput，通过Session来输入到AVCaptureOutput中，这样就达到了从设备到文件持久传输的目的（如从相机设备采集图像到UIImage中）
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    
    _session = [[AVCaptureSession alloc] init];
    //设置分辨率 高清
    _session.sessionPreset = AVCaptureSessionPresetHigh;

    if (error){
        NSLog(@"没有摄像头");
    }else{
        if ([_session canAddInput:input]) {
            [_session addInput:input];
        }
        if ([_session canAddOutput:_videoDataOutput]) {
            [_session addOutput:_videoDataOutput];
        }
        // 输出格式要放在addOutPut之后
        if ([_session canAddOutput:_metadataOutput]) {
            [_session addOutput:_metadataOutput];
            _metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeFace];
        }
    
    }
    
    
    //初始化预览图层  保持纵横比+填充层边界 这一层直接像我们展示录制的画面
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.frame = self.view.frame;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_previewLayer];
    
    
    // 添加自定义的扫描界面
    LHSIDCardScaningView *IDCardScaningView = [[LHSIDCardScaningView alloc] initWithFrame:self.view.frame];
    _faceDetectionFrame = IDCardScaningView.facePathRect;
    [self.view addSubview:IDCardScaningView];
    
    
    //设置人脸识别区域 并在此区域获取元数据
    self.metadataOutput.rectOfInterest = [_previewLayer metadataOutputRectOfInterestForRect:_faceDetectionFrame];
    
}


//输入设备和输出设备开始数据传递
- (void)runSession {
    if (![_session isRunning]) {
        dispatch_async(self.queue, ^{
            [self.session startRunning];
        });
    }
}

//输入设备和输出设备结束数据传递
-(void)stopSession {
    if ([self.session isRunning]) {
        dispatch_async(self.queue, ^{
            [self.session stopRunning];
        });
    }
}
    


//打开或关闭闪光灯
-(void)rightBtnClick:(UIButton *)sender{
    
    _torchOn = !_torchOn;
    
    // 判断是否有闪光灯
    if ([_device hasTorch]){
        // 请求独占访问硬件设备
        [_device lockForConfiguration:nil];
        
        if (_torchOn) {
            sender.selected = YES;
            [_device setTorchMode:AVCaptureTorchModeOn];
        } else {
            sender.selected = NO;
            [_device setTorchMode:AVCaptureTorchModeOff];
        }
        // 请求解除独占访问硬件设备
        [_device unlockForConfiguration];
    }else {
        NSLog(@"设备不支持闪光功能！");
    }
    
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate 从元数据中捕捉人脸
//检测人脸是为了获得“人脸区域”，做“人脸区域”与“身份证人像框”的区域对比，
//当前者在后者范围内的时候，才能截取到完整的身份证图像
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        
        // 只有当人脸区域的确在小框内时，才再去做捕获此时的这一帧图像
        if (metadataObject.type == AVMetadataObjectTypeFace) {
            
            AVMetadataObject *transformedMetadataObject = [_previewLayer transformedMetadataObjectForMetadataObject:metadataObject];
            CGRect faceRegion = transformedMetadataObject.bounds;
            
            NSLog(@"是否包含头像：%d, facePathRect: %@, faceRegion: %@",CGRectContainsRect(_faceDetectionFrame, faceRegion),NSStringFromCGRect(_faceDetectionFrame),NSStringFromCGRect(faceRegion));
            
            // 为videoDataOutput设置代理
            if (CGRectContainsRect(_faceDetectionFrame, faceRegion)) {
                if (!_videoDataOutput.sampleBufferDelegate) {
                    [_videoDataOutput setSampleBufferDelegate:self queue:_queue];
                }
            }
        }
    }
}



#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
#pragma mark 从输出的数据流捕捉单一的图像帧
// AVCaptureVideoDataOutput获取实时图像，
//这个代理方法的回调频率很快，几乎与手机屏幕的刷新频率一样快
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    //    kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange = '420v'，表示输出的视频格式为NV12；范围： (luma=[16,235] chroma=[16,240])
    //    kCVPixelFormatType_420YpCbCr8BiPlanarFullRange = '420f'，表示输出的视频格式为NV12；范围： (luma=[0,255] chroma=[1,255])
    //    kCVPixelFormatType_32BGRA = 'BGRA', 输出的是BGRA的格式
    //这个格式在初始化outPutSetting的时候设置了
    
    if ([_outPutSetting isEqualToNumber:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange]] || [_outPutSetting isEqualToNumber:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]]) {
        
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        
        if ([captureOutput isEqual:_videoDataOutput]) {

//            [self getImageBufferRef:imageBuffer];
            
            // 身份证信息识别完毕后，就将videoDataOutput的代理去掉，防止频繁调用
            if (_videoDataOutput.sampleBufferDelegate) {
                [_videoDataOutput setSampleBufferDelegate:nil queue:_queue];
            }
        }
    } else {
        NSLog(@"输出格式不支持");
    }
}


//
//#pragma mark - 身份证信息识别
//- (void)getImageBufferRef:(CVImageBufferRef)imageBufferRef {
//
//    //读取CVImageBufferRef对象
//    CVBufferRetain(imageBufferRef);
//
//
////    解码后的数据并不能直接给CPU访问，需要先用CVPixelBufferLockBaseAddress()锁定地址才能从主存访问，否则调用CVPixelBufferGetBaseAddressOfPlane等函数则返回NULL或无效值。然而，用CVImageBuffer -> CIImage -> UIImage则无需显式调用锁定基地址函数。
//    if (CVPixelBufferLockBaseAddress(imageBufferRef, 0) == kCVReturnSuccess) {
//
//        size_t width= CVPixelBufferGetWidth(imageBufferRef);
//        size_t height = CVPixelBufferGetHeight(imageBufferRef);
//
//        NSLog(@"%zu",width);
//        NSLog(@"%zu",height);
//
////        CVPixelBufferIsPlanar可得到像素的存储方式是Planar或Chunky。若是Planar，则通过CVPixelBufferGetPlaneCount获取YUV Plane数量。通常是两个Plane，Y为一个Plane，UV由VTDecompressionSessionCreate创建解码会话时通过destinationImageBufferAttributes指定需要的像素格式（可不同于视频源像素格式）决定是否同属一个Plane，每个Plane可当作表格按行列处理，像素是行顺序填充的。下面以Planar Buffer存储方式作说明。
////
////        CVPixelBufferGetPlaneCount得到像素缓冲区平面数量，然后由CVPixelBufferGetBaseAddressOfPlane(索引)得到相应的通道，一般是Y、U、V通道存储地址，UV是否分开由解码会话指定，如前面所述。而CVPixelBufferGetBaseAddress返回的对于Planar Buffer则是指向PlanarComponentInfo结构体的指针，
//
//
//        CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = CVPixelBufferGetBaseAddress(imageBufferRef);
//        size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
//        size_t rowBytes = NSSwapBigIntToHost(planar->componentInfoY.rowBytes);
//        unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBufferRef);
//        unsigned char* pixelAddress = baseAddress + offset;
//
//        static unsigned char *buffer = NULL;
//        if (buffer == NULL) {
//            buffer = (unsigned char *)malloc(sizeof(unsigned char) * width * height);
//        }
//
//        memcpy(buffer, pixelAddress, sizeof(unsigned char) * width * height);
//
//        unsigned char pResult[1024];
//        int ret = EXCARDS_RecoIDCardData(buffer, (int)width, (int)height, (int)rowBytes, (int)8, (char*)pResult, sizeof(pResult));
//        if (ret <= 0) {
//            NSLog(@"ret=[%d]", ret);
//        } else {
//            NSLog(@"ret=[%d]", ret);
//
//
//            // 播放一下“拍照”的声音，模拟拍照
//            AudioServicesPlaySystemSound(1108);
//
//            if ([self.session isRunning]) {
//                [self.session stopRunning];
//            }
//
//            char ctype;
//            char content[256];
//            int xlen;
//            int i = 0;
//
//            _model = [SSCardModel new];
//
//            ctype = pResult[i++];
//
//
//            while(i < ret){
//                ctype = pResult[i++];
//                for(xlen = 0; i < ret; ++i){
//                    if(pResult[i] == ' ') { ++i; break; }
//                    content[xlen++] = pResult[i];
//                }
//
//                content[xlen] = 0;
//
//                if(xlen) {
//                    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//
//                    NSLog(@"%@",[NSString stringWithCString:(char *)content encoding:gbkEncoding]);
//
//                    if(ctype == 0x21) {
//                        _model.num = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    } else if(ctype == 0x22) {
//                        _model.name = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    } else if(ctype == 0x23) {
//                        _model.gender = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    } else if(ctype == 0x24) {
//                        _model.nation = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    } else if(ctype == 0x25) {
//                        _model.address = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    } else if(ctype == 0x26) {
//                        _model.issue = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    } else if(ctype == 0x27) {
//                        _model.valid = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
//                    }
//                }
//            }
//
//
//            // 读取到身份证信息 并返回
//            if (_model){
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    if(self.delegate && [self.delegate respondsToSelector:@selector(SSScanningControllerPopController:)]){
//                        [self.delegate SSScanningControllerPopController:self.model];
//                    }
//                    [self.navigationController popViewControllerAnimated:YES];
//                });
//            }
//        }
//
//        CVPixelBufferUnlockBaseAddress(imageBufferRef, 0);
//    }
//
//    CVBufferRelease(imageBufferRef);
//}



@end
