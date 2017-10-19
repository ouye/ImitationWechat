//
//  HNMessageSearchResultModel.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/18.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNMessageSearchResultModel.h"

@implementation HNMessageSearchResultModel

- (instancetype)initWithMessage:(EMMessage *)message {
    self = [super init];
    if (self) {
        _sdk_message = message;
        _nickName = [message.conversationId copy];
        _timestamp = adjustTimestampFromServer(message.timestamp);
    }
    
    return self;
}

@end
