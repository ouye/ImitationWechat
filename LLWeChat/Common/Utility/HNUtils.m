//
//  HNUtils.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUtils.h"

@implementation HNUtils

+ (instancetype)sharedUtils {
    static HNUtils *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HNUtils alloc] init];
    });
    
    return _instance;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
