//
//  HNSearchBar.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/******* 重写UISearchBar ******/

#import <UIKit/UIKit.h>

#define SEARCH_TEXT_FIELD_HEIGHT 28

@interface HNSearchBar : UISearchBar

/**
 *  默认初始化 构造方法
 */
+ (instancetype)defaultSearchBar;


/**
 *  初始化 构造方法
 */
+ (instancetype)defaultSearchBarWithFrame:(CGRect)frame;

/**
 *  取消第一相应者
 */
- (void)resignFirstResponderWithCancelButtonRemainEnabled;


/** 
 *  获取UISearchBar 的 UITextField
 */
- (UITextField *)searchTextField;


/**
 *  获取 UISearchBar 的 UIButton 取消按钮
 */
- (UIButton *)searchCancelButton;


/**
 *  设置取消 按钮 配置
 */
- (void)configCancelButton;

@end
