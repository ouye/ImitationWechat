//
//  UIView+Extensions.m
//  GCall
//
//  Created by chenwen on 17/5/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)


#pragma -----------  常用方法  --------------
#pragma  加边 加圆角等
/**
 *  通过UIBezierPath来实现切圆角功能 不会产生离屏绚烂 (有个问题没法解决 边线宽和颜色)
 *  @param  Corner      圆角大小
 */
- (instancetype)addViewCornerWithCorner:(CGFloat)Corner{
    [self addViewCornerWithCorner:YES andTopRight:YES andBottomLeft:YES andBottomRight:YES];
    return self;
}

/**
 *  没有边线颜色宽度
 *  @param  Corner      圆角大小
 *  @param  TopLeft     那些位置加圆角
 */
- (instancetype)addViewCornerWithCorner:(BOOL)topLeft
                   andTopRight:(BOOL)topRight
                 andBottomLeft:(BOOL)bottomLeft
                andBottomRight:(BOOL)bottomRight
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:(topLeft==YES ? UIRectCornerTopLeft : 0) |
                              (topRight==YES ? UIRectCornerTopRight : 0) |
                              (bottomLeft==YES ? UIRectCornerBottomLeft : 0) |
                              (bottomRight==YES ? UIRectCornerBottomRight : 0)
                                                         cornerRadii:CGSizeMake(10, 10)];
    // 创建遮罩层
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    self.layer.mask = maskLayer;
    
    return self;
}


/*
 *  给view上下左右某个遍加分割线
 *  @pragma  color 颜色  borderWidth 分割线高 position分割线位置 可或
 */
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position{
    
    if (position & (TOP|BOTTOM)){
        [self addBorderWithColor:color andWidth:borderWidth andPostion:position startPosition:0 lenght:self.frame.size.width];
    }
    
    if (position & (LEFT|RIGHT)){
        [self addBorderWithColor:color andWidth:borderWidth andPostion:position startPosition:0 lenght:self.frame.size.height];
    }
}

- (CALayer*)createCALayerWithColor: (UIColor *) color {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    [self.layer addSublayer:border];
    return border;
}

/**
 *  给view上下左右某个遍加分割线     从某个位置加多长的分割线
 *  @pragma  color 颜色
 *  @pragma  borderWidth 线宽
 *  @pragma  position 那些边 可或
 *  @pragma  start 起始位置 lenght 长
 */
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position startPosition:(CGFloat)start lenght:(CGFloat)length{
    
    if (position & TOP){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(start, 0, length, borderWidth);
    }
    
    if (position & BOTTOM){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(start, self.frame.size.height-borderWidth, length, borderWidth);
    }
    
    if (position & LEFT){
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(0, start, borderWidth, length);
    }
    
    if (position & RIGHT) {
        CALayer *border = [self createCALayerWithColor:color];
        border.frame = CGRectMake(self.frame.size.width - borderWidth, start, borderWidth, length);
    }
}



//判断是否含有某个子view
- (BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
            
        }
    }
    return NO;
}

//判断是否含有某类的子view
- (BOOL) containsSubViewOfClassType:(Class)aClass{
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:aClass]) {
            return YES;
        }
    }
    return NO;
}

//移除所有子view
- (void)removeAllSubViews{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}


/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}






@end
