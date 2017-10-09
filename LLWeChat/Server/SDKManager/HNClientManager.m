//
//  HNClientManager.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/23.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 环信 登陆 登出 注册 获取通知SDK管理 ************/

#import "HNClientManager.h"
#import "HNPushOptions.h"
#import "HNContactManager.h"


#define KNOTIFICATION_LOGINCHANGE @"NOTIFICATION_LOGINCHANG"


@implementation HNClientManager

/** 单利 */
shared_implementation(HNClientManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginStateChange:)
                                                     name:KNOTIFICATION_LOGINCHANGE
                                                   object:nil];
    }
    return self;
}


/*
 * 该方法为异步调用,同时负责HUD显示    登陆
 */

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    [MBProgressHUD showProgress:@"正在登录..."];
    [self loginWithUsername:username password:password HUD:nil];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password HUD:(MBProgressHUD *)HUD {
    WEAK_SELF;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        STRONG_SELF;
        if (!error) {
            //            [[LLUserProfile myUserProfile] initUserProfileWithUserName:username nickName:username avatarURL:nil];
            
            //SDK要求
            [[EMClient sharedClient] dataMigrationTo3];
            //获取消息推送通知
            [self loadPushOptionsFromServer];
            //获取联系人
            [[HNContactManager sharedManager] asynGetContactsFromServer:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                //                [weakSelf loginWithResult:YES];
            });
            
            //            [weakSelf saveLastLoginUsername:username];
            
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [self didLoginFailedWithError:error];
            });
        }
    });
}



/**
 *  该方法后台登出，同时负责HUD显示
 */
- (void)logout {
    [MBProgressHUD showProgress:@"正在退出..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                [MBProgressHUD showMessage:@"解除消息通知失败"];
            }
            [MBProgressHUD hideHUD];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        });
    });
}

//  登陆失败提示
- (void)didLoginFailedWithError:(EMError *)error {
    switch (error.code){
        case EMErrorUserAuthenticationFailed:
            [UIAlertController alertWithTitle:nil message:@"用户验证失败"];
            break;
        case EMErrorServerNotReachable:
            [UIAlertController alertWithTitle:nil message:@"连接服务器失败!"];
            break;
        case EMErrorNetworkUnavailable:
            [UIAlertController alertWithTitle:nil message:@"网路连接失败"];
            break;
        case EMErrorServerTimeout:
            [UIAlertController alertWithTitle:nil message:@"连接超时"];
            break;
        default:
            [UIAlertController alertWithTitle:nil message:@"无法登陆"];
            break;
    }
    //    [self loginWithResult:NO];
}



/**
 *  该方法为异步注册 环信 调用，同时负责HUD显示
 */
- (void)registerWithUsername:(NSString *)username password:(NSString *)password{
    [MBProgressHUD showProgress:@"正在注册"];
    WEAK_SELF;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] registerWithUsername:username password:password];
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"注册成功"];
            });
            [weakSelf loginWithUsername:username password:password HUD:nil];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [weakSelf didRegisterFailedWithError:error];
            });
        }
    });
}


// 处理注册报错
- (void)didRegisterFailedWithError:(EMError *)error {
    switch (error.code){
        case EMErrorServerNotReachable:
            [UIAlertController alertWithTitle:nil message:@"连接服务器失败!"];
            break;
        case EMErrorUserAlreadyExist:
            [UIAlertController alertWithTitle:nil message:@"用户名已存在"];
            break;
        case EMErrorNetworkUnavailable:
            [UIAlertController alertWithTitle:nil message:@"网路连接失败"];
            break;
        case EMErrorServerTimeout:
            [UIAlertController alertWithTitle:nil message:@"连接超时"];
            break;
        default:
            [UIAlertController alertWithTitle:nil message:@"无法注册"];
            break;
    }
}



/*!
 *  \~chinese
 *  从服务器获取推送属性
 *  同步方法，会阻塞当前线程
 *  @result 推送属性
 */
- (void)loadPushOptionsFromServer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        EMPushOptions *pushOptions = [[EMClient sharedClient] getPushOptionsFromServerWithError:&error];
        if (!error) {
//            LLPushOptions *llPushOptions = [LLUserProfile myUserProfile].pushOptions;
//            llPushOptions.displayStyle = (LLPushDisplayStyle)pushOptions.displayStyle;
//            llPushOptions.noDisturbSetting = (LLPushNoDisturbSetting)pushOptions.noDisturbStatus;
//            llPushOptions.noDisturbingStartH = pushOptions.noDisturbingStartH;
//            llPushOptions.noDisturbingEndH = pushOptions.noDisturbingEndH;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userName = [EMClient sharedClient].currentUsername;
            NSString *key = [NSString stringWithFormat:@"%@_%@",userName, PUSH_OPTIONS_VIBRATE_KEY];
            
            id setting = [userDefaults objectForKey:key];
            if (setting) {
//                llPushOptions.isVibrateEnabled = [setting boolValue];
            }else {
//                llPushOptions.isVibrateEnabled = YES;
            }
            
            key = [NSString stringWithFormat:@"%@_%@",userName, PUSH_OPTIONS_SOUND_KEY];
            setting = [userDefaults objectForKey:key];
            if (setting) {
//                llPushOptions.isAlertSoundEnabled = [setting boolValue];
            }else {
//                llPushOptions.isAlertSoundEnabled = YES;
            }
            
        }else {
            NSLog(@"PushOptions Error");
        }
    });
}



/*!
 *  \~chinese
 *  更新推送设置到服务器
 *  同步方法，会阻塞当前线程
 */
- (void)savePushOptionsToServer {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMPushOptions *pushOptions = [EMClient sharedClient].pushOptions;
//        LLPushOptions *llPushOptions = [LLUserProfile myUserProfile].pushOptions;
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *userName = [EMClient sharedClient].currentUsername;
//        NSString *key = [NSString stringWithFormat:@"%@_%@",userName, PUSH_OPTIONS_VIBRATE_KEY];
////        [userDefaults setObject:@(llPushOptions.isVibrateEnabled) forKey:key];
//        
//        key = [NSString stringWithFormat:@"%@_%@",userName, PUSH_OPTIONS_SOUND_KEY];
//        [userDefaults setObject:@(llPushOptions.isAlertSoundEnabled) forKey:key];
//        [userDefaults synchronize];
//        
//        BOOL isUpdate = NO;
//        if (pushOptions.displayStyle != llPushOptions.displayStyle) {
//            isUpdate = YES;
//            pushOptions.displayStyle = (EMPushDisplayStyle)llPushOptions.displayStyle;
//        }
//        
//        if (pushOptions.noDisturbStatus != llPushOptions.noDisturbSetting) {
//            isUpdate = YES;
//            pushOptions.noDisturbStatus = (EMPushNoDisturbStatus)llPushOptions.noDisturbSetting;
//        }
//        
//        if (isUpdate) {
//            EMError *error = [[EMClient sharedClient] updatePushOptionsToServer];
//            if (error) {
//                NSLog(@"更新推送设置失败");
//            }
//        }
        
    });
}


#pragma mark - 其他 - 环信 代理

/*!
 *  \~chinese
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况, 会引起该方法的调用:
 *  1. 登录成功后, 手机无法上网时, 会调用该回调
 *  2. 登录成功后, 网络状态变化时, 会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState {
    _connectionState = aConnectionState;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HNConnectionStateDidChangedNotification object:self userInfo:@{@"connectionState":@(aConnectionState)}];
}

/*!
 *  \~chinese
 *  自动登录失败时的回调
 *  @param aError 错误信息
 */
- (void)didAutoLoginWithError:(EMError *)aError {
    if (aError) {
//        [self loginWithResult:NO];
        [self didLoginFailedWithError:aError];
    }else {
        [self loadPushOptionsFromServer];
    }
}


/*!
 *  \~chinese
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice {
    [UIAlertController alertWithTitle:@"提示" message:@"您已在其他设备登录"];
//    [self loginWithResult:NO];
}

/*!
 *  \~chinese
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer {
    [UIAlertController alertWithTitle:@"提示" message:@"您的账号已注销"];
//    [self loginWithResult:NO];
}






- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}








@end
