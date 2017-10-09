//
//  HNMessageModel.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMMessage.h"
#import "HNSDKError.h"
#import "HNSDKType.h"
#import <MapKit/MapKit.h>


@interface HNMessageModel : NSObject

/**
 *  用户判断处理消息类型 如 @"动画表情" @"[图片]" @"[视频]" @"[位置]" 用于 消息列表最后一条消息显示
 */
+ (NSString *)messageTypeTitle:(EMMessage *)message;


@end
