//
//  SafariViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 17/1/3.
//  Copyright © 2017年 FezoLsp. All rights reserved.
//

#import "SafariViewController.h"
#import <SafariServices/SafariServices.h>

@interface SafariViewController ()<SFSafariViewControllerDelegate>

@property (strong, nonatomic) SFSafariViewController   *safariVC;

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://app.read591.com:8082/api/shop/wap!advDetail.do?advId=39"] entersReaderIfAvailable:YES];
    self.safariVC.delegate = self;
    
    [self addChildViewController:self.safariVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the view controller is dismissed modally. */
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    NSLog(@"%s",__FUNCTION__);
}

/*! @abstract Invoked when the initial URL load is complete.
 @param success YES if loading completed successfully, NO if loading failed.
 @discussion This method is invoked when SFSafariViewController completes the loading of the URL that you pass
 to its initializer. It is not invoked for any subsequent page loads in the same SFSafariViewController instance.
 */
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    NSLog(@"%s",__FUNCTION__);
}

@end
