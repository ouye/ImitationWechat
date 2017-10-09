//
//  HNContactModel.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 联系人 昵称，用户名 头像 等 model ************/

#import <Foundation/Foundation.h>

@interface HNContactModel : NSObject

/** 名称 */
@property (nonatomic, readonly, copy) NSString      *userName;

/** 拼音用户名 */
@property (nonatomic, copy) NSString                *pinyinOfUserName;

/** 昵称 */
@property (nonatomic, copy) NSString                *nickname;

/** 头像URL */
@property (nonatomic, copy) NSString                *avatarURLPath;

/** 头像image */
@property (nonatomic, copy) UIImage                 *avatarImage;

/**  初始化model 类 */
- (instancetype)initWithBuddy:(NSString *)buddy;

@end
