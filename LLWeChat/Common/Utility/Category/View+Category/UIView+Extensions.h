//
//  UIView+Extensions.h
//  GCall
//
//  Created by chenwen on 17/5/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS ( NSUInteger, Position){
    TOP      = 1 << 0,
    LEFT     = 1 << 1,
    BOTTOM   = 1 << 2,
    RIGHT    = 1 << 3,
};


@interface UIView (Extensions)



#pragma -----------  常用方法  --------------
#pragma  加边 加圆角等
/**
 *  通过UIBezierPath来实现切圆角功能 不会产生离屏绚烂 (有个问题没法解决 边线宽和颜色  没有边线颜色宽度 )

 *  @param  Corner      圆角大小
 */
- (instancetype)addViewCornerWithCorner:(CGFloat)Corner;


/**
 *  没有边线颜色宽度    
 *  @param  Corner      圆角大小
 *  @param  TopLeft     那些位置加圆角
 */
- (instancetype)addViewCornerWithCorner:(CGFloat)Corner
                                TopLeft:(BOOL)topLeft
                            andTopRight:(BOOL)topRight
                          andBottomLeft:(BOOL)bottomLeft
                         andBottomRight:(BOOL)bottomRight;


/**
 *  给view上下左右某个遍加分割线
 *  @pragma  color 颜色  borderWidth 分割线高 position分割线位置 可或
 */
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position;


/**
 *  给view上下左右某个遍加分割线     从某个位置加多长的分割线
 *  @pragma  color 颜色
 *  @pragma  borderWidth 线宽
 *  @pragma  position 那些边 可或
 *  @pragma  start 起始位置 lenght 长
 */
- (void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andPostion:(Position)position startPosition:(CGFloat)start lenght:(CGFloat)length;



#pragma  获取 处理view等

/** 
 *  判断是否含有某个子view
 */
- (BOOL)containsSubView:(UIView *)subView;


/**
 *  判断是否含有某类的子view
 */
- (BOOL)containsSubViewOfClassType:(Class)aClass;


/**
 *  移除所有子view
 */
- (void)removeAllSubViews;


/*
 *  获取当前View的所在的控制器对象
 */
-(UIViewController *)getCurrentViewController;






@end
