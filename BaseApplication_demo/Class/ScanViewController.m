//
//  ScanViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/24.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//  打开相机扫描二维码

#import "ScanViewController.h"
#import "QRCodeView.h"

#import <CoreImage/CoreImage.h>
//扫描二维码
#import <AVFoundation/AVFoundation.h>
//判断用户是否有权限访问相机
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ScanViewController ()
<
AVCaptureMetadataOutputObjectsDelegate
>
/** 捕捉会话 */
@property (nonatomic, weak) AVCaptureSession *session;
/** 预览图层 */
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *avLayer;
@property (strong, nonatomic) QRCodeView   *qrCode;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.qrCode = [[QRCodeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.qrCode.transparentArea = CGSizeMake(250, 250);
    [self.view addSubview:self.qrCode];
    
    [self scanQRCode];
}

- (void)scanQRCode
{
    //是否有权限访问相册
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case PHAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case PHAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case PHAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    
    //是否有权限访问相册
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        //无权限 做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相册\n设置>隐私>照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return ;
    } else {
        //打开相册
    }
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//是否有权限打开相机
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限 做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机\n设置>隐私>相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return ;
    } else {
        //调用相机
    }
    //是否存在相机
    AVCaptureDeviceDiscoverySession *discoverDevice = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInDualCamera,AVCaptureDeviceTypeBuiltInTelephotoCamera,AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    if (discoverDevice.devices.count<1)
    {
        return;
    }
    NSLog(@"%s",__FUNCTION__);
    // 1. 创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    self.session = session;
    
    // 2. 添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 3. 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // 添加会话输入
    [session addInput:input];
    
    // 4. 添加输出数据接口
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //  5.设置扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake(
                                      screenWidth / 2 - self.qrCode.transparentArea.width / 2,
                                      60,
                                      self.qrCode.transparentArea.width,
                                      self.qrCode.transparentArea.height);
    
    [output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
    
    // 设置输出接口代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //  添加会话输出
    [session addOutput:output];
    // 设置输入元数据的类型(类型是二维码数据)
    // 注意，这里必须设置在addOutput后面，否则会报错
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code]];
    
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity = AVVideoScalingModeResizeAspectFill;
    
    layer.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];

    self.avLayer = layer;
    // 5. 开始扫描
    [session startRunning];
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count) {
        /* 扫描到了数据
            处理数据时候的UI操作,比如停止扫描，移除预览图层等等，显示扫描结果...
            如果是网页就打开在自身页面打开网页，如果是其他的，比如说文字，就显示文字
         */
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@",object);
//        // 停止扫描
//        [self.session stopRunning];
//        // 将预览图层移除
//        [self.avLayer removeFromSuperlayer];
    }else{
        NSLog(@"没有扫描到数据");
    }
}



@end
