//
//  UIAlertController+Extensions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/28.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extensions)



/**
 *  消息的提示框
 *
 *  @param title        标题
 *  @param message      内容
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  没有取消的提示框
 *
 *  @param title        标题
 *  @param message      内容
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确定按钮回调
 */
+ (void)alertWithTitleNotCancel:(NSString *)title message:(NSString *)message formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock;


/**
 *  有取消的提示框
 *
 *  @param message      消息
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确定按钮回调
 */
+ (void)alertWithMessage:(NSString *)message formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock;


/**
 *  有取消的提示框
 *
 *  @param title        标题
 *  @param message      消息
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确定按钮回调
 */
+ (void)alertWithTitle:(NSString *)title Message:(NSString *)message formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock;




/**
 *  可以点击空白处进行取消的提示框
 *
 *  @param title        标题
 *  @param message      内容
 *  @param comfirTitle  确认按钮文本
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确认按钮回调
 */
+ (void)alertWithTitleClickWhiteToCancle:(NSString *)title message:(NSString *)message comfirTitle:(NSString *)comfirTitle formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock;

@end
