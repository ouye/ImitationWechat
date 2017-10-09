//
//  HNContactManager.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/24.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 环信 联系人管理 ************/

#import "HNContactManager.h"

#define CONTACT_QUEUE_ID "CONTACT_QUEUE_ID"

@interface HNContactManager ()<EMContactManagerDelegate>

@property (nonatomic) dispatch_queue_t contact_queue;

@end

@implementation HNContactManager

/** 单利 */
shared_implementation(HNContactManager)


- (instancetype)init {
    self = [super init];
    if (self) {
        _contact_queue = dispatch_queue_create(CONTACT_QUEUE_ID, DISPATCH_QUEUE_SERIAL);
        [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:_contact_queue];
    }
    return self;
}

/*!
 *  \~chinese
 *  从内存中获取所有好友
 *
 *  @result 好友列表<NSString>
 */
- (void)getContacts:(void (^)(NSMutableArray<HNContactModel *> *))complete{
    NSMutableArray<HNContactModel *> *allContacts = [self getContacts];
    if (complete) {
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(allContacts);
        });
    }
}

//  *  从内存中获取所有好友  *
- (NSMutableArray<HNContactModel *> *)getContacts{
    NSArray *buddyList = [[EMClient sharedClient].contactManager getContacts];
    NSMutableArray<HNContactModel *> *allContacts = [NSMutableArray arrayWithCapacity:buddyList.count + 1];
    for (NSString *buddy in buddyList) {
        HNContactModel *model = [[HNContactModel alloc] initWithBuddy:buddy];
        [allContacts addObject:model];
    }
    
    // 把自己也加进去
    NSString *loginUsername = [[EMClient sharedClient] currentUsername];
    if (loginUsername && loginUsername.length > 0) {
        HNContactModel *model = [[HNContactModel alloc] initWithBuddy:loginUsername];
        [allContacts addObject:model];
    }
    return allContacts;
}



/*!
 *  \~chinese
 *  从数据库获取所有的好友
 *
 *  @return 好友列表<NSString>
 */
- (void)asynGetContactsFromDB:(void (^ __nullable)(NSMutableArray<HNContactModel *> *))complete{
    dispatch_async(_contact_queue, ^{
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromDB];
        
        NSMutableArray<HNContactModel *> *allContacts = [NSMutableArray arrayWithCapacity:buddyList.count];
        for (NSString *buddy in buddyList) {
            HNContactModel *model = [[HNContactModel alloc] initWithBuddy:buddy];
            [allContacts addObject:model];
        }
        
        // 把自己也加进去
        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
        if (loginUsername && loginUsername.length > 0) {
            HNContactModel *model = [[HNContactModel alloc] initWithBuddy:loginUsername];
            [allContacts addObject:model];
        }
        
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(allContacts);
            });
        }
    });
}


/*!
 *  \~chinese
 *  从数据库获取所有的好友  功能同上
 */
- (NSMutableArray<HNContactModel *> *)getContactsFromDB {

    NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromDB];
    
    NSMutableArray<HNContactModel *> *allContacts = [NSMutableArray arrayWithCapacity:buddyList.count];
    for (NSString *buddy in buddyList) {
        HNContactModel *model = [[HNContactModel alloc] initWithBuddy:buddy];
        [allContacts addObject:model];
    }
    
    // 把自己也加进去
    NSString *loginUsername = [[EMClient sharedClient] currentUsername];
    if (loginUsername && loginUsername.length > 0) {
        HNContactModel *model = [[HNContactModel alloc] initWithBuddy:loginUsername];
        [allContacts addObject:model];
    }
    return allContacts;
}


/*!
 *  \~chinese
 *  从服务器获取所有的好友
 *
 *  @param aSuccessBlock    成功的回调
 *  @param aFailureBlock    失败的回调
 */
- (void)asynGetContactsFromServer:(void (^ __nullable)(NSMutableArray<HNContactModel *> *))complete{
    [[EMClient sharedClient].contactManager asyncGetContactsFromServer:^(NSArray *buddyList) {
        NSMutableArray<HNContactModel *> *allContacts = [NSMutableArray arrayWithCapacity:buddyList.count];
        for (NSString *buddy in buddyList) {
            HNContactModel *model = [[HNContactModel alloc] initWithBuddy:buddy];
            [allContacts addObject:model];
        }
        
        // 把自己也加进去
        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
        if (loginUsername && loginUsername.length > 0) {
            HNContactModel *model = [[HNContactModel alloc] initWithBuddy:loginUsername];
            [allContacts addObject:model];
        }
        
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(allContacts);
            });
        }
    } failure:^(EMError *aError) {
        
    }];
}


/*!
 *  \~chinese
 *  添加好友
 *  同步方法，会阻塞当前线程
 *
 *  @param aUsername  要添加的用户
 *  @param aMessage   邀请信息
 */
- (HNSDKError *)addContact:(NSString *)buddyName message:(NSString*)aMessage{
    EMError *error = [[EMClient sharedClient].contactManager addContact:buddyName message:aMessage];
    return error ? [HNSDKError errorWithEMError:error] : nil;
}

- (HNSDKError *)addContact:(NSString *)buddyName{
    EMError *error = [[EMClient sharedClient].contactManager addContact:buddyName message:@""];
    return error ? [HNSDKError errorWithEMError:error] : nil;
}



/*!
 *  \~chinese
 *  同意加好友的申请
 *
 *  同步方法，会阻塞当前线程
 *
 *  @param aUsername 申请者
 */
//- (void)acceptInvitationWithApplyEntity:(ApplyEntity *)entity completeCallback:(void (^ __nullable)(HNSDKError *error))completeCallback{
////    MBProgressHUD *HUD = [LLUtils showActivityIndicatiorHUDWithTitle:nil];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:entity.applicantUsername];
//        dispatch_async(dispatch_get_main_queue(), ^{
////            [LLUtils hideHUD:HUD animated:YES];
//            if (!error) {
//                NSString *loginUsername = [[EMClient sharedClient] currentUsername];
//                [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
//            }else {
//                [LLUtils showMessageAlertWithTitle:nil message:@"同意添加好友时发生错误"];
//            }
//            
//            if (completeCallback) {
//                completeCallback(error ? [LLSDKError errorWithEMError:error] : nil);
//            }
//        });
//    });
//    
//}


#pragma mark - 好友关系变化回调 -  环信 添加好友等回调
/**
 *  对方同意加我为好友
 *
 *  @param aUsername <#aUsername description#>
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@同意加你为好友", aUsername]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HNContactChangedNotification object:[HNContactManager sharedManager]];
    });
}

/**
 *  好友关系建立，双方都收到该回调
 *
 *  @param aUsername <#aUsername description#>
 */
- (void)didReceiveAddedFromUsername:(NSString *)aUsername {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:HNContactChangedNotification object:[HNContactManager sharedManager]];
    });
}


/**
 *  收到对方发来的好友申请请求
 *
 *  @param aUsername <#aUsername description#>
 *  @param aMessage  <#aMessage description#>
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {
    if (!aUsername) {
        return;
    }
    
    [self addNewApply:aUsername];
}


- (void)addNewApply:(NSString *)userName {
    if (userName.length > 0) {
        //new apply
//        ApplyEntity * newEntity= [[ApplyEntity alloc] init];
//        newEntity.applicantUsername = userName;
//        
//        NSString *loginName = [[EMClient sharedClient] currentUsername];
//        newEntity.receiverUsername = loginName;
//        
//        [[InvitationManager sharedInstance] addInvitation:newEntity loginUser:loginName];
        
    }
}


@end
