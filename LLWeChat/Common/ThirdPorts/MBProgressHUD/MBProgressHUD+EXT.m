//
//  MBProgressHUD+EXT.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/25.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "MBProgressHUD+EXT.h"

@implementation MBProgressHUD (EXT)


/** 显示成功提示 */
+ (void)showSuccess:(NSString *)success{
    [self show:success font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:@"success.png" view:nil mode:MBProgressModeSuccess afterDelay:0];
}
+ (void)showSuccess:(NSString *)success icon:(NSString*)icon{
    [self show:success font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:icon?icon:@"success.png" view:nil mode:MBProgressModeSuccess afterDelay:0];
}

/** 显示错误提示 */
+ (void)showError:(NSString *)error{
    [self show:error font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:@"error.png" view:nil mode:MBProgressModeCustom afterDelay:0];
}
+ (void)showError:(NSString *)error icon:(NSString*)icon{
    [self show:error font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:icon?icon:@"error.png" view:nil mode:MBProgressModeCustom afterDelay:0];
}


/** 隐藏提示 */
+ (void)hideHUD{
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}



/** 提示文字 */
+ (void)showMessage:(NSString *)message{
    [self show:message font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:nil view:nil mode:MBProgressModeOnlyText afterDelay:0];
}




/** 显示加载进度 圈圈提示 */
+ (void)showProgress{
    [self show:@"加载中..." font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:nil view:nil mode:MBProgressModeLoading afterDelay:10];
}
+ (void)showProgress:(NSString *)msg{
    [self show:msg font:nil textColor:nil bagColor:nil dimBackground:nil Margin:0 icon:nil view:nil mode:MBProgressModeLoading afterDelay:10];
}





/**
 *  设置 HNProgressHUD  基本属性的方法体
 *  @param  text            提示内容
 *  @param  font            提示内容字体大小     想默认 填 nil    [UIFont boldSystemFontOfSize:12.0f]
 *  @param  textColor       提示字体颜色        想默认 填 nil    [UIColor whiteColor]
 *  @param  color           提示框背景颜色       想默认 填 nil    [UIColor blackColor]
 *  @param  dimBackground   是否显示全屏幕背景
 *  @param  margin          提示框边界大小       想默认 填 0    20.f框架默认值
 *  @param  icon            MBProgressHUDModeCustomView 模式下 自定义图片
 *  @param  view            显示的view
 *  @param  myMode          显示的模式
 *  @param  delay           显示的消失时间      想默认 填 0     1秒 默认
 *
 */
+ (void)show:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor bagColor:(UIColor*)color dimBackground:(BOOL)dim Margin:(CGFloat)margin icon:(NSString *)icon view:(UIView *)view mode:(MBProgressMode )myMode afterDelay:(CGFloat)delay{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    //如果已有弹框，先消失
    [MBProgressHUD hideHUDForView:view animated:YES];
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    // 快速显示一个提示信息
    MBProgressHUD  *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 是否全屏幕透明背景
    progressHUD.dimBackground = dim;
    
    // 提示框背景颜色      框架 默认 [UIColor blackColor]
    progressHUD.color = color?color:[UIColor blackColor];
    
    // 提示框边界大小      20.f框架默认值
    CGFloat defutMargin = margin>0?margin:20.0f;
    [progressHUD setMargin:defutMargin];           // 边界
    
    // 隐藏时候从父控件中移除
    [progressHUD setRemoveFromSuperViewOnHide:YES];
    
    // 提示字 内容
    progressHUD.label.text = text;
    
    // 提示字体颜色             框架默认颜色
    progressHUD.contentColor = textColor? textColor:[UIColor whiteColor];
    
    // 提示字 大小        12.0f  框架默认的
    progressHUD.label.font = font?font:[UIFont boldSystemFontOfSize:16.0f];
    
    // 秒之后再消失       默认 1秒
    [progressHUD hideAnimated:YES afterDelay:delay>0?delay:1];
    
    switch ((NSInteger)myMode) {
        case MBProgressModeOnlyText:
            progressHUD.mode = MBProgressHUDModeText;
            break;
            
        case MBProgressModeLoading:
            progressHUD.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case MBProgressModeCircleLoading:
            progressHUD.mode = MBProgressHUDModeDeterminate;
            break;
            
        case MBProgressModeSuccess:{
            progressHUD.mode = MBProgressHUDModeCustomView;
            progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success"]]];
        }
            break;
        case MBProgressModeCustom:{
            progressHUD.mode = MBProgressHUDModeCustomView;
            progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
        }break;
        default:
            break;
    }
}

@end
