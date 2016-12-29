//
//  JLTools.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/26.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "JLTools.h"

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
    return able;
}

/**
 相册功能是否可用
 
 @return YES or NO
 */
+  (BOOL)isPhotographAble
{
    BOOL able = NO;
    return able;
}

/**
 麦克风功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isMicroPhoneAble
{
    BOOL able = NO;
    return able;
}


/**
 蓝牙功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isAbleBlueTooth
{
    BOOL able = NO;
    return able;
}


/**
 日历功能是否可用
 
 @return YES or NO
 */
+ (BOOL)isAbleCalendar
{
    BOOL able = NO;
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
+ (double)currentDeviceVersion
{
    return  [[[UIDevice currentDevice] systemVersion] doubleValue];;
}
@end
