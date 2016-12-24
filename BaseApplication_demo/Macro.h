//
//  Macro.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
/**
 *  控制台输出
 */
#ifdef DEBUG
#   define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define NSLog(...)
#endif
/**
 *  当前系统版本
 */
#define OS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]
/**
 *  CSS HEX color
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  屏幕长宽
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//弱引用
#define WeakSelf     typeof(self) __weak weakSelf = self;
//强引用
#define STRONG_SELF typeof(weakSelf) __strong strongSelf = weakSelf ;




#endif /* Macro_h */
