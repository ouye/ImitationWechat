//
//  HNSearchResultDelegate.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/21.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HNSearchViewController;

@protocol HNSearchControllerDelegate <NSObject>

@optional

- (void)willDismissSearchController:(HNSearchViewController *)searchController;

- (void)didDismissSearchController:(HNSearchViewController *)searchController;

- (void)willPresentSearchController:(HNSearchViewController *)searchController;

- (void)didPresentSearchController:(HNSearchViewController *)searchController;

@end
