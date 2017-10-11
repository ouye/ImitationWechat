//
//  AppDelegate.m
//  LLWeChat
//
//  Created by GYJZH on 7/16/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import "AppDelegate.h"
#import "EMClient.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "HNLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initializeSDK];

    //准备用户登录
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HNLoginViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
//    [[LLAudioManager sharedManager] stopRecording];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - View Controller


#pragma mark - 初始化环信SDK

- (void)initializeSDK {
    
    //#warning 初始化环信SDK
    //#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    //#warning 本项目没有使用离线推送功能
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appkey = [ud stringForKey:@"identifier_appkey"];
    if (!appkey) {
        appkey = EASE_MOB_APP_KEY;
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
    
    //初始化EMClient
    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
    options.apnsCertName = apnsCertName;
    options.isAutoAcceptGroupInvitation = NO;
    options.isAutoAcceptFriendInvitation = NO;
    options.isAutoLogin = YES;
    options.enableConsoleLog = YES;
    options.isSandboxMode = NO; //YES为SDK内部测试使用
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
}







@end
