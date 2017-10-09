//
//  HNConversationListCell.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNConversationListCell.h"
#import "HNChatManager.h"

@interface HNConversationListCell ()

/** 头像 */
@property (nonatomic, strong) UIImageView               *avatarImageView;

/** 消息数量 badge 徽章值 */
@property (nonatomic, strong)  UILabel                  *badgeNumLabel;

/** 姓名等标题 */
@property (nonatomic, strong) UILabel                   *titleLabel;

/** 时间label */
@property (nonatomic, strong) UILabel                   *dateLabel;

/** 消息发送状态 image */
@property (nonatomic, strong) UIImageView               *messageStatusImageView;

/** 最后一条消息label */
@property (nonatomic, strong) UILabel                   *lastMessageLabel;

@end

@implementation HNConversationListCell


/*** 构造方法创建 复用cell **/
+ (instancetype)createHNConversationListCell:(UITableView*)tableView reuseIdentifier:(nullable NSString *)reuseIdentifier{
    HNConversationListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self createView];
    }
    return self;
}


#pragma mark ------ create UI ------
- (void)createView{
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.badgeNumLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.messageStatusImageView];
    [self.contentView addSubview:self.lastMessageLabel];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _avatarImageView.frame = CGRectMake(ScaleWidth(8), ScaleWidth(8), self.height - ScaleWidth(16) , self.height - ScaleWidth(16));
    _badgeNumLabel.frame = CGRectMake(_avatarImageView.right - ScaleWidth(9),_avatarImageView.y -ScaleWidth(9)  , ScaleWidth(18), ScaleWidth(18));
    _titleLabel.frame = CGRectMake(_avatarImageView.right + ScaleWidth(10), ScaleHeight(11), ScreenWidth - ScaleWidth(100-_avatarImageView.right) , HNLabelHight(_titleLabel));
    _dateLabel.frame = CGRectMake(_titleLabel.right + ScaleWidth(10), ScaleHeight(11), ScaleWidth(80) , HNLabelHight(_titleLabel));
    _messageStatusImageView.frame = CGRectMake(_avatarImageView.right + ScaleWidth(10),_titleLabel.bottom + ScaleHeight(11), ScaleHeight(19) , ScaleHeight(19));

    _lastMessageLabel.frame = CGRectMake(_messageStatusImageView.right + ScaleWidth(10),_titleLabel.bottom + ScaleHeight(11), ScreenWidth-_messageStatusImageView.right - ScaleWidth(10) , HNLabelHight(_titleLabel));
}



/**
 *  设置数据
 */
- (void)setConversationModel:(HNConversationModel *)conversationModel {
    _conversationModel = conversationModel;
    self.titleLabel.text = conversationModel.nickName;
    self.dateLabel.text = conversationModel.latestMessageTimeString;
    [self setUnreadNumber:conversationModel.unreadMessageNumber];
    
    HNMessageStatus status = [conversationModel latestMessageStatus];
    switch (status) {
        case HNMessageStatusFailed:
            self.messageStatusImageView.hidden = NO;
            self.messageStatusImageView.image = [UIImage imageNamed:@"MessageSendFail"];
//            self.latestMessageLabelConstraint.constant = 31;
            break;
        case HNMessageStatusDelivering:
            self.messageStatusImageView.hidden = NO;
            self.messageStatusImageView.image = [UIImage imageNamed:@"MessageListSending"];
//            self.latestMessageLabelConstraint.constant = 31;
            break;
        case HNMessageStatusSuccessed:
        case HNMessageStatusPending:
            self.messageStatusImageView.hidden = YES;
//            self.latestMessageLabelConstraint.constant = 31 - 19 - 2;
            break;
        default:
            break;
    }
    
    if (conversationModel.draft.length == 0) {
        self.lastMessageLabel.text = conversationModel.latestMessage;
    }else {
        NSString *string = [NSString stringWithFormat:@"[草稿] %@", conversationModel.draft];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(0, 4)];
        self.lastMessageLabel.attributedText = attributedString;
    }
    
    self.avatarImageView.image = [UIImage imageNamed:@"user"];
    
}

- (void)setUnreadNumber:(NSInteger)unreadCount {
//    [moreLabel removeFromSuperview];
    if (unreadCount == 0) {
        self.badgeNumLabel.text = nil;
        self.badgeNumLabel.hidden = YES;
    }else {
        if (unreadCount < 10) {
            self.badgeNumLabel.text = [NSString stringWithFormat:@"%ld", (long)unreadCount];
//            self.badgeNumWidthConstraint.constant = 18;
        }else if(unreadCount < 100) {
            self.badgeNumLabel.text = [NSString stringWithFormat:@"%ld", (long)unreadCount];
//            self.badgeNumWidthConstraint.constant = self.badgeNumLabel.intrinsicContentSize.width + 12;
        }else {
            self.badgeNumLabel.text = nil;
//            self.badgeNumWidthConstraint.constant = moreLabel.intrinsicContentSize.width + 12;
//            [self.contentView addSubview:moreLabel];
            
        }
        
        [self.badgeNumLabel layoutIfNeeded];
//        if (moreLabel.superview) {
//            CGRect frame = self.badgeNumLabel.frame;
//            frame.origin.y -= 3.5;
//            moreLabel.frame = frame;
//        }
        
        self.badgeNumLabel.hidden = NO;
    }
}


#pragma mark - 标为已读、未读

/**
 *  标记为已读
 */
- (void)markAllMessageAsRead{
    [self setUnreadNumber:0];
    
    [[HNChatManager sharedManager] markAllMessagesAsRead:self.conversationModel];
}

/**
 *  标记为未读
 */
- (void)markMessageAsNotRead {
    NOT_SUPPORT_ALERT;
}



#pragma mark ------------ UI懒加载 ------------
/** 头像 */
- (UIImageView*)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _avatarImageView;
}

/** 消息数量 badge 徽章值 */
- (UILabel*)badgeNumLabel{
    if (!_badgeNumLabel) {
        _badgeNumLabel = [[UILabel alloc]init];
        _badgeNumLabel.textAlignment = NSTextAlignmentCenter;
        _badgeNumLabel.font = HNFont(12);
        _badgeNumLabel.backgroundColor = [UIColor redColor];
        _badgeNumLabel.textColor = [UIColor whiteColor];
        _badgeNumLabel.layer.cornerRadius = 9;
        _badgeNumLabel.clipsToBounds = YES;
    }
    return _badgeNumLabel;
}

/** 时间label */
- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = HNFont(13);
        _dateLabel.textColor = [UIColor blackColor];
    }
    return _dateLabel;
}

/** 姓名等标题 */
- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = HNFont(17);
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

/** 消息发送状态 image */
- (UIImageView*)messageStatusImageView{
    if (!_messageStatusImageView) {
        _messageStatusImageView = [[UIImageView alloc]init];
        _messageStatusImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _messageStatusImageView;
}

/** 最后一条消息label */
- (UILabel*)lastMessageLabel{
    if (!_lastMessageLabel) {
        _lastMessageLabel = [[UILabel alloc]init];
        _lastMessageLabel.textAlignment = NSTextAlignmentLeft;
        _lastMessageLabel.font = HNFont(14);
        _lastMessageLabel.textColor = [UIColor blackColor];
    }
    return _lastMessageLabel;
}


@end
