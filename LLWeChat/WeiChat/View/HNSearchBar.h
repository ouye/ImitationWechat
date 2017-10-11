//
//  HNSearchBar.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HNSearchBardefaultHeight 28    // 默认高度

@interface HNSearchBar : UISearchBar


/**
 *  默认宽高等 设置的。初始化 构造方法
 */
+ (instancetype)defaultSearchBar;


/**
 *  初始化 构造方法
 */
+ (instancetype)defaultSearchBarWithFrame:(CGRect)frame;


/**
 *  获取 UISearchBar 中的 UITextField
 */
- (UITextField *)searchTextField;


/**
 *  获取 UISearchBar 中的 取消 UIButton 按钮
 */
- (UIButton *)searchCancelButton;


/**
 *  取消第一响应者身份
 */
- (void)resignFirstResponderWithCancelButtonRemainEnabled;


- (void)configCancelButton;


+ (NSInteger)defaultSearchBarHeight;


@end
