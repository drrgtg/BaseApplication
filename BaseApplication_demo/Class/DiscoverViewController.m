//
//  DiscoverViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/24.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//  识别二维码

#import "DiscoverViewController.h"
//生成二维码
#import <CoreImage/CoreImage.h>

@interface DiscoverViewController ()

@property (strong, nonatomic) UIImageView   *qrCodeImageView;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"生成" style:UIBarButtonItemStylePlain target:self action:@selector(createQRCode)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"识别" style:UIBarButtonItemStylePlain target:self action:@selector(scanQRCode)];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
    
    [self.view addSubview:self.qrCodeImageView];
}

/**
 创建二维码
 */
- (void)createQRCode
{
    NSLog(@"%s",__FUNCTION__);
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    //字符串数据
//    NSString *dataString = @"https://www.baidu.com";
    //    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//字典类数据
    NSDictionary *dic = @{@"key":@"value"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    

    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    UIImage *image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:300];
    // 5. 显示二维码
    self.qrCodeImageView.image = image;
}

/**
 识别二维码
 */
- (void)scanQRCode
{
    NSLog(@"%s",__FUNCTION__);
    UIImage *qrCode = self.qrCodeImageView.image;
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(qrCode)]];
    //判断是否有数据（即是否是二维码）
    if (features.count >= 1) {
        //取第一个元素就是二维码所存放的文本信息
        CIQRCodeFeature *feature = features[0];
        NSString *scannedResult = feature.messageString;
        NSData *data = [scannedResult dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        //通过对话框的形式呈现
        UIAlertController *con = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:dic[@"key"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"复制图中二维码内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //复制
//            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//            pboard.string = scannedResult;
//            NSLog(@"%@",pboard.string);
//            
        }];
        UIAlertAction *ac3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //取消
        }];
        [con addAction:ac1];
        [con addAction:ac2];
        [con addAction:ac3];
        [self presentViewController:con animated:YES completion:nil];
        NSLog(@"%@",scannedResult);
    }else{
        
        NSLog(@"不是二维码");
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ------------LAZY --------------
- (UIImageView *)qrCodeImageView
{
    if (!_qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-32-150, 300, 300)];
        _qrCodeImageView.contentMode = UIViewContentModeCenter;
    }
    return _qrCodeImageView;
}

@end
