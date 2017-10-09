//
//  UIViewController+Transition.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/19.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedTransitioning.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Transition)<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

/**
 *  用于自定义转场动画 present 控制器
 *  @param  toViewController    目的控制器  将要推出的控制器
 *  @param  transitioning       可以设置动画时间 等各种参数
 *  @param  completion          完成
 */
- (void)se_presentViewController:(UIViewController *)toViewController makeAnimatedTransitioning:(void (^)(AnimatedTransitioning *transitioning))block completion:(void (^ __nullable)(void))completion;


@end

NS_ASSUME_NONNULL_END
