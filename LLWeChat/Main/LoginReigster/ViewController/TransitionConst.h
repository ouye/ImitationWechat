//
//  TransitionConst.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/19.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XXTransitionType) {
    XXTransitionTypePresent,
    XXTransitionTypeDismiss,
    XXTransitionTypePush,
    XXTransitionTypePop
};

typedef NS_ENUM(NSInteger,XXBackGesture){
    XXBackGestureNone, //禁用手势
    XXBackGesturePanLeft,
    XXBackGesturePanRight,
    XXBackGesturePanUp,
    XXBackGesturePanDown,
};

typedef NS_ENUM(NSInteger,XXPopGestureType){
    XXPopGestureTypeFullScreen, //全屏滑动手势
    XXPopGestureTypeScreenEdge,     //边缘滑动手势
    XXPopGestureTypeForbidden,      //禁用手势
    XXPopGestureTypeAsGlobal        //遵从全局手势设置，全局手势设置该值则取XXPopGestureTypeFullScreen
};

typedef void(^XXAnimationBlock)(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration);

extern NSString *const TransitionTypePush;
extern NSString *const TransitionTypePop;
extern NSString *const TransitionTypePresent;
extern NSString *const TransitionTypeDismiss;

@interface TransitionConst : NSObject

@end
