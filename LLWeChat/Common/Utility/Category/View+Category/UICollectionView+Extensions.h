//
//  UICollectionView+Extensions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Extensions)


/**
 *  滚动到顶部  第一次点击 回到第一个cell 再次点击滚动到 UITableView 顶部
 */
- (void)scrollsToTopAnimated:(BOOL)animated;

/**
 *  滚动到底部  第一次点击 回到第一个cell 再次点击滚动到 UITableView 底部
 */
- (void)scrollsToBottomAnimated:(BOOL)animated;


@end
