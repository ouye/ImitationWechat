//
//  UIAlertController+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/28.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UIAlertController+Extensions.h"

@implementation UIAlertController (Extensions)





/**
 *  消息的提示框
 *
 *  @param title        标题
 *  @param message      内容
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __block BOOL isClick = NO;

    UIAlertAction *comfirmBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 防重复提交
        if (isClick) {
            return;
        }
        isClick = YES;
        // 回调
    }];
    [alertVC addAction:comfirmBtn];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}



/**
 *  没有取消的提示框
 *
 *  @param title        标题
 *  @param message      内容
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确定按钮回调
 */
+ (void)alertWithTitleNotCancel:(NSString *)title message:(NSString *)message formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __block BOOL isClick = NO;
    UIAlertAction *comfirmBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 防重复提交
        if (isClick) {
            return;
        }
        isClick = YES;
        // 回调
        !confirmBlock ? : confirmBlock();
    }];
    [alertVC addAction:comfirmBtn];
    if (formVC == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        [window.rootViewController presentViewController:alertVC animated:YES completion:nil];
    } else {
        [formVC presentViewController:alertVC animated:YES completion:nil];
    }
}

/**
 *  有取消的提示框
 *
 *  @param message      消息
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确定按钮回调
 */
+ (void)alertWithMessage:(NSString *)message formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock{
    [self alertWithTitle:message Message:nil formVc:formVC Confirmed:confirmBlock];
}




/**
 *  有取消的提示框
 *
 *  @param title        标题
 *  @param message      消息
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确定按钮回调
 */
+ (void)alertWithTitle:(NSString *)title Message:(NSString *)message formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 确认按钮
    __block BOOL isClick = NO;
    UIAlertAction *comfirmBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 防重复提交
        if (isClick) {
            return;
        }
        isClick = YES;
        
        !confirmBlock ? : confirmBlock();
    }];
    [alertVC addAction:comfirmBtn];

    if (formVC == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        [window.rootViewController presentViewController:alertVC animated:YES completion:nil];
    } else {
        [formVC presentViewController:alertVC animated:YES completion:nil];
    }
}


/**
 *  可以点击空白处进行取消的提示框
 *
 *  @param title        标题
 *  @param message      内容
 *  @param comfirTitle  确认按钮文本
 *  @param formVC       在哪个控制器展示
 *  @param confirmBlock 确认按钮回调
 */
+ (void)alertWithTitleClickWhiteToCancle:(NSString *)title message:(NSString *)message comfirTitle:(NSString *)comfirTitle formVc:(UIViewController *)formVC Confirmed:(void (^)())confirmBlock{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __block BOOL isClick = NO;
    
    UIAlertAction *comfirmBtn = [UIAlertAction actionWithTitle:comfirTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 防重复提交
        if (isClick) {
            return;
        }
        isClick = YES;
        
        // 回调
        !confirmBlock ? : confirmBlock();
    }];
    [alertVC addAction:comfirmBtn];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 添加遮罩按钮
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.frame = window.bounds;
    [coverBtn addTarget:alertVC action:@selector(converBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    coverBtn.backgroundColor = [UIColor clearColor];
  
    if (formVC == nil) {
        [window.rootViewController presentViewController:alertVC animated:YES completion:^{
            [alertVC.view.superview insertSubview:coverBtn belowSubview:alertVC.view];
        }];
    }else{
        [formVC presentViewController:alertVC animated:YES completion:^{
            [alertVC.view.superview insertSubview:coverBtn belowSubview:alertVC.view];
        }];
    }
}

- (void)converBtnClick:(UIButton*)button {
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:^{
//        alertVC = nil;
    }];
}

- (void)dealloc {
    DLog(@"UIAlertController销毁了");
}


@end
