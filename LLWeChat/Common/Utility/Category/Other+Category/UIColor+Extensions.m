//
//  UIColor+LLExt.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


#pragma mark - 根据字符串创建Color


+ (instancetype)colorWithHexRGBA:(NSString *)rgba {
    NSAssert([rgba hasPrefix:@"#"], @"颜色字符串要以#开头");
    
    NSString *hexString = [rgba substringFromIndex:1];
    unsigned int hexInt;
    BOOL result = [[NSScanner scannerWithString:hexString] scanHexInt:&hexInt];
    if (!result)
        return nil;
    
    CGFloat divisor = 255.0;
    CGFloat red = ((hexInt & 0xFF000000) >> 24) / divisor;
    CGFloat green   = ((hexInt & 0x00FF0000) >> 16) / divisor;
    CGFloat blue    = ((hexInt & 0x0000FF00) >>  8) / divisor;
    CGFloat alpha   = ( hexInt & 0x000000FF       ) / divisor;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}

+ (instancetype)colorWithHexARGB:(NSString *)argb {
    NSAssert([argb hasPrefix:@"#"], @"颜色字符串要以#开头");
    
    NSString *hexString = [argb substringFromIndex:1];
    unsigned int hexInt;
    BOOL result = [[NSScanner scannerWithString:hexString] scanHexInt:&hexInt];
    if (!result) {
        return nil;
    }
    
    CGFloat divisor = 255.0;
    CGFloat alpha = ((hexInt & 0xFF000000) >> 24) / divisor;
    CGFloat red   = ((hexInt & 0x00FF0000) >> 16) / divisor;
    CGFloat green    = ((hexInt & 0x0000FF00) >>  8) / divisor;
    CGFloat blue   = ( hexInt & 0x000000FF       ) / divisor;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}

+ (instancetype)colorWithHexRGB:(NSString *)rgb {
    NSAssert([rgb hasPrefix:@"#"], @"颜色字符串要以#开头");
    
    NSString *hexString = [rgb substringFromIndex:1];
    unsigned int hexInt;
    BOOL result = [[NSScanner scannerWithString:hexString] scanHexInt:&hexInt];
    if (!result) {
        return nil;
    }
    
    CGFloat divisor = 255.0;
    CGFloat red   = ((hexInt & 0x00FF0000) >> 16) / divisor;
    CGFloat green    = ((hexInt & 0x0000FF00) >>  8) / divisor;
    CGFloat blue   = ( hexInt & 0x000000FF       ) / divisor;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
}


/**
 *  获取图片上某个点的颜色
 */
+ (UIColor *)colorAtPoint:(CGPoint)point fromImageView:(UIImageView *)imageView {
    if (!CGRectContainsPoint(imageView.bounds, point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = imageView.image.CGImage;
    NSUInteger width = CGRectGetWidth(imageView.frame);
    NSUInteger height = CGRectGetHeight(imageView.frame);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


/**
 *  将一 color 加上alpha
 */
- (UIColor*)addAlpha:(CGFloat)alpha{
    return   [self colorWithAlphaComponent:alpha];  //  原生已有此方法 😄
}

@end
