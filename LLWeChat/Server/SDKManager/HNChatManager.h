//
//  HNChatManager.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNConversationModel.h"


@protocol HNChatManagerConversationListDelegate <NSObject>

/** 该方法在主线程回调 */
- (void)loadMoreMessagesDidFinishedWithConversationModel:(HNConversationModel *)aConversationModel;

/** */
- (void)unreadMessageNumberDidChanged;

- (NSMutableArray<HNConversationModel *> *)currentConversationList;

@end

@interface HNChatManager : NSObject


@property (nonatomic, weak) id<HNChatManagerConversationListDelegate> conversationListDelegate;


/** 单利 */
+ (instancetype)sharedManager;

/*!
 *  将所有未读消息设置为已读
 */
- (void)markAllMessagesAsRead:(HNConversationModel *)conversation;


@end
