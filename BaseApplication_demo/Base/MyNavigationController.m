//
//  MyNavigationController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()
<UIGestureRecognizerDelegate>

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    [self setNavigationBarHidden:NO];
    

    self.navigationBar.translucent = NO;
    
    id target = self.interactivePopGestureRecognizer.delegate;
    
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    
    panGesture.delegate = self;
    
    [self.view addGestureRecognizer:panGesture];
    
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //判断是否是根控制器
    if(self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
