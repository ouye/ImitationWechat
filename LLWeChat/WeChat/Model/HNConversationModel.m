//
//  HNConversationModel.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNConversationModel.h"
#import "HNConversationModelManager.h"


@implementation HNConversationModel


- (instancetype)initWithConversation:(EMConversation *)conversation {
    self = [super init];
    if (self) {
        _sdk_conversation = conversation;
        _conversationType = (HNConversationType)conversation.type;
        
        _unreadMessageNumber = -1;
        _allMessageModels = [[NSMutableArray alloc] init];
    }
    
    return self;
}


/**
 *  用户判断处理消息类型 如 @"动画表情" @"[图片]" @"[视频]" @"[位置]" 用于 消息列表最后一条消息显示
 */
- (NSString *)latestMessage {
    EMMessage *latestMessage = self.sdk_conversation.latestMessage;
    return [HNMessageModel messageTypeTitle:latestMessage];
}

/**
 *  获取消息的 最后一跳消息状态
 */
- (HNMessageStatus)latestMessageStatus {
    EMMessage *latestMessage = self.sdk_conversation.latestMessage;
    return (HNMessageStatus)latestMessage.status;
}


+ (HNConversationModel *)conversationModelFromPool:(EMConversation *)conversation {
    HNConversationModel *conversationModel = [[HNConversationModelManager sharedManager] conversationModelForConversationId:conversation.conversationId];
    if (!conversationModel) {
        conversationModel = [[HNConversationModel alloc] initWithConversation:conversation];
        [[HNConversationModelManager sharedManager] addConversationModel:conversationModel];
    }else if (conversationModel.sdk_conversation != conversation) {
        [conversationModel updateConversationModel:conversation];
    }
    
    return conversationModel;
}

- (void)updateConversationModel:(EMConversation *)conversation {
    NSAssert([_sdk_conversation.conversationId isEqualToString:conversation.conversationId], @"更新会话数据时，conversationId发生改变");
    
    _sdk_conversation = conversation;
    
}

@end
