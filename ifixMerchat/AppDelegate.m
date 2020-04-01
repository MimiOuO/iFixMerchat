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
#import "EMDemoHelper.h"
#import "DemoCallManager.h"
#import "DemoConfManager.h"
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

}

@end
