//
//  HNContactSearchView.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/********* 添加朋友控制器中 搜索view **********/

#import <UIKit/UIKit.h>

@interface HNContactSearchView : UIView

@property (nonatomic, strong) UIView                *weChatNumBagView;         // 输入微信号背景view
@property (nonatomic, strong) UIImageView           *searchImageView;       // 搜索图标
@property (nonatomic, strong) UILabel               *weChatNumLabel;        // 搜索输入框

@property (nonatomic, strong) UILabel               *myWeChatNumLabel;      // 我的微信号
@property (nonatomic, strong) UIImageView           *myQRcodeImageView;     // 我的微信二维码


@end
