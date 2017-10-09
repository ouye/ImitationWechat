
//
//  HNSDKErrorCode.h
//  HNWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. AHN rights reserved.
//

#ifndef HNSDKErrorCode_h
#define HNSDKErrorCode_h

typedef enum{
    HNSDKErrorGeneral = 1,                      /*! \~chinese 一般错误 \~english General error */
    HNSDKErrorNetworkUnavailable,               /*! \~chinese 网络不可用 \~english Network is unavaliable */
    
    HNSDKErrorInvalidAppkey = 100,              /*! \~chinese Appkey无效 \~english App key is invalid */
    HNSDKErrorInvalidUsername,                  /*! \~chinese 用户名无效 \~english User name is invalid */
    HNSDKErrorInvalidPassword,                  /*! \~chinese 密码无效 \~english Password is invalid */
    HNSDKErrorInvalidURL,                       /*! \~chinese URL无效 \~english URL is invalid */
    
    HNSDKErrorUserAlreadyLogin = 200,           /*! \~chinese 用户已登录 \~english User has already logged in */
    HNSDKErrorUserNotLogin,                     /*! \~chinese 用户未登录 \~english User has not logged in */
    HNSDKErrorUserAuthenticationFailed,         /*! \~chinese 密码验证失败 \~english Password check failed */
    HNSDKErrorUserAlreadyExist,                 /*! \~chinese 用户已存在 \~english User has already exist */
    HNSDKErrorUserNotFound,                     /*! \~chinese 用户不存在 \~english User was not found */
    HNSDKErrorUserIHNegalArgument,              /*! \~chinese 参数不合法 \~english IHNegal argument */
    HNSDKErrorUserLoginOnAnotherDevice,         /*! \~chinese 当前用户在另一台设备上登录 \~english User has logged in from another device */
    HNSDKErrorUserRemoved,                      /*! \~chinese 当前用户从服务器端被删掉 \~english User was removed from server */
    HNSDKErrorUserRegisterFailed,               /*! \~chinese 用户注册失败 \~english Register user failed */
    HNSDKErrorUpdateApnsConfigsFailed,          /*! \~chinese 更新推送设置失败 \~english Update apns configs failed */
    HNSDKErrorUserPermissionDenied,             /*! \~chinese 用户没有权限做该操作 \~english User has no right for this operation. */
    
    HNSDKErrorServerNotReachable = 300,         /*! \~chinese 服务器未连接 \~english Server is not reachable */
    HNSDKErrorServerTimeout,                    /*! \~chinese 服务器超时 \~english Wait server response timeout */
    HNSDKErrorServerBusy,                       /*! \~chinese 服务器忙碌 \~english Server is busy */
    HNSDKErrorServerUnknownError,               /*! \~chinese 未知服务器错误 \~english Unknown server error */
    
    HNSDKErrorFileNotFound = 400,               /*! \~chinese 文件没有找到 \~english Can't find the file */
    HNSDKErrorFileInvalid,                      /*! \~chinese 文件无效 \~english File is invalid */
    HNSDKErrorFileUploadFailed,                 /*! \~chinese 上传文件失败 \~english Upload file failed */
    HNSDKErrorFileDownloadFailed,               /*! \~chinese 下载文件失败 \~english Download file failed */
    
    HNSDKErrorMessageInvalid = 500,             /*! \~chinese 消息无效 \~english Message is invalid */
    HNSDKErrorMessageIncludeIHNegalContent,      /*! \~chinese 消息内容包含不合法信息 \~english Message contains iHNegal content */
    HNSDKErrorMessageTrafficLimit,              /*! \~chinese 单位时间发送消息超过上限 \~english Unit time to send messages over the upper limit */
    HNSDKErrorMessageEncryption,                /*! \~chinese 加密错误 \~english Encryption error */
    
    HNSDKErrorGroupInvalidId = 600,             /*! \~chinese 群组ID无效 \~english Group Id is invalid */
    HNSDKErrorGroupAlreadyJoined,               /*! \~chinese 已加入群组 \~english User has already joined the group */
    HNSDKErrorGroupNotJoined,                   /*! \~chinese 未加入群组 \~english User has not joined the group */
    HNSDKErrorGroupPermissionDenied,            /*! \~chinese 没有权限进行该操作 \~english User has NO authority for the operation */
    HNSDKErrorGroupMembersFull,                 /*! \~chinese 群成员个数已达到上限 \~english Reach group's max member count */
    HNSDKErrorGroupNotExist,                    /*! \~chinese 群组不存在 \~english Group is not exist */
    
    HNSDKErrorChatroomInvalidId = 700,          /*! \~chinese 聊天室ID无效 \~english Chatroom id is invalid */
    HNSDKErrorChatroomAlreadyJoined,            /*! \~chinese 已加入聊天室 \~english User has already joined the chatroom */
    HNSDKErrorChatroomNotJoined,                /*! \~chinese 未加入聊天室 \~english User has not joined the chatroom */
    HNSDKErrorChatroomPermissionDenied,         /*! \~chinese 没有权限进行该操作 \~english User has NO authority for the operation */
    HNSDKErrorChatroomMembersFull,              /*! \~chinese 聊天室成员个数达到上限 \~english Reach chatroom's max member count */
    HNSDKErrorChatroomNotExist,                 /*! \~chinese 聊天室不存在 \~english Chatroom is not exist */
    
    HNSDKErrorCallInvalidId = 800,              /*! \~chinese 实时通话ID无效 \~english CaHN id is invalid */
    HNSDKErrorCallBusy,                         /*! \~chinese 已经在进行实时通话了 \~english User is busy */
    HNSDKErrorCallRemoteOffline,                /*! \~chinese 对方不在线 \~english Callee is offline */
    HNSDKErrorCallConnectFailed,                /*! \~chinese 实时通话建立连接失败 \~english Establish connection failed */
    
}HNSDKErrorCode;



#endif /* HNSDKErrorCode_h */
