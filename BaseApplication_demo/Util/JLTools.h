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
 
 @return YES or NO
 */
+ (BOOL)isAbleBlueTooth;


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



@end
