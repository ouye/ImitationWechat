//
//  UIImage+Extensions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/15.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

#pragma -----------  常用方法  --------------
/**
 *  给图片切圆角  解决 离屏绚烂问题 ()
 *  @param  radius   圆角大小
 *  @return image
 */
-(instancetype)imageWithCornerRadius:(CGFloat)radius;


/**
 *  通过颜色来生成一个纯色图片
 *  @param  color  颜色
 *  @return image
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  通过颜色尺寸来生成一个纯色图片
 *  @param  color  颜色
 *  @param  size   获取的图片尺寸大小
 *  @return image
 */
+ (UIImage *)imageFromColor:(UIColor *)color andSize:(CGSize)size;




#pragma -----------  截图等不常用 --------------
/**
 *  传入view 将该 view截图成图片
 *  @param   view       试图view
 *  @return           UIImage
 */
+ (UIImage *)imageFromView:(UIView *)view;


/**
 *  截取view中某个区域生成一张图片
 *  @param  view  view description
 *  @param  scope 需要截取的view中的某个区域frame
 *  @return image
 */
+ (UIImage *)imageFromView:(UIView *)view scope:(CGRect)scope;


/**
 *  从图片中按指定的位置大小截取图片的一部分
 *  @param  image UIImage image 原始的图片
 *  @param  rect  CGRect rect   要截取的区域
 *  @return UIImage
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

/**
 *   同上  @param  rect 要截取的区域
 */
- (UIImage *)imageFromImage:(CGRect)rect;

- (UIImage *)imageFromImage:(CGRect)rect opaque:(BOOL)opaque scale:(CGFloat)scale;




#pragma -----------  关于聊天常用 ------------
/**
 *  聊天气泡指定区域拉伸图片 角不变形方法体 
 */
- (UIImage *)resizableImage;




@end
