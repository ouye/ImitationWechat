//
//  HNUserGeneralOptions.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户配置
@interface HNUserGeneralOptions : NSObject

//使用双击全屏查看文本消息
@property (nonatomic) BOOL doubleTapToShowTextMessage;

//根据UserKey初始化用户通用设置
- (instancetype)initWithUserKey:(NSString *)userKey;

//保持用户通用设置到UserKey中
- (void)saveWithUserKey:(NSString *)userKey;

@end
