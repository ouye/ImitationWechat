//
//  HNPhotoBrowserAnimator.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/23.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "HNPhotoBrowserAnimator.h"
#import "HNPhotoInteractiveTransition.h"

@interface HNPhotoBrowserAnimator ()

/**判断当前动画是弹出还是消失 内部逻辑用*/
@property(nonatomic, assign, getter=isPresented) BOOL presented;

@end

@implementation HNPhotoBrowserAnimator

#pragma  ----- UIViewControllerTransitioningDelegate  系统代理-----

/**
 *   控制器Presented时 系统会自动执行
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.presented = YES;
    return self;
}

/**
 *   控制器Dismissed时 系统会自动执行
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.presented = NO;
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return [HNPhotoInteractiveTransition sharedInstance].interation? [HNPhotoInteractiveTransition sharedInstance] : nil;;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return [HNPhotoInteractiveTransition sharedInstance].interation? [HNPhotoInteractiveTransition sharedInstance] : nil;;
}

#pragma  ----- UIViewControllerAnimatedTransitioning  系统代理-----

/**
 *   转场动画时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.animatorTime?self.animatorTime:0.3;
}

/**
 *   转场动画  自定义转场动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPresented){
        [self animationForPresentView:transitionContext];
    } else{
        [self animationForDismissView:transitionContext];
    }
}

#pragma ----- private menthod 私有方法 自定义动画 -----
/**
 *   转场动画  自定义弹出动画
 */
- (void)animationForPresentView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 将执行的View添加到containerView
    [transitionContext.containerView addSubview:presentView];
    
    // 获取开始尺寸和结束尺寸
    CGRect startRect ;
    if ([self.animationPresentDelegate respondsToSelector:@selector(startRect:)]) {
        startRect = [self.animationPresentDelegate startRect:self.index];
    }
    
    CGRect endRect ;
    if ([self.animationPresentDelegate respondsToSelector:@selector(endRect:)]) {
        endRect = [self.animationPresentDelegate endRect:self.index];
    }
    
    // 获取点击的图片
    UIImageView *imageView;
    if ([self.animationPresentDelegate respondsToSelector:@selector(locImageView:)]) {
        imageView = [self.animationPresentDelegate locImageView:self.index];
    }
    
    [transitionContext.containerView addSubview:imageView];
    imageView.frame = startRect;
    
    presentView.alpha = 0;
    // 转场背景颜色
    transitionContext.containerView.backgroundColor = [UIColor blackColor];

    transitionContext.containerView.backgroundColor = self.backgroundColor?self.backgroundColor : [UIColor clearColor];
    
    // 弹出动画 动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = endRect;
    }completion:^(BOOL finished) {
        presentView.alpha = 1.0;
        [imageView removeFromSuperview];
    
        transitionContext.containerView.backgroundColor = [UIColor clearColor];
        [transitionContext completeTransition:YES];
    }];
}


/**
 *   转场动画  自定义消失动画
 */
- (void)animationForDismissView:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [dismissView removeFromSuperview];
   
    NSLog(@"--------------------------------");
    
    // 获取动画消失时 的图片
    UIImageView *imageView ;
    if ([self.animationDismissDelegate respondsToSelector:@selector(imageViewForDismissView)]) {
        imageView = [self.animationDismissDelegate imageViewForDismissView];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
    }

    [transitionContext.containerView addSubview:imageView];
    
    // 获取动画消失时 的图片的索引
    NSInteger index;
    if ([self.animationDismissDelegate respondsToSelector:@selector(indexForDismissView)]) {
        index = [self.animationDismissDelegate indexForDismissView];
    }
    
    // 动画消失 动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      
        // 获取现实小图 的 位置
        if ([self.animationPresentDelegate respondsToSelector:@selector(startRect:)]) {
            imageView.frame = [self.animationPresentDelegate startRect:index];
            
            //  Dismiss时 startRect位置 超过屏幕 时 会要 传 width height 为0
            if (imageView.frame.size.width < 1 && imageView.frame.size.height < 1) {
                imageView.alpha = 0;
            }
        }
    } completion:^(BOOL finished) {

        [transitionContext completeTransition:YES];
        toVC.view.hidden = NO;

    }];
}
@end
