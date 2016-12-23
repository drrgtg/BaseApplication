//
//  CLLocationManager.m
//  SBookshop
//
//  Created by FeZo on 16/11/4.
//  Copyright © 2016年 evolt. All rights reserved.
//

#import "CLLocManager.h"
#import "CLLocation+Sino.h"

static CLLocManager *mang = nil;

@interface CLLocManager ()<CLLocationManagerDelegate>


@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation CLLocManager

+ (instancetype)shareLocationManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mang = [[CLLocManager alloc]init];
    });
    return mang;
}
-(instancetype)init
{
    if (self = [super init])
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        //用于导航的精确度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return self;
}


- (void)startLocation
{
// 使用期间
    [self.locationManager requestWhenInUseAuthorization];
// 后台一直定位
//    [self.locationManager requestAlwaysAuthorization];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestWhenInUseAuthorization");
        [self.locationManager requestWhenInUseAuthorization];
    }
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];

}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    NSLog(@"Google:%@", location);
    // 2.地球坐标转火星坐标...高德地图坐标，百度地图会有偏差
    location = [location locationMarsFromEarth];
    NSLog(@"火星：%@",location);
    // 3.停止定位
    [self.locationManager stopUpdatingLocation];
    
    if ([self.delegate respondsToSelector:@selector(locationWithLoc:)])
    {
        [self.delegate locationWithLoc:location];
    }
    //逆地址编码>>>>
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *obj in placemarks)
        {
            NSLog(@"%@",obj);
        }
        if ([self.delegate respondsToSelector:@selector(geoCoder:)])
        {
            [self.delegate geoCoder:placemarks];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    //地理位置获取状态
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"不能用");
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"可以用");
        }
            break;
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    //定位失败
    NSLog(@"%@",error.localizedDescription);
}

@end
