//
//  LLUtils+CGHelper.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "LLUtils+CGHelper.h"

CGFloat SCREEN_WIDTH;
CGFloat SCREEN_HEIGHT;
CGSize SCREEN_SIZE;

CGRect SCREEN_FRAME;
CGPoint SCREEN_CENTER;


@implementation LLUtils (CGHelper)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SCREEN_FRAME = [UIScreen mainScreen].bounds;
        SCREEN_SIZE = SCREEN_FRAME.size;
        SCREEN_WIDTH = SCREEN_SIZE.width;
        SCREEN_HEIGHT = SCREEN_SIZE.height;
        SCREEN_CENTER = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    });
}


+ (CGRect)screenFrame {
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)pixelAlignForFloat:(CGFloat)position {
    CGFloat scale = [LLUtils screenScale];
    return round(position * scale) / scale;
}

+ (CGSize)convertPointSizeToPixelSize:(CGSize)pointSize {
    CGFloat scale = [self screenScale];
    return CGSizeMake(pointSize.width * scale, pointSize.height * scale);
}

+ (CALayer *)lineWithLength:(CGFloat)length atPoint:(CGPoint)point {
    CALayer *line = [CALayer layer];
    line.backgroundColor = UIColorRGB(221, 221, 221).CGColor;
    
    line.frame = CGRectMake(point.x, point.y, length, 1/[self screenScale]);
    return line;
}


@end
