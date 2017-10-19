//
//  HNConversationModelManager.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/18.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNConversationModelManager.h"
#import "HNChatManager.h"
#import "EMClient.h"

@interface HNConversationModelManager ()

@property (nonatomic) NSMutableDictionary<NSString *, HNConversationModel *> *allConversationModels;

@end

@implementation HNConversationModelManager

/** 单利 */
shared_implementation(HNConversationModelManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allConversationModels = [NSMutableDictionary dictionary];
    }
    return self;
}

/**
 *  增加一条对话 数据
 */
- (void)addConversationModel:(HNConversationModel *)conversationModel{
    _allConversationModels[conversationModel.conversationId] = conversationModel;
}


/**
 *  加载更新后  更新会话列表数据
 */
- (NSArray<HNConversationModel *> *)updateConversationListAfterLoad:(NSArray<EMConversation *> *)aConversations{
    NSMutableArray<HNConversationModel *> *conversationListModels = [NSMutableArray arrayWithCapacity:aConversations.count];
    
    [aConversations enumerateObjectsUsingBlock:^(EMConversation * _Nonnull conversation, NSUInteger idx, BOOL * _Nonnull stop) {
        //FIXME: 会话的最新消息为空，这种情况会出现吗？
        if(conversation.latestMessage == nil){
            [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId deleteMessages:YES];
        }else {
            HNConversationModel *conversationModel = [HNConversationModel conversationModelFromPool:conversation];
            [conversationListModels addObject:conversationModel];
        }
    }];
    
    return conversationListModels;
}

/**
 *  通过会话ID 获取一会话 数据
 */
- (HNConversationModel *)conversationModelForConversationId:(NSString *)conversationId{
    return _allConversationModels[conversationId];
}

@end
