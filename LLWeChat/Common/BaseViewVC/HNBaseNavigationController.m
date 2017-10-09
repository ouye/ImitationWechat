//
//  LLBaseNavigationController.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/9.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNBaseNavigationController.h"

@interface HNBaseNavigationController ()

@end

@implementation HNBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 是否支持旋转
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;        // 在栈中最顶部的控制权
}

// 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}



- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}



@end
