//
//  AppDelegate.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
/**
 *  远程推送
 */
-(void)configRemoteNotification:(UIApplication *)application
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) { //iOS8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    { // iOS7
//        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeNewsstandContentAvailability | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert];
    }

}
/**
 *  初始设置
 */
-(void)appearanceSetting
{
    id appearance;
    NSDictionary *dic = nil;
    //UINavigationBar appearance
    appearance = [UINavigationBar appearance];
    {
        dic = @{
                NSForegroundColorAttributeName: [UIColor whiteColor]
                };
        [appearance setTitleTextAttributes:dic];
        [appearance setBarTintColor:[UIColor greenColor]];
        [appearance setTintColor:[UIColor whiteColor]];
        [appearance setBackgroundImage:[UIImage rectImageWithColor:[UIColor greenColor] andRect:CGSizeMake(SCREEN_WIDTH, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [appearance setShadowImage:[[UIImage alloc] init]];
    }

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //Color
    self.window.backgroundColor = [UIColor whiteColor];
    //RootViewController
    self.window.rootViewController = [[MyTabBarController alloc]init];
    //Visible and Key Window
    [self.window makeKeyAndVisible];
    
    
    //注册通知
    [self configRemoteNotification:application];
    //appearance Setting
    [self appearanceSetting];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
