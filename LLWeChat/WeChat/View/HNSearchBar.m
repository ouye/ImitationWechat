
//
//  HNSearchBar.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNSearchBar.h"

// 搜索背景颜色 颜色
#define searchBagColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]

// 取消按钮 字体颜色
#define cancelTextColor [UIColor colorWithRed:29/255.0 green:185/255.0 blue:14/255.0 alpha:1]

@implementation HNSearchBar


/**
 *  初始化搜索 成为第一响应者时 出现 取消按钮 设置取消按钮 字体颜色
 */
+ (void)initialize {
    if (self == [HNSearchBar class]) {
        [[UIBarButtonItem appearanceWhenContainedIn: [HNSearchBar class], nil] setTintColor:cancelTextColor];
        [[UIBarButtonItem appearanceWhenContainedIn: [HNSearchBar class], nil] setTitle:@"取消"];
    }
}

/**
 *  默认宽高等 设置的。初始化 构造方法
 */
+ (instancetype)defaultSearchBar{
    return [self defaultSearchBarWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, [self defaultSearchBarHeight])];
}


/**
 *  初始化 构造方法
 */
+ (instancetype)defaultSearchBarWithFrame:(CGRect)frame {
    HNSearchBar *searchBar = [[HNSearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = @"搜索";
    searchBar.showsCancelButton = NO;
    searchBar.barStyle = UISearchBarStyleMinimal;
    searchBar.backgroundColor = searchBagColor;
    
    searchBar.barTintColor = searchBagColor;
    searchBar.backgroundImage = [UIImage imageFromColor:[UIColor clearColor]];
    searchBar.tintColor = [UIColor colorWithRed:29/255.0 green:185/255.0 blue:14/255.0 alpha:1];
    
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.enablesReturnKeyAutomatically = YES;
    
    UITextField *searchTextField = [searchBar searchTextField];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.textColor = [UIColor blackColor];
    searchTextField.layer.borderWidth = 0.5;
    searchTextField.layer.borderColor = [UIColor blackColor].CGColor;
    searchTextField.layer.cornerRadius = 3;
    return searchBar;
}

// 默认 HNSearchBar 高
+ (NSInteger)defaultSearchBarHeight{
    return HNSearchBardefaultHeight + 16;
}


/**
 *  取消第一响应者身份
 */
- (void)resignFirstResponderWithCancelButtonRemainEnabled {
    [self resignFirstResponder];
    UIButton *cancelButton = [self searchCancelButton];
    [cancelButton setEnabled:YES];
}

/**
 *  获取 UISearchBar 中的 UITextField
 */
- (UITextField *)searchTextField {
    UITextField *searchTextField = nil;
    for (UIView* subview in self.subviews[0].subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            searchTextField = (UITextField*)subview;
            break;
        }
    }
    NSAssert(searchTextField, @"UISearchBar结构改变");
    return searchTextField;
}


/**
 *  获取 UISearchBar 中的 取消 UIButton 按钮
 */
- (UIButton *)searchCancelButton {
    UIButton *btn;
    NSArray<UIView *> *subviews = self.subviews[0].subviews;
    for(UIView *view in subviews) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            btn = (UIButton *)view;
            break;
        }
    }
    return btn;
}

// 重写父类方法
- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated {
    [super setShowsCancelButton:showsCancelButton animated:animated];
    
    [self configCancelButton];
}


- (void)setShowsCancelButton:(BOOL)showsCancelButton {
    [self setShowsCancelButton:showsCancelButton animated:NO];
}


- (void)configCancelButton {
    UIButton *cancelButton = [self searchCancelButton];
    if (cancelButton) {
        UIColor *color = [cancelButton titleColorForState:UIControlStateNormal];
        [cancelButton setTitleColor:color forState:UIControlStateDisabled];
    }
}
@end
