//
//  HNBaseViewController.h
//  HNWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNBaseViewController : UIViewController





#pragma  关于全屏侧滑与半屏侧滑的设置  ------------
/**
 *  设置全屏侧滑返回 功能
 */
- (void)setFullScreenSideslip;

/**
 *  删除全屏侧滑返回 功能 恢复原生的 半屏侧滑  在子类中 执行 此方式 该子类控制器就 删除啦 全屏侧滑功能
 */
- (void)deleteFullScreenSideslip;


#pragma  设置TabBar item字体颜色方式 ------------
/**
 *  设置TabBar item字体颜色方式   
 *  @param color  颜色 state  按钮状态
 */
- (void)setTabBarItemTextColor:(UIColor*)color forState:(UIControlState)state;




@end
