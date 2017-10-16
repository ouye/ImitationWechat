//
//  HNPersonalDetailsCell.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/16.
//  Copyright © 2017年 GYJZH. All rights reserved.
//
/************ 联系人 详细资料 头部 cell*************/

#import "HNPersonalDetailsCell.h"

@implementation HNPersonalDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createView];
        [self addFrame];
    }
    return self;
}

/**设置 创建cell */
+ (instancetype)cellWithTableView:(UITableView*)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    HNPersonalDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[HNPersonalDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


#pragma ----- createView and addframe -------
- (void)createView{
    [self.contentView addSubview:self.logoImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.sexImgView];
    [self.contentView addSubview:self.weChatNumLabel];
    [self.contentView addSubview:self.nicknameLabel];
}


- (void)addFrame{
    _logoImgView.frame = CGRectMake(ScaleWidth(15), ScaleWidth(10), ScaleWidth(60), ScaleWidth(60));
    _nameLabel.frame   = CGRectMake(_logoImgView.right+ScaleWidth(15), ScaleWidth(10), HNLabelWith(_nameLabel), HNLabelHight(_nameLabel));
    _sexImgView.frame  = CGRectMake(_nameLabel.right+ScaleWidth(15), ScaleWidth(10), ScaleWidth(20), ScaleWidth(20));
    _weChatNumLabel.frame = CGRectMake(_logoImgView.right+ScaleWidth(15),  _nameLabel.bottom +ScaleWidth(8), HNLabelWith(_nameLabel), HNLabelHight(_nameLabel));
    _nicknameLabel.frame = CGRectMake(_logoImgView.right+ScaleWidth(15), _nameLabel.bottom + ScaleWidth(8), HNLabelWith(_nameLabel), HNLabelHight(_nameLabel));
}

#pragma  ------ lazy load UI ------
- (UIImageView*)logoImgView{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc]init];
    }
    return _logoImgView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView*)sexImgView{
    if (!_sexImgView) {
        _sexImgView = [[UIImageView alloc]init];
    }
    return _sexImgView;
}

- (UILabel*)weChatNumLabel{
    if (!_weChatNumLabel) {
        _weChatNumLabel = [[UILabel alloc]init];
        _weChatNumLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _weChatNumLabel;
}

- (UILabel*)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nicknameLabel;
}


@end
