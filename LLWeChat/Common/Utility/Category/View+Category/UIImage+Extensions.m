//
//  UIImage+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/15.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UIImage+Extensions.h"


#define screenW         [UIScreen mainScreen].bounds.size.width
#define screenH         [UIScreen mainScreen].bounds.size.height
#define screenScale     [UIScreen mainScreen].scale

@implementation UIImage (Extensions)

#pragma -----------  常用方法  --------------

/**
 *  给图片切圆角  解决 离屏绚烂问题 (有限制  如果图片是长方形 然后UIimageView是正方形 圆角就会变形啦)
 *  @param  radius   圆角大小
 *  @return image
 */
-(instancetype)imageWithCornerRadius:(CGFloat)radius{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, screenScale);
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius];
    [path addClip];
    [self drawInRect:bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  传入view 将该 view截图成图片
 * @param view       试图view
 * @return           UIImage
 */
+ (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/**
 *  截取view中某个区域生成一张图片
 *  @param view  view description
 *  @param scope 需要截取的view中的某个区域frame
 *  @return image
 */
+ (UIImage *)imageFromView:(UIView *)view scope:(CGRect)scope{
    UIImage *image = [UIImage imageFromImage:[UIImage imageFromView:view] inRect:scope];
    return image;
}


/**
 *  通过颜色来生成一个纯色图片
 *  @param color  颜色
 *  @return image
 */
+ (UIImage *)imageFromColor:(UIColor *)color{
    return [UIImage imageFromColor:color andSize:CGSizeMake(screenW, screenH)];
}

/**
 *  通过颜色尺寸来生成一个纯色图片
 *  @param  color  颜色
 *  @param  size   获取的图片尺寸大小
 *  @return image
 */
+ (UIImage *)imageFromColor:(UIColor *)color andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



#pragma -----------  截图等不常用 --------------

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *  @return UIImage
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}


/**
 *   同上  @param  rect 要截取的区域
 */
- (UIImage *)imageFromImage:(CGRect)rect {
    return [self imageFromImage:rect opaque:NO scale:screenScale];
}

- (UIImage *)imageFromImage:(CGRect)rect opaque:(BOOL)opaque scale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, scale);
    [self drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


#pragma -----------  关于聊天常用 ------------
/**
 *  聊天气泡指定区域拉伸图片 角不变形方法体
 */
- (UIImage *)resizableImage{
    CGFloat capWidth =  floorf(self.size.width / 2);
    CGFloat capHeight =  floorf(self.size.height / 2);
    UIImage *capImage = [self resizableImageWithCapInsets:
                         UIEdgeInsetsMake(capHeight, capWidth, capHeight, capWidth)];
    return capImage;
}


@end
