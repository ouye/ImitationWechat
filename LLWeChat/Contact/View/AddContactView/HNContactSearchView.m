
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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];

    }
    return self;
}



#pragma ----- createView and addFrame -----
- (void)createView{
    [self addSubview:self.weChatNumBagView];
    [_weChatNumBagView addSubview:self.searchImageView];
    [_weChatNumBagView addSubview:self.weChatNumLabel];
    [self addSubview:self.myWeChatNumLabel];
    [self addSubview:self.myQRcodeImageView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _weChatNumBagView.frame = CGRectMake(0, ScaleHeight(15), ScreenWidth, ScaleHeight(47));
    _searchImageView.frame = CGRectMake(ScaleWidth(22), 0, ScaleWidth(36), ScaleHeight(30));
    _searchImageView.centerY = _weChatNumBagView.centerY;
    _weChatNumLabel.frame = CGRectMake(_searchImageView.right+ScaleWidth(8), 0, ScaleWidth(220), _weChatNumBagView.height);
    
    _myWeChatNumLabel.frame = CGRectMake(ScaleWidth(100), _weChatNumBagView.bottom + ScaleHeight(10), HNLabelWith(_myWeChatNumLabel), HNLabelHight(_myWeChatNumLabel));
    _myQRcodeImageView.frame = CGRectMake(_myWeChatNumLabel.right +ScaleWidth(10), _weChatNumBagView.bottom+ ScaleHeight(10), ScaleWidth(20),ScaleWidth(20));
    _myQRcodeImageView.centerY = _myWeChatNumLabel.centerY;
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
        _searchImageView.image = [UIImage imageNamed:@"add_friend_searchicon"];
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
        _weChatNumLabel.text = @"微信号/手机号";
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
        _myWeChatNumLabel.text = @"我的微信号";
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
