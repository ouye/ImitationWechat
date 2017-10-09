//
//  UIScrollView+Extensions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Extensions)


@property (assign, nonatomic) CGFloat insetTop;
@property (assign, nonatomic) CGFloat insetBottom;
@property (assign, nonatomic) CGFloat insetLeft;
@property (assign, nonatomic) CGFloat insetRight;

@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) CGFloat offsetY;

@property (assign, nonatomic) CGFloat contentWidth;
@property (assign, nonatomic) CGFloat contentHeight;

/**
 *  滚动到顶部
 */
- (void)scrollToTopAnimated:(BOOL)animated;


/**
 *  滚动到底部
 */
- (void)scrollToBottomAnimated:(BOOL)animated;


/**
 *  是否已经在顶部
 */
- (BOOL)isAtTop;


/**
 *  是否已经在底部
 */
- (BOOL)isAtBottom;


/**
 *  可以滑动的最小高度
 */
- (CGFloat)minHeightRequiredToScroll;


/**
 *  可以滑动的最小宽度
 */
- (CGFloat)minWidthRequiredToScroll;

@end
