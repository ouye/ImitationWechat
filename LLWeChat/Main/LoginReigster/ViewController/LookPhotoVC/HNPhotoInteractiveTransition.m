//
//  HNPhotoInteractiveTransition.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/22.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNPhotoInteractiveTransition.h"

@interface HNPhotoInteractiveTransition ()

/** 即将present的控制器 */
@property (nonatomic, weak) UIViewController         *presentVc;

@end

@implementation HNPhotoInteractiveTransition

/** 单利对象 */
instance_implementation(HNPhotoInteractiveTransition)


/** 给传入的 即将present的控制器 添加手势 */
- (void)addPanGestureForViewController:(UIViewController *)viewController{

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.presentVc = viewController;
    [viewController.view addGestureRecognizer:pan];
}



/**
 *  手势过渡的过程
 */
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture{
   
    // 移动距离
    CGFloat  moveDistance ;
    
    // 手势百分比
    CGFloat persent ;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            moveDistance = 0;
            persent = 0;
        }break;
        case UIGestureRecognizerStateEnded:{
            moveDistance = 0;
            persent = 0;
        }break;
        default:
            break;
    }
    
    
    // 获取的值 都是 开始移动到结束移动的  绝对值
    CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
    
    // 用于外部取用
    [HNPhotoInteractiveTransition sharedInstance].persent = persent;
    
    // 清零
    [panGesture setTranslation:CGPointMake(0, 0) inView:panGesture.view];
    moveDistance += transitionY;

    // 手势滑动屏幕距离百分比
    persent = moveDistance / panGesture.view.frame.size.height;
    
    
    NSLog(@"+++++++++++++  百分比  %lf",persent);

    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //手势开始的时候标记手势状态，并开始相应的事件
            [HNPhotoInteractiveTransition sharedInstance].interation = YES;
            [self startGesture];
        }break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
        }break;
        case UIGestureRecognizerStateEnded:{
        
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            [HNPhotoInteractiveTransition sharedInstance].interation = NO;
            [self finishInteractiveTransition];

            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }break;
        default:
            break;
    }
}

//开始dismiss 相应的事件
- (void)startGesture{
    [_presentVc dismissViewControllerAnimated:YES completion:nil];
}







@end
