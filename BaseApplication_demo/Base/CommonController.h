//
//  CommonController.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetryView.h"
@interface CommonController : UIViewController

@property (strong, nonatomic) UIActivityIndicatorView *loadingView;

@property (strong, nonatomic) UILabel *labelEmpty;

@property (assign, nonatomic) NSUInteger page;

// for retry when network error
@property (strong, nonatomic) RetryView *retryView;

- (void)showEmptyMessage:(NSString*)msg;
- (void)hideEmptyMessage;


- (void)showLoading;
- (void)hideLoading;

- (void)setRetryMode;

@end
