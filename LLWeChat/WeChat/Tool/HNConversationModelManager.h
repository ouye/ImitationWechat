//
//  HNConversationModelManager.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/18.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNConversationModel.h"

@interface HNConversationModelManager : NSObject

/** 单利 */
+ (instancetype)sharedManager;

//当前处于活动状态的会话Model
@property (nonatomic, strong) HNConversationModel           *currentActiveConversationModel;

/**
 *  增加一条对话 数据
 */
- (void)addConversationModel:(HNConversationModel *)conversationModel;


/**
 *  删除一条对话 数据
 */
- (void)removeConversationModel:(HNConversationModel *)conversationModel;


/**
 *  通过会话ID 获取一会话 数据
 */
- (HNConversationModel *)conversationModelForConversationId:(NSString *)conversationId;


/**
 *  接收到信息后 更新会话列表数据
 */
- (NSArray<HNConversationModel *> *)updateConversationListAfterReceiveNewMessages:(NSArray *)aMessages;


/**
 *  加载更新后  更新会话列表数据
 */
- (NSArray<HNConversationModel *> *)updateConversationListAfterLoad:(NSArray<EMConversation *> *)aConversations;


/**
 *  将会话置顶
 */
- (void)reloadConversationModelToTop:(HNConversationModel *)conversationModel;

@end
