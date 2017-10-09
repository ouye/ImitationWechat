//
//  HNUserProfile.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNPushOptions.h"
#import "HNUserGeneralOptions.h"

@interface HNUserProfile : NSObject

@property (nonatomic, copy)  NSString                *userName;

@property (nonatomic, copy)  NSString                *nickName;

//用户头像资源
@property (nonatomic, copy)  NSString                *avatarURL;

//用户的通用设置
@property (nonatomic, strong) HNUserGeneralOptions   *userOptions;

//用户的消息推送设置
@property (nonatomic, strong) HNPushOptions          *pushOptions;

/** 单利 */
+ (instancetype)sharedInstance;


- (void)initUserProfileWithUserName:(NSString *)userName nickName:(NSString *)nickName avatarURL:(NSString *)avatarURL;

- (void)saveUserOptions;


@end
