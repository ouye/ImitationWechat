//
//  MBProgressHUD+EXT.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/25.
//  Copyright © 2017年 GMBZH. All rights reserved.
//

#import "MBProgressHUD.h"

typedef enum{
    MBProgressModeOnlyText = 10,                // 文字
    MBProgressModeLoading,                      // 加载菊花
    MBProgressModeCircleLoading,                // 加载圆形
    MBProgressModeSuccess,                      // 成功
    MBProgressModeCustom                        // 自定义模式 此模式下  可传入自定义图片
    
}MBProgressMode;

@interface MBProgressHUD (EXT)

+(void)show:(NSString *)msg inView:(UIView *)view mode:(MBProgressMode *)myMode;


/** 显示成功提示 */
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success icon:(NSString*)icon;


/** 显示错误提示 */
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error icon:(NSString*)icon;


/** 隐藏提示 */
+ (void)hideHUD;


/** 提示文字 */
+ (void)showMessage:(NSString *)message;


/** 显示加载进度 圈圈提示 */
+ (void)showProgress;
+ (void)showProgress:(NSString *)msg;


@end
