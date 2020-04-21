//
//  AppDelegate.m
//  ifixMerchat
//
//  Created by Mimio on 2020/3/30.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "AppDelegate.h"
#import "MioMainViewController.h"
#import <JJException.h>
#import <JPUSHService.h>
#import "EMDemoHelper.h"
#import "DemoCallManager.h"
#import "DemoConfManager.h"
#import "MioLoginVC.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[MioMainViewController alloc] init];

    
    [self.window makeKeyAndVisible];
    
    JJException.exceptionWhenTerminate = NO;
    
    [JJException configExceptionCategory:JJExceptionGuardNSStringContainer | JJExceptionGuardArrayContainer | JJExceptionGuardUnrecognizedSelector | JJExceptionGuardDictionaryContainer];
    [JJException startGuardException];
    
    [self registPlatform];
    
    return YES;
}

-(void)registPlatform{

    //======================================================================//
    //                                环信
    //======================================================================//
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"1101190903046906#duoduopeiwan"];
        options.apnsCertName = @"apns";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    NSLog(@"%@",currentUserId);
    [[EMClient sharedClient] loginWithUsername:@"1" password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
//              [SVProgressHUD showSuccessWithStatus:@"环信登录成功"];
                NSLog(@"登录成功");
//              [[EMClient sharedClient].options setIsAutoLogin:YES];
            } else {
//              [SVProgressHUD showSuccessWithStatus:@"环信登录失败"];
//              NSLog(@"环信----%@",aError.errorDescription);
                NSLog(@"环信----登录失败");
            }
        }];
    [EMDemoHelper shareHelper];
    [DemoCallManager sharedManager];
    [DemoConfManager sharedManager];
    UIApplication *application = [UIApplication sharedApplication];
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType notificationTypes =UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }

    //======================================================================//
    //                                 极光
    //======================================================================//
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:nil appKey:@"c6160bed256ee7eaabbb2a6d"
                          channel:@"App Store"
                 apsForProduction:1
            advertisingIdentifier:nil];
    [JPUSHService setAlias:currentUserId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, @"tag" , iAlias);
    } seq:0];
    
}

#pragma mark- JPUSHRegisterDelegate

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    if ([[userInfo objectForKey:@"type"] isEqualToString:@"order"]) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"showTip" object:nil userInfo:userInfo]];
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
    
}

@end
