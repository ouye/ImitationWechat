//
//  LLMainViewController.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "LLMainViewController.h"
#import "HNBaseViewController.h"

@interface LLMainViewController ()<UITabBarDelegate, UINavigationControllerDelegate>

@property (nonatomic) UITabBar *tabBar;             // 下面一排bar

@property (nonatomic) HNBaseViewController *currentViewController;

@end

@implementation LLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  －－－－－－ lazy load 懒加载 －－－－－－－－
// 下面一排bar
- (UITabBar*)tabBar{
    if (!_tabBar) {
        _tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - MAIN_BOTTOM_TABBAR_HEIGHT - NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, MAIN_BOTTOM_TABBAR_HEIGHT)];
    }
    return _tabBar;
}

@end
