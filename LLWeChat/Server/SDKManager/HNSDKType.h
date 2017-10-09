
//
//  HNSDKType.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#ifndef HNSDKType_h
#define HNSDKType_h

#import "EMMessage.h"
#import "EMMessageBody.h"
#import "EMConversation.h"
#import "EMFileMessageBody.h"
#import "EMClientDelegate.h"

static NSString *HNConnectionStateDidChangedNotification = @"HNConnectionStateDidChangedNotification";

#pragma -------- scoket 连接状态 ---------
typedef NS_ENUM(NSInteger, HNConnectionState) {
    HNConnectionStateConnected = EMConnectionConnected,             /**   已连接 */
    HNConnectionStateDisconnected,                                  /**   未连接 */
};

/*!
 *  \~chinese
 *  消息体类型
 *
 *  \~english
 *  Message body type
 */
typedef NS_ENUM(NSInteger, HNMessageBodyType) {
    HNMessageBodyTypeText = EMMessageBodyTypeText,                  /*! \~chinese 文本类型 \~english Text */
    HNMessageBodyTypeImage = EMMessageBodyTypeImage,                /*! \~chinese 图片类型 \~english Image */
    HNMessageBodyTypeVideo = EMMessageBodyTypeVideo,                /*! \~chinese 视频类型 \~english Video */
    HNMessageBodyTypeVoice = EMMessageBodyTypeVoice,                /*! \~chinese 语音类型 \~english Voice */
    HNMessageBodyTypeEMLocation = EMMessageBodyTypeLocation,        /*! \~chinese 位置类型 \~english Location */
    HNMessageBodyTypeFile = EMMessageBodyTypeFile,                  /*! \~chinese 文件类型 \~english File */
    HNMessageBodyTypeDateTime,                                      /**   时间 */
    HNMessageBodyTypeGif,                                           /**   gif消息 */
    HNMessageBodyTypeLocation,                                      /**   位置消息 */
    HNMessageBodyTypeRecording,                                     /**   表示正在录音的Cell */
    
};

/*!
 *  \~chinese
 *  附件下载状态
 *
 *  \~english
 *  Download status of attachment
 */
typedef NS_ENUM(NSInteger, HNMessageDownloadStatus) {
    HNMessageDownloadStatusDownloading = EMDownloadStatusDownloading,   /*! \~chinese 正在下载 \~english Downloading */
    HNMessageDownloadStatusSuccessed = EMDownloadStatusSuccessed,       /*! \~chinese 下载成功 \~english Successed */
    HNMessageDownloadStatusFailed = EMDownloadStatusFailed,             /*! \~chinese 下载失败 \~english Failed */
    HNMessageDownloadStatusPending = EMDownloadStatusPending,           /*! \~chinese 准备下载 \~english Pending */
    HNMessageDownloadStatusWaiting = 10086,                             /**   Waiting */
    HNMessageDownloadStatusNone
};


/*!
 *  \~chinese
 *  消息发送状态
 *
 *  \~english
 *   Message Status
 */
typedef NS_ENUM(NSInteger, HNMessageStatus) {
    HNMessageStatusPending  = EMMessageStatusPending,                   /*! \~chinese 发送未开始 \~english Pending */
    HNMessageStatusDelivering = EMMessageStatusDelivering,              /*! \~chinese 正在发送 \~english Delivering */
    HNMessageStatusSuccessed = EMMessageStatusSuccessed,                /*! \~chinese 发送成功 \~english Successed */
    HNMessageStatusFailed = EMMessageStatusFailed,                      /*! \~chinese 发送失败 \~english Failed */
    HNMessageStatusWaiting = 10086,                                     /**   Waiting */
    HNMessageStatusNone
};


/*!
 *  \~chinese
 *  聊天类型
 *
 *  \~english
 *  Chat type
 */
typedef NS_ENUM(NSInteger, HNChatType) {
    HNChatTypeChat   = EMChatTypeChat,                                  /*! \~chinese 单聊消息 \~english Chat */
    HNChatTypeGroupChat = EMChatTypeGroupChat,                          /*! \~chinese 群聊消息 \~english Chat */
    HNChatTypeChatRoom = EMChatTypeChatRoom                             /*! \~chinese 群聊消息 \~english Chat */
};


/*
 *  \~chinese
 *  会话类型
 *
 *  \~english
 *  Conversation type
 */
typedef NS_ENUM(NSInteger, HNConversationType) {
    HNConversationTypeChat = EMConversationTypeChat,                    /*! \~chinese 单聊会话 \~english Chat */
    HNConversationTypeGroupChat = EMConversationTypeGroupChat,          /*! \~chinese 群聊会话 \~english Group chat */
    HNConversationTypeChatRoom = EMConversationTypeChatRoom             /*! \~chinese 聊天室会话 \~english Chatroom chat */
};


/*!
 *  \~chinese
 *  消息方向
 *
 *  \~english
 *  Message direction
 */
typedef NS_ENUM(NSInteger, HNMessageDirection) {
    HNMessageDirectionSend = EMMessageDirectionSend,                    /*! \~chinese 发送的消息 \~english Send */
    HNMessageDirectionReceive = EMMessageDirectionReceive               /*! \~chinese 接收的消息 \~english Receive */
};

static inline HNChatType chatTypeForConversationType(HNConversationType conversationType) {
    switch (conversationType) {
        case HNConversationTypeChat:
            return HNChatTypeChat;                                      /*! \~chinese 单聊消息 \~english Chat */
        case HNConversationTypeChatRoom:
            return HNChatTypeChatRoom;                                  /*! \~chinese 群聊消息 \~english Chat */
        case HNConversationTypeGroupChat:
            return HNChatTypeGroupChat;                                 /*! \~chinese 群聊消息 \~english Chat */
    }
}


#endif /* HNSDKType_h */
