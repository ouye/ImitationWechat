//
//  LLAccoutElectTextFiledView.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/7.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "LLAccoutElectTextFiledView.h"

@implementation LLAccoutElectTextFiledView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

#pragma ------  addUI   --------
- (void)loadUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.textfield];
}

#pragma ------  refrashFrame   --------
- (void)layoutSubviews{
    [super layoutSubviews];
    _nameLabel.frame = CGRectMake(10, 0, self.frame.size.width*0.1, 20);
    _textfield.frame = CGRectMake(_nameLabel.right+10, 0, self.frame.size.width*0.7, 20);
}


#pragma ------  lazy load  UI   --------
// 名字
- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorHexaRGB(0xbbbbbb);
    }
    return _nameLabel;
}

// 输入框
- (UITextField*)textfield{
    if (!_textfield) {
        _textfield = [[UITextField alloc]init];
    }
    return _textfield;
}




@end
