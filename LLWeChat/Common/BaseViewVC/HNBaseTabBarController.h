//
//  HNBaseTabBarController.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/7.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNBaseTabBarController : UITabBarController

/**
 *   设置tabBar子控制器 item 标题，以及图片
 */
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;


@end
