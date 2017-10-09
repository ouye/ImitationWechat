//
//  UITableView+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UITableView+Extensions.h"

@implementation UITableView (Extensions)


/**
 *  滚动到顶部  第一次点击 回到第一个cell 再次点击滚动到 UITableView 顶部
 */
- (void)scrollsToTopAnimated:(BOOL)animated{
    NSInteger sectionCount = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    }else{
        sectionCount = 1;
    }
    
    NSInteger count = [self.dataSource tableView:self numberOfRowsInSection:sectionCount - 1];
    if (count < 1)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if (cell) {
        [self setContentOffset:CGPointMake(0, 0) animated:animated];
    }else {
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
    }
}


/**
 *  滚动到底部  第一次点击 回到第一个cell 再次点击滚动到 UITableView 底部
 */
- (void)scrollsToBottomAnimated:(BOOL)animated {
    NSInteger sectionCount = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    }else{
        sectionCount = 1;
    }
    
    NSInteger count = [self.dataSource tableView:self numberOfRowsInSection:sectionCount - 1];
    if (count < 1)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:count - 1 inSection:sectionCount - 1];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];    // 已显示在界面上
    if (cell) {
        CGFloat offsetY = self.contentSize.height + self.contentInset.bottom - CGRectGetHeight(self.frame);
        if (offsetY < -self.contentInset.top)
            offsetY = -self.contentInset.top;
        
        [self setContentOffset:CGPointMake(0, offsetY) animated:animated];
    }else {
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}




@end
