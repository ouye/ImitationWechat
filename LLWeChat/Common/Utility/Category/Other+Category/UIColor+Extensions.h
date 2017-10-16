//
//  UIColor+Extensions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

#define UIColorRGBA(_red, _green, _blue, _alpha) [UIColor colorWithRed:((_red)/255.0) \
green:((_green)/255.0) blue:((_blue)/255.0) alpha:(_alpha)]

#define UIColorRGB(red, green, blue) UIColorRGBA(red, green, blue, 1)

#define UIColorHexRGB(rgbString) [UIColor colorWithHexRGB:(rgbString)]

#define UIColorHexRGBA(rgbaString) [UIColor colorWithHexRGBA:(rgbaString)]

#define UIColorHexaRGB(rgd) [UIColor colorWithRed:((int)(0x111111 & 0x00FF00) >> 16) / 255.0 green:((int)(0x111111 & 0x0000FF) >> 8) / 255.0 blue:((int)(0x111111 & 0x0000FF) )/255.0 alpha:1]            //16进制


+ (instancetype)colorWithHexRGBA:(NSString *)rgba;

+ (instancetype)colorWithHexRGB:(NSString *)rgb;

+ (instancetype)colorWithHexARGB:(NSString *)argb;

+ (UIColor *)randomColor;

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;


#pragma  --------- UIColor 扩展功能 ----------
/**
 *  获取图片上某个点的颜色
 */
+ (UIColor *)colorAtPoint:(CGPoint)point fromImageView:(UIImageView *)imageView;

/**
 *  将一 color 加上alpha
 */
- (UIColor*)addAlpha:(CGFloat)alpha;

@end
