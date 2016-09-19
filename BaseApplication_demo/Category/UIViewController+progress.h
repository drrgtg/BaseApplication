//
//  UIViewController+progress.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProgressDefault = -1,
    ProgressFailure = 0,
    ProgressSuccess = 1,
} ProgressTypeWithMsk;

@interface UIViewController (progress)

/**
 *  带遮罩.请等待
 */
-(void)showWaitingWithMask;
/**
 *  状态.带遮罩
 */
-(void)showFlagWithStatus:(ProgressTypeWithMsk) type withMessage:(NSString *)message;
/**
 *  自定义文字
 *
 *  @param message message
 *  @param mask    是否存在遮罩
 */
-(void)showMessage:(NSString *) message isMask:(BOOL) mask;
/**
 *  显示一个长条message
 *  default 白底黑字
 */
-(void)showAlertMessage:(NSString *)message;
/**
 *  清除所有
 */
-(void)dismissAllHUD;
@end
