//
//  HNPushOptions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNSDK.h"

/*!
 *  \~chinese
 *  推送消息的显示风格
 */
typedef NS_ENUM(NSInteger, HNPushDisplayStyle) {
    //简单显示"您有一条新消息"
    HNPushDisplayStyleSimpleBanner = EMPushDisplayStyleSimpleBanner,
    //显示消息内容
    HNPushDisplayStyleMessageSummary = EMPushDisplayStyleMessageSummary
};


/*!
 *  \~chinese
 *  推送免打扰设置
 */
typedef NS_ENUM(NSInteger, HNPushNoDisturbSetting) {
    //全天免打扰
    HNPushNoDisturbSettingDay = EMPushNoDisturbStatusDay,
    //自定义时间段免打扰
    HNPushNoDisturbSettingCustom = EMPushNoDisturbStatusCustom,
    //关闭免打扰
    HNPushNoDisturbSettingClose = EMPushNoDisturbStatusClose,
};

@interface HNPushOptions : NSObject

/**  推送消息的显示风格  */
@property (nonatomic, assign) HNPushDisplayStyle                displayStyle;

/**  推送免打扰设置  */
@property (nonatomic, assign) HNPushNoDisturbSetting            noDisturbSetting;

/*!
 *  \~chinese
 *  消息推送免打扰开始时间，小时，暂时只支持整点（小时）
 */
@property (nonatomic, assign) NSInteger                         noDisturbingStartH;

/*!
 *  \~chinese
 *  消息推送免打扰结束时间，小时，暂时只支持整点（小时）
 */
@property (nonatomic, assign) NSInteger                         noDisturbingEndH;

/**
 *  消息提示时，是否允许播放声音
 */
@property (nonatomic, assign) BOOL                              isAlertSoundEnabled;

/**
 *  小时提示时，是否允许振动
 */
@property (nonatomic, assign) BOOL                              isVibrateEnabled;

/**
 *  朋友圈照片更新
 */
@property (nonatomic, assign) BOOL                              isMomentsUpdateEnabled;

@end
