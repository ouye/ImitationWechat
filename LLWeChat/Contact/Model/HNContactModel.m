//
//  HNContactModel.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 联系人 昵称，用户名 头像 等 model ************/

#import "HNContactModel.h"

@implementation HNContactModel

/**  初始化model 类 */
- (instancetype)initWithBuddy:(NSString *)buddy{
    self = [super init];
    if (self) {
        _userName = buddy;
        _pinyinOfUserName = [_userName stringConvertPinyin];
        _nickname = @"";
        _avatarImage = [UIImage imageNamed:@"icon_avatar"];
    }
    
    return self;
}


@end
