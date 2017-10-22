//
//  HNMessageBaseCell.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/22.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNMessageModel.h"

@interface HNMessageBaseCell : UITableViewCell


@property (nonatomic, strong) UIImageView                   *avatarImage;

@property (nonatomic, strong) UIImageView                   *bubbleImage;

@property (nonatomic, strong) UIActivityIndicatorView       *indicatorView;

@property (nonatomic, strong) UIButton                      *statusButton;

@property (nonatomic, strong) UIImageView                   *selectControl;



@property (nonatomic) BOOL                          isCellSelected;

@property (nonatomic) BOOL                          isCellEditing;

@property (nonatomic) HNMessageModel                *messageModel;


@end
