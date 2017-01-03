//
//  JLTools.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/26.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLTools : NSObject

/**
 推送功能是否可用

 @return YES or NO
 */
+ (BOOL)isRemoteNotificationAble;

/**
 定位功能是否可用

 @return YES or NO
 */
+  (BOOL)isLocationAble;

/**
 相机功能是否可用

 @return YES or NO
 */
+  (BOOL)isCameraAble;

/**
 相册功能是否可用

 @return YES or NO
 */
+  (BOOL)isPhotographAble;

/**
 麦克风功能是否可用

 @return YES or NO
 */
+ (BOOL)isMicroPhoneAble;


/**
 蓝牙功能是否可用
    蓝牙功能建议单独创建一个单例来管理获取权限
    或者链接外设等等功能
 这里单独另写
 @return YES or NO
 */
//+ (BOOL)isAbleBlueTooth;


/**
 日历功能是否可用

 @return YES or NO
 */
+ (BOOL)isAbleCalendar;


/**
 通讯录功能是否可用

 @return YES or NO
 */
+ (BOOL)isAbleAddressBook;


/**
 获取当前局域网iP

 @return iP String
 */
+ (NSString *)currentLanIP;

/**
 获取当前MAC地址

 @return mac String
 */
+ (NSString *)getMacAddress;

/**
 当前网络状态 WIFI 4G 3G 2G WWAN

 @return NetWorkType String
 */
+(NSString* )getNetWorkType;

/**
 获取信号强度

 @return 信号强度 String
 */
+(NSString*) getSignalStrength;

/**
 当前系统版本
 
 @return 版本double数字
 */
+ (double)currentDeviceVersion;

@end
