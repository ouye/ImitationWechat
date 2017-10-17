//
//  UIButton+EnlargeEdge.h
//  GCall
//
//  Created by User on 16/10/25.
//  Copyright © 2016年 gcall. All rights reserved.
//

/********* 扩大按钮点击范围分类  ********/

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

/**
 *  设置按钮 点击范围 size
 */
- (void)setEnlargeEdge:(CGSize) size;


/**
 *  设置按钮 上右下左 的点击范围
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;


@end
