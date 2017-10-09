//
//  HNSDKError.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNSDKError.h"

@implementation HNSDKError

+ (instancetype)errorWithEMError:(EMError *)error {
    HNSDKError *_error = [[HNSDKError alloc] initWithDescription:error.errorDescription code:(HNSDKErrorCode)error.code];
    return _error;
}

- (instancetype)initWithDescription:(NSString *)aDescription code:(HNSDKErrorCode)aCode {
    self = [super init];
    if (self) {
        self.errorDescription = aDescription;
        self.errorCode = aCode;
    }
    
    return self;
}

+ (instancetype)errorWithDescription:(NSString *)aDescription code:(HNSDKErrorCode)aCode {
    HNSDKError *error = [[HNSDKError alloc] initWithDescription:aDescription code:aCode];
    return error;
}


@end
