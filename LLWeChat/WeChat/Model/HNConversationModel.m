//
//  HNConversationModel.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/1.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNConversationModel.h"

@implementation HNConversationModel




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



@end
