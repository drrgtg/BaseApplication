//
//  JLTools.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/26.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "JLTools.h"
#import <AVFoundation/AVFoundation.h>
//判断用户是否有权限访问相机
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <EventKit/EventKit.h>


#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <dlfcn.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTCarrier.h>

@import CoreTelephony;
@import CoreLocation;
//iOS 8
@import AddressBook;
//iOS 9
@import Contacts;
@import AVFoundation;

@implementation JLTools

/**
 联网权限

 @return YES or NO
 */
+ (BOOL)isConnectNetAble
{
    __block BOOL able = NO;
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
            case kCTCellularDataRestricted:
            {
                NSLog(@"Restricrted");
                able = NO;
            }
                break;
            case kCTCellularDataNotRestricted:
            {
                NSLog(@"Not Restricted");
                able = YES;
            }
                break;
            case kCTCellularDataRestrictedStateUnknown:
            {
                NSLog(@"Unknown");
                able = NO;
            }
                break;
            default:
                break;
        };
    };
    return able;
}

/**
 推送功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isRemoteNotificationAble
{
    BOOL able = NO;
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    switch (settings.types) {
        case UIUserNotificationTypeNone:
            NSLog(@"None");
            able = NO;
            break;
        case UIUserNotificationTypeAlert:
            NSLog(@"Alert Notification");
            able = YES;
            break;
        case UIUserNotificationTypeBadge:
            NSLog(@"Badge Notification");
            able = YES;
            break;
        case UIUserNotificationTypeSound:
            NSLog(@"sound Notification'");
            able = YES;
            break;
            
        default:
            break;
    }
    return able;
}

/**
 定位功能是否可用
 
 @return YES or NO
 */
+  (BOOL)isLocationAble
{
    //定位开关开启没有，如果没有请跳转到定位开关处开启开关
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        NSLog(@"not turn on the location");
    }
    BOOL able = NO;
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Authorized");
            able = YES;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"AuthorizedWhenInUse");
            able = YES;
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            able = NO;
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            able = NO;
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            able = NO;
            break;
        default:
            break;
    }
    return able;
}

/**
 相机功能是否可用
 
 @return YES or NO
 */
+  (BOOL)isCameraAble
{
    BOOL able = NO;
    //是否存在相机
    if ([[self class] currentDeviceVersion] >10.0)
    {
        AVCaptureDeviceDiscoverySession *discoverDevice = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInDualCamera,AVCaptureDeviceTypeBuiltInTelephotoCamera,AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        if (discoverDevice.devices.count<1)
        {
            able = NO;
        }
        else{
            able = YES;
        }
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //是否有权限打开相机
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限 做一个友好的提示
        NSLog(@"%@",@"无权限");
        able = NO;
    } else {
        //调用相机
        able = YES;
    }
    return able;
}

/**
 相册功能是否可用
 
 @return YES or NO
 */
+  (BOOL)isPhotographAble
{
    BOOL able = NO;
    if ([[self class] currentDeviceVersion] >8.0)
    {
        //是否有权限访问相册
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthorStatus) {
            case PHAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                able = YES;
                break;
            case PHAuthorizationStatusDenied:
                NSLog(@"Denied");
                able = NO;
                break;
            case PHAuthorizationStatusNotDetermined:
                NSLog(@"not Determined");
                able = NO;
                break;
            case PHAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                able = NO;
                break;
            default:
                break;
        }

    }
    else
    {
        //是否有权限访问相册
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            //无权限 做一个友好的提示
            able = NO;

        } else {
            //打开相册
            able = YES;
        }
    }
    return able;
}

/**
 麦克风功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isMicroPhoneAble
{
    BOOL able = NO;
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    switch (AVstatus) {
        case AVAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            able = YES;
            break;
        case AVAuthorizationStatusDenied:
            NSLog(@"Denied");
            able = NO;

            break;
        case AVAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            able = NO;
            break;
        case AVAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            able = NO;
            break;
        default:
            break;
    }
    return able;
}


/**
 日历功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isAbleCalendar
{
    BOOL able = NO;
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            able = YES;
            break;
        case EKAuthorizationStatusDenied:
            NSLog(@"Denied'");
            able = NO;
            break;
        case EKAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            able = NO;
            break;
        case EKAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            able = NO;
            break;
        default:
            break;
    }
    return able;
}


/**
 通讯录功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isAbleAddressBook
{
    BOOL able = NO;
    if ([[self class] currentDeviceVersion] > 9.0)
    {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized:
            {
                NSLog(@"Authorized:");
                able = YES;
            }
                break;
            case CNAuthorizationStatusDenied:{
                NSLog(@"Denied");
                able = NO;
            }
                break;
            case CNAuthorizationStatusRestricted:{
                NSLog(@"Restricted");
                able = NO;

            }
                break;
            case CNAuthorizationStatusNotDetermined:{
                NSLog(@"NotDetermined");
                able = NO;

            }
                break;
                
        }
    }
    else if ([[self class] currentDeviceVersion] > 8.0)
    {
        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        switch (ABstatus) {
            case kABAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                able = YES;
                break;
            case kABAuthorizationStatusDenied:
                NSLog(@"Denied'");
                able = NO;

                break;
            case kABAuthorizationStatusNotDetermined:
                NSLog(@"not Determined");
                able = NO;

                break;
            case kABAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                able = NO;

                break;
            default:
                break;
        }
    }
    
    return able;
}
/**
 获取当前局域网iP
 
 @return iP String
 */
+ (NSString *)currentLanIP
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 获取当前MAC地址
 
 @return mac String
 */
+ (NSString *)getMacAddress
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    // NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    free(buf);
    NSLog(@"UUID:%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString]);
    return [outstring uppercaseString];
}
/**
 当前网络状态 WIFI 4G 3G 2G WWAN
 
 @return NetWorkType String
 */
+(NSString* )getNetWorkType
{
    NSString *netWorkType = @"";
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    for (id subview in subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    NSLog(@"NONE");
                    netWorkType = @"no net work";
                    break;
                case 1:
                    NSLog(@"2G");
                    netWorkType = @"2G";
                    break;
                case 2:
                    NSLog(@"3G");
                    netWorkType = @"3G";
                    break;
                case 3:
                    NSLog(@"4G");
                    netWorkType = @"4G";
                    break;
                case 5:
                {
                    NSLog(@"WIFI");
                    netWorkType = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    return netWorkType;
}

/**
 获取信号强度
 
 @return 信号强度 String
 */
+(NSString*) getSignalStrength
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;

    for (id subview in subviews) {
        if([subview isKindOfClass:    [NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
            dataNetworkItemView = subview;
        }
        else if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarServiceItemView") class]])
        {
            NSLog(@"%@", [subview valueForKey:@"_serviceString"]);
        }
    }
//当前移动网络信号强度
    NSString *signalStrength = [dataNetworkItemView valueForKey:@"_signalStrengthRaw"];
    
    NSLog(@"signal %@", signalStrength);
    return signalStrength;
}


/**
 当前系统版本

 @return 版本double数字
 */
+ (double)currentDeviceVersion
{
    return  [[[UIDevice currentDevice] systemVersion] doubleValue];;
}
@end
