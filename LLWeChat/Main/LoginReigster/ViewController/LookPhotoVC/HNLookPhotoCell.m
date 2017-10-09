
//
//  HNLookPhotoCell.m
//  HNMarketProject
//
//  Created by chenwen on 2017/9/19.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNLookPhotoCell.h"

@implementation HNLookPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}


-(HNPhotoView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[HNPhotoView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    return _scrollView;
}



@end
