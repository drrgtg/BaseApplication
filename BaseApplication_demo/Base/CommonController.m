//
//  CommonController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "CommonController.h"

@interface CommonController ()
<UIGestureRecognizerDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;



@end

@implementation CommonController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.labelEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
    self.labelEmpty.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.labelEmpty.textColor = [UIColor grayColor];
    self.labelEmpty.textAlignment = NSTextAlignmentCenter;
    self.labelEmpty.font = [UIFont systemFontOfSize:16.0f];
    self.labelEmpty.hidden = YES;
    [self.view addSubview:self.labelEmpty];
    
    self.retryView = [[RetryView alloc] initWithFrame:CGRectMake(0, 0, 120, 200)];
    self.retryView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.retryView.hidden = YES;
    [self.view addSubview:self.retryView];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingView.center = CGPointMake(self.view.width/2, self.view.height/2-32);
    [self.view addSubview:self.loadingView];
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
//    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showEmptyMessage:(NSString*)msg;
{
    self.labelEmpty.text = msg;
    self.labelEmpty.hidden = NO;
    [self.view bringSubviewToFront:self.labelEmpty];
}

- (void)hideEmptyMessage
{
    self.labelEmpty.text = @"";
    self.labelEmpty.hidden = YES;
}


- (void)showLoading
{
    [self.view bringSubviewToFront:self.loadingView];
    [self.loadingView startAnimating];
}

- (void)hideLoading
{
    [self.loadingView stopAnimating];
}

- (void)setRetryMode
{
    [self.view bringSubviewToFront:self.retryView];
    [self.retryView setHidden:NO];
    [self.retryView.buttonRetry addTarget:self action:@selector(onRetryFirstStep) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onRetryFirstStep
{
    [self.retryView.buttonRetry removeTarget:self action:@selector(onRetryFirstStep) forControlEvents:UIControlEventTouchUpInside];
    [self.retryView setHidden:YES];
    [self onRetry];
}

- (void)onRetry
{
    // default, nothing to do, subclass can override it
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
