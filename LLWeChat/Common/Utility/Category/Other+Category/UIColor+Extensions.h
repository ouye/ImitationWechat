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

#define UIColorHexaRGB(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]            //16进制


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
