//
//  HNSearchBar.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNSearchBar.h"

// 取消按钮默认字体颜色
#define cancalTitleColor [UIColor colorWithRed:29/255.0 green:185/255.0 blue:14/255.0 alpha:1]

// 搜索默认背景颜色
#define searchBarBgColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]

@implementation HNSearchBar

// 初始化 同时设置 当搜索成第一相应者时  就显示取消 按钮 (系统自带)
+ (void)initialize {
    if (self == [HNSearchBar class]) {
        [[UIBarButtonItem appearanceWhenContainedIn: [HNSearchBar class], nil] setTintColor:cancalTitleColor];
        [[UIBarButtonItem appearanceWhenContainedIn: [HNSearchBar class], nil] setTitle:@"取消"];
    }
}

/**
 *  默认初始化 构造方法
 */
+ (instancetype)defaultSearchBar {
    return [self defaultSearchBarWithFrame:CGRectMake(0, 64, ScreenWidth, [self defaultSearchBarHeight])];
}

+ (instancetype)defaultSearchBarWithFrame:(CGRect)frame {
    HNSearchBar *searchBar = [[HNSearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = @"搜索";
    searchBar.showsCancelButton = NO;
    searchBar.barStyle = UISearchBarStyleMinimal;
    searchBar.backgroundColor = searchBarBgColor;
    
    searchBar.barTintColor = searchBarBgColor;
    searchBar.backgroundImage = [UIImage imageFromColor:[UIColor clearColor]];
    searchBar.tintColor = [UIColor colorWithRed:29/255.0 green:185/255.0 blue:14/255.0 alpha:1];
    
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.enablesReturnKeyAutomatically = YES;
    
    UITextField *searchTextField = [searchBar searchTextField];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.textColor = [UIColor blackColor];
    
    return searchBar;
}




// 获取 UISearchBar 的 UITextField
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

// 获取 UISearchBar 的 UIButton 取消按钮
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

// 取消第一相应者
- (void)resignFirstResponderWithCancelButtonRemainEnabled {
    [self resignFirstResponder];
    
    UIButton *cancelButton = [self searchCancelButton];
    [cancelButton setEnabled:YES];
}



- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated {
    [super setShowsCancelButton:showsCancelButton animated:animated];
    [self configCancelButton];
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton {
    [self setShowsCancelButton:showsCancelButton animated:NO];
}


// 设置取消 按钮 配置
- (void)configCancelButton {
    UIButton *cancelButton = [self searchCancelButton];
    if (cancelButton) {
        UIColor *color = [cancelButton titleColorForState:UIControlStateNormal];
        [cancelButton setTitleColor:color forState:UIControlStateDisabled];
    }
}

//  默认高
+ (NSInteger)defaultSearchBarHeight {
    return SEARCH_TEXT_FIELD_HEIGHT + 16;
}


@end
