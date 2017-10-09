//
//  HNPhotoBrowserAnimator.h
//  wechats
//
//  Created by AnICoo1 on 2017/3/23.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma ----  图片开始浏览协议  ------
@protocol photoBrowserAnimatorPresentDelegate <NSObject>

/**
 *  获取图片浏览前的位置
 *  @param index  图片的下标
 *  @return       图片相对于window的位置
 */
- (CGRect)startRect:(NSInteger)index;


/**
 *  获取图片浏览中的位置
 *  @param index  图片的下标
 *  @return       图片在图片查看控制器中位置
 */
- (CGRect)endRect:(NSInteger)index;

/**
 *  获取当前要浏览的图片
 *  @param  index 图片的下标
 *  @return       当前要浏览的图片
 */
- (UIImageView *)locImageView:(NSInteger)index;

@end


#pragma ----  图片结束浏览协议  ------
@protocol photoBrowserAnimatorDismissDelegate <NSObject>

/**
 *  获取当前浏览的图片的下标
 *  @return       当前浏览图片的下标
 */
- (NSInteger)indexForDismissView;

/**
 *  获取当前浏览的图片
 *  @return       当前浏览的图片
 */
- (UIImageView *)imageViewForDismissView;

@end

@interface HNPhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

#pragma  ---- 必传参数 ----
/** 图片开始浏览协议 */
@property (nonatomic, weak) id<photoBrowserAnimatorPresentDelegate> animationPresentDelegate;

/** 图片结束浏览协议 */
@property (nonatomic, weak) id<photoBrowserAnimatorDismissDelegate> animationDismissDelegate;

/** 当前所要查看的图片  */
@property (nonatomic, assign) NSInteger         index;


#pragma  ---- 非必传参数 ----
/** 转场时的背景颜色  默认透明背景*/
@property (nonatomic, strong) UIColor           *backgroundColor;

/** 转场的时间  默认*/
@property (nonatomic, assign) NSInteger         animatorTime;      // 动画时间


@end
