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


@interface LLUtils : NSObject

+ (instancetype)sharedUtils;            //单利


@end

NS_ASSUME_NONNULL_END

#import "LLUtils+CGHelper.h"
#import "LLUtils+File.h"                // 获取处理文件路径的
#import "LLUtils+Video.h"
