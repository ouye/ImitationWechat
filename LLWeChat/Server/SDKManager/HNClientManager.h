//
//  HNClientManager.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/23.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 环信 登陆 登出 注册 获取通知SDK管理 ************/

#import <Foundation/Foundation.h>
#import "EMClient.h"
#import "HNSDKType.h"

@interface HNClientManager : NSObject<EMClientDelegate>

/** socket连接状态 */
@property (nonatomic) EMConnectionState connectionState;


/** 单利 */
+ (instancetype)sharedManager;


/*
 * 该方法为异步调用,同时负责HUD显示    登陆
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password;


/**
 *  该方法后台 环信 登出，同时负责HUD显示
 */
- (void)logout;


/** 
 *  该方法为异步注册 环信 调用，同时负责HUD显示
 */
- (void)registerWithUsername:(NSString *)username password:(NSString *)password;


/*!
 *  \~chinese
 *  从服务器获取推送属性
 *  同步方法，会阻塞当前线程
 *  @result 推送属性
 */
- (void)loadPushOptionsFromServer;


/*!
 *  \~chinese
 *  更新推送设置到服务器
 *  同步方法，会阻塞当前线程
 */
- (void)savePushOptionsToServer;


@end
