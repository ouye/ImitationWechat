//
//  HNContactManager.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 环信 联系人管理 ************/

#import <Foundation/Foundation.h>
#import "HNContactModel.h"                      // 联系人 model
#import "HNSDKError.h"
#import "EMSDK.h"

NS_ASSUME_NONNULL_BEGIN

// 联系人变化通知
#define HNContactChangedNotification            @"HnContactChangedNotification"


@interface HNContactManager : NSObject

/** 单利 */
+ (instancetype)sharedManager;

/*!
 *  \~chinese
 *  从内存中获取所有好友
 *
 *  @result 好友列表<NSString>
 */
- (void)getContacts:(void (^)(NSMutableArray<HNContactModel *> *))complete;
- (NSMutableArray<HNContactModel *> *)getContacts ;


/*!
 *  \~chinese
 *  异步从数据库获取所有的好友
 *
 *  @return 好友列表<NSString>
 */
- (void)asynGetContactsFromDB:(void (^ __nullable)(NSMutableArray<HNContactModel *> *))complete;

/**  从数据库获取所有的好友  非异步*/
- (NSMutableArray<HNContactModel *> *)getContactsFromDB ;


/*!
 *  \~chinese
 *  异步从服务器获取所有的好友
 *
 *  @param aSuccessBlock    成功的回调
 *  @param aFailureBlock    失败的回调
 */
- (void)asynGetContactsFromServer:(void (^ __nullable)(NSMutableArray<HNContactModel *> *))complete;


/*!
 *  \~chinese
 *  添加好友
 *  同步方法，会阻塞当前线程
 *
 *  @param aUsername  要添加的用户
 *  @param aMessage   邀请信息
 */
- (HNSDKError *)addContact:(NSString *)buddyName message:(NSString*)aMessage;

- (HNSDKError *)addContact:(NSString *)buddyName;



/*!
 *  \~chinese
 *  同意加好友的申请
 *
 *  同步方法，会阻塞当前线程
 *
 *  @param aUsername 申请者
 */
//- (void)acceptInvitationWithApplyEntity:(ApplyEntity *)entity completeCallback:(void (^ __nullable)(HNSDKError *error))completeCallback;

NS_ASSUME_NONNULL_END

@end
