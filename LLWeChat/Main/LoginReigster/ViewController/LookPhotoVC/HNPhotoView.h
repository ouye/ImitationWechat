//
//  HNPhotoView.h
//  HNMarketProject
//
//  Created by chenwen on 2017/9/19.
//  Copyright © 2017年 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HNPhotoViewDelegate <NSObject>

/**  单击图片代理 */
- (void)photoViewSingleTap:(NSInteger)index;

/**  长按图片代理 */
- (void)photoViewLongTap:(NSInteger)index;


/** 开始缩放 */
- (void)photoViewWillBeginZooming:(NSInteger)index;


- (BOOL)photoIsShowingPhotoViewAtIndex:(NSUInteger)index;


- (void)updatePhotoProgress:(CGFloat)progress andIndex:(NSInteger)index;

@end

@interface HNPhotoView : UIView

@property(nonatomic, strong,readonly)UIScrollView *scrollView;

@property(nonatomic, strong)UIImageView *itemImageView;

//UI提出，没加载出图片之前，默认不显示图片，仅转圈就好，加载失败才显示默认图片,所以目前暂时默认不传
@property (nonatomic, strong) UIImage       *itemImage; //加载失败默认图片

/**  图片地址 数据源  */
@property (nonatomic, copy)   NSString       *itemImageUrl;

@property(nonatomic, assign)BOOL isPortrait;


@property(nonatomic, weak)id<HNPhotoViewDelegate> photoViewDelegate;

@end
