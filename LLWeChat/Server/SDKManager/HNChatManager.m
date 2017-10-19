//
//  HNChatManager.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNChatManager.h"
#import "HNPushOptions.h"
#import "HNConversationModelManager.h"


#define NEW_MESSAGE_QUEUE_LABEL "NEW_MESSAGE_QUEUE"

@interface HNChatManager ()

@property (nonatomic) dispatch_queue_t messageQueue;

@end

@implementation HNChatManager


/** 单利 */
shared_implementation(HNChatManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        _messageQueue = dispatch_queue_create(NEW_MESSAGE_QUEUE_LABEL, DISPATCH_QUEUE_SERIAL );
    }
    return self;
}

/**
 *   从数据库中加载会话
 */
- (void)getAllConversationFromDB{
    NSLog(@"从数据库中加载会话");
    
    WEAK_SELF;
    dispatch_async(_messageQueue, ^{
        NSArray<EMConversation *> *array = [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
        [weakSelf processConversationList:array];
        
    });
}



- (void)processConversationList:(NSArray<EMConversation *> *)conversationList {
    NSArray<HNConversationModel *> *conversationListModels = [[HNConversationModelManager sharedManager] updateConversationListAfterLoad:conversationList];
    
    WEAK_SELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.conversationListDelegate conversationListDidChanged:conversationListModels];
    });
    
}



/*!
 *  将所有未读消息设置为已读
 */
- (void)markAllMessagesAsRead:(HNConversationModel *)conversation {
    [conversation.sdk_conversation markAllMessagesAsRead];
    
    SAFE_SEND_MESSAGE(self.conversationListDelegate, unreadMessageNumberDidChanged) {
        [self.conversationListDelegate unreadMessageNumberDidChanged];
    }
}






@end
