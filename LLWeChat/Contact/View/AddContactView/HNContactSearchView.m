
//
//  HNContactSearchView.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/********* 添加朋友控制器中 搜索view **********/

#import "HNContactSearchView.h"

@implementation HNContactSearchView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

#pragma ----- createView and addFrame -----
- (void)createView{
    [self addSubview:self.weChatNumBagView];
    [self addSubview:self.searchImageView];
    [self addSubview:self.weChatNumLabel];
    [self addSubview:self.myWeChatNumLabel];
    [self addSubview:self.myQRcodeImageView];
}



#pragma mark ------------ UI懒加载 ------------
 // 输入微信号背景view
- (UIView*)weChatNumBagView{
    if (!_weChatNumBagView) {
        _weChatNumBagView = [[UIView alloc]init];
        _weChatNumBagView.backgroundColor = [UIColor whiteColor];
    }
    return _weChatNumBagView;
}

// 搜索图标
- (UIImageView*)searchImageView{
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc]init];
        _searchImageView.contentMode = UIViewContentModeScaleAspectFit;
        _myQRcodeImageView.image = [UIImage imageNamed:@"add_friend_searchicon"];
    }
    return _searchImageView;
}


// 搜索输入框
- (UILabel*)weChatNumLabel{
    if (!_weChatNumLabel) {
        _weChatNumLabel = [[UILabel alloc]init];
        _weChatNumLabel.textAlignment = NSTextAlignmentLeft;
        _weChatNumLabel.font = HNFont(15);
        _weChatNumLabel.textColor = UIColorRGB(146, 146, 146);
    }
    return _weChatNumLabel;
}

// 我的微信号
- (UILabel*)myWeChatNumLabel{
    if (!_myWeChatNumLabel) {
        _myWeChatNumLabel = [[UILabel alloc]init];
        _myWeChatNumLabel.textAlignment = NSTextAlignmentLeft;
        _myWeChatNumLabel.font = HNFont(14);
        _myWeChatNumLabel.textColor = UIColorRGB(19, 19, 20);
    }
    return _myWeChatNumLabel;
}

// 我的微信二维码
- (UIImageView*)myQRcodeImageView{
    if (!_myQRcodeImageView) {
        _myQRcodeImageView = [[UIImageView alloc]init];
        _myQRcodeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _myQRcodeImageView.image = [UIImage imageNamed:@"add_friend_myQR"];
    }
    return _myQRcodeImageView;
}

@end
