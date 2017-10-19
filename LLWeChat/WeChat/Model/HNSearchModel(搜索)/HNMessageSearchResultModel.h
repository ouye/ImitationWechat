//
//  HNMessageSearchResultModel.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/18.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMMessage.h"

@interface HNMessageSearchResultModel : NSObject

@property (nonatomic) NSString *nickName;

@property (nonatomic) NSTimeInterval timestamp;

//SDK专用，Client代码不直接访问该变量
@property (nonatomic) EMMessage * sdk_message;

- (instancetype)initWithMessage:(EMMessage *)message;


@end
