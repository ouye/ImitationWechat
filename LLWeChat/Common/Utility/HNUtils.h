//
//  LLUtils.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

@import UIKit;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//  处理时间戳用的
inline static long long adjustTimestampFromServer(long long timestamp) {
    if (timestamp > 140000000000) {
        timestamp /= 1000;
    }
    return timestamp;
}

@interface HNUtils : NSObject

+ (instancetype)sharedUtils;            //单利


@end

NS_ASSUME_NONNULL_END

#import "HNUtils+CGHelper.h"
#import "HNUtils+File.h"                // 获取处理文件路径的
#import "HNUtils+Video.h"
#import "HNUtils+Application.h"
