//
//  HNTableViewMeCell.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNTableViewMeCell : UITableViewCell

/** 头像 */
@property (nonatomic, strong) UIImageView           *avatarImage;

/** 昵称label */
@property (nonatomic, strong) UILabel               *nickNameLabel;

/** 微信ID */
@property (nonatomic, strong) UILabel               *WeChatIDLabel;

/** Accessory 图片 */
@property (nonatomic, strong) UIImageView           *rightImage;

/** 右边箭头 图片 */
@property (nonatomic, strong) UIImageView           *arrowImage;


/** 创建cell 构造方法*/
+ (instancetype)createNTableViewMeCellWith:(UITableView*)tableView reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end
