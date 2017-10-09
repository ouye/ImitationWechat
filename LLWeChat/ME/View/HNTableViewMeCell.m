//
//  HNTableViewMeCell.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNTableViewMeCell.h"

@implementation HNTableViewMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        [self createView];
    }
    return self;
}

/** 创建cell 构造方法*/
+ (instancetype)createNTableViewMeCellWith:(UITableView*)tableView reuseIdentifier:(nullable NSString *)reuseIdentifier{
    HNTableViewMeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[HNTableViewMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


#pragma mark ------ create UI ------
- (void)createView{
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.WeChatIDLabel];
    [self.contentView addSubview:self.rightImage];
    [self.contentView addSubview:self.arrowImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    _avatarImage.frame = CGRectMake(ScaleWidth(13.0), ScaleHeight(11), self.height- ScaleHeight(22), self.height- ScaleHeight(22));
//    _nickNameLabel.frame = CGRectMake(_avatarImage.right+ScaleWidth(8.0), ScaleHeight(15), 200,  ScaleHeight(19));
//    _WeChatIDLabel.frame = CGRectMake(_avatarImage.right+ScaleWidth(8.0), _nickNameLabel.bottom +ScaleHeight(10), 200,  ScaleHeight(19));
//    _rightImage.frame = CGRectMake(self.right-ScaleWidth(20.0)-(self.height- ScaleHeight(30))-ScaleWidth(30), ScaleHeight(15), self.height- ScaleHeight(30),  self.height- ScaleHeight(30));
//    _rightImage.centerX = self.centerX;
//    
//    _arrowImage.frame = CGRectMake(self.right-ScaleWidth(10.0)-ScaleWidth(30), ScaleHeight(15), ScaleHeight(30),  ScaleHeight(30));
//    _avatarImage.centerX =  self.centerX;
}


#pragma mark ----------- UI懒加载 ---------------
/** 头像 */
- (UIImageView*)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc]init];
        _avatarImage.contentMode = UIViewContentModeScaleToFill;
    }
    return _avatarImage;
}

/** 昵称label */
- (UILabel*)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.font = HNFont(17.0);
        _nickNameLabel.textColor = [UIColor blackColor];
    }
    return _nickNameLabel;
}

/** 微信ID */
- (UILabel*)WeChatIDLabel{
    if (!_WeChatIDLabel) {
        _WeChatIDLabel = [[UILabel alloc]init];
        _WeChatIDLabel.textAlignment = NSTextAlignmentLeft;
        _WeChatIDLabel.font = HNFont(14.0);
        _WeChatIDLabel.textColor = [UIColor blackColor];
    }
    return _WeChatIDLabel;
}

/** Accessory 图片 */
- (UIImageView*)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.contentMode = UIViewContentModeScaleToFill;
    }
    return _rightImage;
}

/** 右边箭头 图片 */
- (UIImageView*)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc]init];
        _arrowImage.contentMode = UIViewContentModeScaleToFill;
    }
    return _arrowImage;
}


@end
