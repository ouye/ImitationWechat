//
//  LLUtils+CGHelper.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/10.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUtils.h"
@import ImageIO;

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
extern CGSize SCREEN_SIZE;

extern CGRect SCREEN_FRAME;
extern CGPoint SCREEN_CENTER;

OBJC_EXTERN CGFloat CGPointDistanceBetween(CGPoint point1, CGPoint point2);

@interface HNUtils (CGHelper)

+ (CGFloat)screenScale;

+ (CGRect)screenFrame;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)pixelAlignForFloat:(CGFloat)position;

+ (CGPoint)pixelAlignForPoint:(CGPoint)point;

+ (CGSize)convertPointSizeToPixelSize:(CGSize)pointSize;

+ (CALayer *)lineWithLength:(CGFloat)length atPoint:(CGPoint)point;

+ (UIColor *)colorAtPoint:(CGPoint)point fromImageView:(UIImageView *)imageView;

+ (CGSize)GIFDimensionalSize:(CGImageSourceRef)imgSourceRef;

@end
