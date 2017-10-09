//
//  UIScrollView+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UIScrollView+Extensions.h"

@implementation UIScrollView (Extensions)

- (void)setInsetTop:(CGFloat)top{
    UIEdgeInsets inset = self.contentInset;
    inset.top = top;
    self.contentInset = inset;
}

- (CGFloat)insetTop{
    return self.contentInset.top;
}

- (void)setInsetBottom:(CGFloat)bottom{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = bottom;
    self.contentInset = inset;
}

- (CGFloat)insetBottom{
    return self.contentInset.bottom;
}

- (void)setInsetLeft:(CGFloat)left{
    UIEdgeInsets inset = self.contentInset;
    inset.left = left;
    self.contentInset = inset;
}

- (CGFloat)insetLeft{
    return self.contentInset.left;
}

- (void)setInsetRight:(CGFloat)right{
    UIEdgeInsets inset = self.contentInset;
    inset.right = right;
    self.contentInset = inset;
}

- (CGFloat)insetRight{
    return self.contentInset.right;
}

- (void)setOffsetX:(CGFloat)offsetX{
    CGPoint offset = self.contentOffset;
    offset.x = offsetX;
    self.contentOffset = offset;
}

- (CGFloat)offsetX{
    return self.contentOffset.x;
}

- (void)setOffsetY:(CGFloat)offsetY{
    CGPoint offset = self.contentOffset;
    offset.y = offsetY;
    self.contentOffset = offset;
}

- (CGFloat)offsetY{
    return self.contentOffset.y;
}

- (void)setContentWidth:(CGFloat)contentWidth{
    CGSize size = self.contentSize;
    size.width = contentWidth;
    self.contentSize = size;
}

- (CGFloat)contentWidth{
    return self.contentSize.width;
}

- (void)setContentHeight:(CGFloat)contentHeight{
    CGSize size = self.contentSize;
    size.height = contentHeight;
    self.contentSize = size;
}

- (CGFloat)contentHeight{
    return self.contentSize.height;
}


- (BOOL)isAtTop {
    return self.contentOffset.y <= -self.contentInset.top;
}

- (BOOL)isAtBottom {
    return  self.contentSize.height - self.contentOffset.y + self.contentInset.bottom <= CGRectGetHeight(self.frame);
}

/**
 *  滚动到顶部
 */
- (void)scrollToTopAnimated:(BOOL)animated{
    [self setContentOffset:CGPointMake(0, -self.contentInset.top) animated:animated];
}


/**
 *  滚动到底部
 */
- (void)scrollToBottomAnimated:(BOOL)animated{
    [self setContentOffset:CGPointMake(0, self.contentSize.height - (CGRectGetHeight(self.frame) - self.contentInset.bottom)) animated:animated];
}

/**
 *  可以滑动的最小高度
 */
- (CGFloat)minHeightRequiredToScroll {
    return CGRectGetHeight(self.frame) - self.contentInset.top - self.contentInset.bottom;
}

/**
 *  可以滑动的最小宽度
 */
- (CGFloat)minWidthRequiredToScroll {
    return CGRectGetWidth(self.frame) - self.contentInset.left - self.contentInset.right;
}

@end
