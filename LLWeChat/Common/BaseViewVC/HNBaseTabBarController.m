
//
//  HNBaseTabBarController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/7.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNBaseTabBarController.h"
#import "HNBaseNavigationController.h"

@interface HNBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation HNBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}



/**
 *   设置tabBar子控制器 item 标题，以及图片
 */
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HNBaseNavigationController  *nav = [[HNBaseNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
