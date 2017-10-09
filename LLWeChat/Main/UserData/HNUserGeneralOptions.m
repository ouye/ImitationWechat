//
//  HNUserGeneralOptions.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUserGeneralOptions.h"
#import "HNConfig.h"

@implementation HNUserGeneralOptions

- (instancetype)initWithUserKey:(NSString *)userKey {
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *doubleTapKey = [NSString stringWithFormat:@"%@_%@", userKey, DOUBLE_TAP_SHOW_TEXT_KEY];
        NSNumber *doubleTapValue = [userDefaults objectForKey:doubleTapKey];
        if (doubleTapValue) {
            self.doubleTapToShowTextMessage = [doubleTapValue boolValue];
        }else {
            self.doubleTapToShowTextMessage = NO;
        }
        
    }
    
    return self;
}

- (void)saveWithUserKey:(NSString *)userKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *doubleTapKey = [NSString stringWithFormat:@"%@_%@", userKey, DOUBLE_TAP_SHOW_TEXT_KEY];
    
    [userDefaults setObject:@(self.doubleTapToShowTextMessage) forKey:doubleTapKey];
    [userDefaults synchronize];
}


@end
