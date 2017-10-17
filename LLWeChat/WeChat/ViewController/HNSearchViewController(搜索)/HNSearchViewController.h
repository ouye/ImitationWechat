//
//  HNSearchViewController.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 搜索 控制器 **************/

#import "HNBaseViewController.h"
#import "HNSearchControllerDelegate.h"
#import "HNSearchResultDelegate.h"


#define HIDE_ANIMATION_DURATION 0.3
#define SHOW_ANIMATION_DURATION 0.3

@interface HNSearchViewController : HNBaseViewController

@property (nonatomic, strong) UIViewController<HNSearchResultDelegate>*     searchResultController;


@property (nonatomic, weak) id<HNSearchControllerDelegate> delegate;


/** 单利 */
+ (instancetype)sharedInstance;

@end
