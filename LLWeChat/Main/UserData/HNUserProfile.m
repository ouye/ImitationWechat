//
//  HNUserProfile.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUserProfile.h"

@implementation HNUserProfile

/** 单利 */
instance_implementation(HNUserProfile)


- (void)initUserProfileWithUserName:(NSString *)userName nickName:(NSString *)nickName avatarURL:(NSString *)avatarURL {
    self.userName = userName;
    self.nickName = nickName.length > 0 ? nickName : userName;
    self.avatarURL = avatarURL.length > 0 ? avatarURL : @"icon_avatar";
    
    self.userOptions = [[HNUserGeneralOptions alloc] initWithUserKey:userName];
    self.pushOptions = [[HNPushOptions alloc] init];
}


- (void)saveUserOptions {
    [self.userOptions saveWithUserKey:self.userName];
}



@end
