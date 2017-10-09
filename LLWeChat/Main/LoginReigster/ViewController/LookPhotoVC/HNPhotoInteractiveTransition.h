//
//  HNPhotoInteractiveTransition.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/22.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConifg)();

@interface HNPhotoInteractiveTransition : UIPercentDrivenInteractiveTransition

/** 单利对象 */
+ (instancetype)sharedInstance;

#pragma -------- 属性 --------
/** 手势滑动距离站屏幕高百分比 */
@property (nonatomic, assign) CGFloat                   persent;

/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg               presentConifg;
/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL                      interation;



#pragma -------- 方法 --------
/** 给传入的 即将present的控制器 添加手势 */
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
