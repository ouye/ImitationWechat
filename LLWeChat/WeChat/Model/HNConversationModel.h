//
//  HNConversationModel.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMConversation.h"
#import "EMMessage.h"
#import "HNSDKType.h"
#import "HNMessageModel.h"


@interface HNConversationModel : NSObject

//以下三个属性SDK不存储,需要由服务器提供,此处采用假数据
/**  头像地址 */
@property (nonatomic, copy)   NSString              *avatarImageURL;

/**  头像 */
@property (nonatomic, copy)   UIImage               *avatarImage;

/**  昵称 */
@property (nonatomic, copy)   NSString              *nickName;

/**  最新消息的时间 */
@property (nonatomic, copy)   NSString              *latestMessageTimeString;;
@property (nonatomic, assign) NSTimeInterval        latestMessageTimestamp;

/**  未读消息数量 */
@property (nonatomic, assign) NSInteger             unreadMessageNumber;

/**  会话ID */
@property (nonatomic, copy, readonly) NSString      *conversationId;

/**  会话类型 */
@property (nonatomic, readonly) HNConversationType  conversationType;

/**  消息草稿 */
@property (nonatomic, copy)   NSString              *draft;

//该Conversation已经获取到的消息数组，按照时间从过去到现在排序，最近的消息在数组最后面
@property (atomic) NSMutableArray<HNMessageModel *> *allMessageModels;


#pragma mark - 消息列表 -
#pragma mark - Server.SDK专用，Client代码不直接访问 -
@property (nonatomic) EMConversation *sdk_conversation;

/**
 *  用户判断处理消息类型 如 @"动画表情" @"[图片]" @"[视频]" @"[位置]" 用于 消息列表最后一条消息显示
 */
- (NSString *)latestMessage;

/**
 *  获取消息的 最后一跳消息状态
 */
- (HNMessageStatus)latestMessageStatus;


+ (HNConversationModel *)conversationModelFromPool:(EMConversation *)conversation;


@end
