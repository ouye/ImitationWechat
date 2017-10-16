//
//  HNPersonalDetailsCell.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/16.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************ 联系人 详细资料 头部 cell*************/

#import <UIKit/UIKit.h>

@interface HNPersonalDetailsCell : UITableViewCell

@property (nonatomic, strong) UIImageView               *logoImgView;       // logo
@property (nonatomic, strong) UILabel                   *nameLabel;         // nameLabel
@property (nonatomic, strong) UIImageView               *sexImgView;        // sexImgView
@property (nonatomic, strong) UILabel                   *weChatNumLabel;    // weChatNumLabel
@property (nonatomic, strong) UILabel                   *nicknameLabel;     // 昵称


/**设置 创建cell */
+ (instancetype)cellWithTableView:(UITableView*)tableView reuseIdentifier:(NSString *)reuseIdentifier;

@end
