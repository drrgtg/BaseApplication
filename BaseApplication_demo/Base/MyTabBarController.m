//
//  MyTabBarController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "MyTabBarController.h"

#import "MyNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface MyTabBarController ()

@property (nonatomic, strong) FirstViewController   * firstVC;
@property (nonatomic, strong) SecondViewController   * secondVC;
@property (nonatomic, strong) ThirdViewController   * thirdVC;

@end

@implementation MyTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initstanceViewControllers];
}
-(void)initstanceViewControllers
{
    //rootViewController
    self.firstVC = [[FirstViewController alloc]init];
    self.secondVC = [[SecondViewController alloc]init];
    self.thirdVC = [[ThirdViewController alloc]init];
    MyNavigationController *nav1= [[MyNavigationController alloc]initWithRootViewController:self.firstVC];
    MyNavigationController *nav2= [[MyNavigationController alloc]initWithRootViewController:self.secondVC];
    MyNavigationController *nav3= [[MyNavigationController alloc]initWithRootViewController:self.thirdVC];
    
    //tabbar
    self.firstVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
    self.secondVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    self.thirdVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
    
    //titile
    self.firstVC.title = @"第一个视图";
    self.secondVC.title = @"第二个视图";
    self.thirdVC.title = @"第三个视图";
    //ViewControllers
    self.viewControllers = @[nav1,nav2,nav3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
