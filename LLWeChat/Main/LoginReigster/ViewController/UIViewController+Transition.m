//
//  UIViewController+Transition.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/19.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <objc/runtime.h>
#import "TransitionConst.h"

@implementation UIViewController (Transition)


/**
 *  runtime 动态加属性
 */
- (void)setTransitioning:(AnimatedTransitioning *)transitioning {
    objc_setAssociatedObject(self, @selector(transitioning), transitioning, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AnimatedTransitioning *)transitioning {
    return objc_getAssociatedObject(self, @selector(transitioning));
}


/**
 *  用于自定义转场动画 present 控制器
 *  @param  toViewController    目的控制器  将要推出的控制器
 *  @param  transitioning       可以设置动画时间 等各种参数
 *  @param  completion          完成
 */
- (void)se_presentViewController:(UIViewController *)toViewController makeAnimatedTransitioning:(void (^)(AnimatedTransitioning *transitioning))block completion:(void (^ __nullable)(void))completion{
    toViewController.transitioningDelegate = toViewController;
    toViewController.modalPresentationStyle = UIModalPresentationCustom;
    AnimatedTransitioning *transitioning = [[AnimatedTransitioning alloc] init];
    block(transitioning);
    transitioning.transitionType = XXTransitionTypePresent;
    toViewController.transitioning = transitioning;
    [self presentViewController:toViewController animated:YES completion:completion];
}



#pragma mark  delegate   -------- Present Dismiss ---------
/**
 *   Present  执行Present时 系统会调用这个方法
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    presented.xx_interactive = [[XXInteractiveTransition alloc] initWithTansitionType:XXTransitionTypeDismiss animationKey:presented.xx_transitioning.animationKey];
//    [presented.xx_interactive addFullScreenGestureToViewController:presented];
    return presented.transitioning;
}

/**
 *   Dismiss  执行Dismiss时 系统会调用这个方法
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AnimatedTransitioning *transitioning = self.transitioning;
    transitioning.transitionType = XXTransitionTypeDismiss;
    return transitioning;
}









@end
