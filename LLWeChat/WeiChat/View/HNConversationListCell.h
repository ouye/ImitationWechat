//
//  HNConversationListCell.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNConversationModel.h"

static NSString *HNConversationListCellID = @"HNConversationListCellID";

@interface HNConversationListCell : UITableViewCell

@property (nonatomic, strong) HNConversationModel           *conversationModel;

/**
 *  标记为已读
 */
- (void)markAllMessageAsRead;


/*
 * SDK不支持该功能 标记未读
 * */
- (void)markMessageAsNotRead;


/*** 构造方法创建 复用cell **/
+ (instancetype)createHNConversationListCell:(UITableView*)tableView reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end
