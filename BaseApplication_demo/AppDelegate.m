//
//  AppDelegate.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()
<
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
UNUserNotificationCenterDelegate
#endif
>
@end

@implementation AppDelegate

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
        [appearance setBarTintColor:[UIColor orangeColor]];
        [appearance setTintColor:[UIColor whiteColor]];
        [appearance setBackgroundImage:[UIImage rectImageWithColor:UIColorFromRGB(0x0085F4) andRect:CGSizeMake(SCREEN_WIDTH, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [appearance setShadowImage:[[UIImage alloc] init]];
    }
    
}

/**
 注册远程推送
 */
- (void)registerRemoteNotifaction
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    }else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        NSLog(@"8.0注册通知");
        if (true || ![[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        }
    }
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

/**
 3D Touch
 */
- (void)creatShortcutItem
{
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation];
    
    //    //创建自定义图标的icon,图标格式35x35像素单色
//    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"weizhi"];
    
    //创建快捷选项
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.LSP.item1" localizedTitle:@"谁去拿外卖" localizedSubtitle:nil icon:icon userInfo:nil];
    //创建快捷选项
    UIApplicationShortcutItem * item2= [[UIApplicationShortcutItem alloc] initWithType:@"com.LSP.item2" localizedTitle:@"我的红包" localizedSubtitle:nil icon:icon userInfo:nil];//创建快捷选项
    UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc] initWithType:@"com.LSP.item3" localizedTitle:@"我的订单" localizedSubtitle:nil icon:icon userInfo:nil];//创建快捷选项
    UIApplicationShortcutItem * item4 = [[UIApplicationShortcutItem alloc] initWithType:@"com.LSP.item4" localizedTitle:@"手气不错" localizedSubtitle:nil icon:icon userInfo:nil];
    //创建快捷选项
    UIApplicationShortcutItem * item5 = [[UIApplicationShortcutItem alloc] initWithType:@"com.LSP.item5" localizedTitle:@"分享“饿了么”" localizedSubtitle:nil icon:icon userInfo:nil];
    //添加到快捷选项数组1
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3,item4,item5];
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

    [self registerRemoteNotifaction];
    //appearance Setting
    [self appearanceSetting];
    
    [self creatShortcutItem];
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
#pragma mark ------------3D Touch 点击事件处理 --------------
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED
{
    NSLog(@"%@",shortcutItem.localizedTitle);
    completionHandler(YES);
}

#pragma mark ----------------- Notification--iOS 8--

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* strDeviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""]
                                 stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"deviceToken=%@", strDeviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (message.length > 0) {
        NSLog(@"%@",message);
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

#pragma mark ------------UNUserNotificationCenterDelegate iOS10 --------------
// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        if (message.length > 0) {
            if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
                
            } else {
                
            }
        } else {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"iOS10 收到远程通知:%@", userInfo);
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        
        
        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        if (message.length > 0) {
            
            
            
        } else {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
}

@end
