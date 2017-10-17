//
//  HNUtils+Application.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUtils+Application.h"

@implementation HNUtils (Application)

/** 获取当前window */
+ (UIWindow *)currentWindow {
    return [UIApplication sharedApplication].delegate.window;
}


@end
