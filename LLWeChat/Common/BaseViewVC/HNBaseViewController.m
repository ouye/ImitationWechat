//
//  HNBaseViewController.m
//  HNWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNBaseViewController.h"

@interface HNBaseViewController ()

/**
 *  全屏幕侧滑手势
 */
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation HNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setFullScreenSideslip];

    //   设置TabBar item字体颜色方式  此方法可以去子控制器 使用  这里统一设置
    [self setTabBarItemTextColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setTabBarItemTextColor:[UIColor colorWithHexRGB:@"#68BB1E"] forState:UIControlStateSelected];
    
}








#pragma  ------  关于全屏侧滑与半屏侧滑的设置  ------------
/**
 *  删除全屏侧滑返回 功能 恢复原生的 半屏侧滑
 */
- (void)deleteFullScreenSideslip{

    [self.view removeGestureRecognizer:self.panGesture];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

/**
 *  设置全屏侧滑返回 功能
 */
- (void)setFullScreenSideslip{
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
     self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    self.panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:self.panGesture];
    
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

/**
 *  什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
 *  作用：拦截手势触发
*/
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    return YES;
}



#pragma  设置TabBar item字体颜色方式 ------------
/**
 *  设置TabBar item字体颜色方式
 *  @param color  颜色 state  按钮状态
 */
- (void)setTabBarItemTextColor:(UIColor*)color forState:(UIControlState)state{
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: color} forState:state];
}

@end
