//
//  HNChatManager.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNChatManager.h"

@implementation HNChatManager


/** 单利 */
shared_implementation(HNChatManager)



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
