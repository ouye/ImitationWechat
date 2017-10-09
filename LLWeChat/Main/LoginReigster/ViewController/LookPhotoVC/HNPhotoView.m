//
//  HNPhotoView.m
//  HNMarketProject
//
//  Created by chenwen on 2017/9/19.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNPhotoView.h"
#import "UIImageView+WebCache.h"

#define ScreenW self.bounds.size.width
#define ScreenH self.bounds.size.height
#define ScreenScale [UIScreen mainScreen].scale

@interface HNPhotoView ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;  //放图片的UIScrollView

@property(nonatomic, assign)CGFloat fillScale;

/** 等待转圈 */
@property (nonatomic,strong)UIActivityIndicatorView *activity;

@property(nonatomic, assign)CGSize imageRealSize;

@end

@implementation HNPhotoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];      // 加载UI
        [self createGesture];   // createGesture
    }
    return self;
}

// 加载UI
- (void)createView{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.itemImageView];
    [self.scrollView addSubview:self.activity];
    self.activity.center = CGPointMake(ScreenW/2, ScreenH/2);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    _itemImageView.frame = self.bounds;
}


// 设置点击双击手势
- (void)createGesture{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    longTap.minimumPressDuration = 1;
    [self addGestureRecognizer:longTap];
}


// 设置加载图片数据
- (void)setItemImageUrl:(NSString *)itemImageUrl{
    _itemImageUrl = itemImageUrl;
    [self.activity startAnimating];

    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:itemImageUrl] options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
        
     
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (image) {
            [self.activity stopAnimating];
            weakSelf.itemImageView.image = image;
            [self resetSize];

        }else{
            NSLog(@"获取图片失败");
            
        }
    }];
}




// 单击收起控制器
- (void)singleTap:(UITapGestureRecognizer *)singleTap{
    if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
        [self.photoViewDelegate photoViewSingleTap:self.tag];
    }
}

// 长按手势
- (void)longTap:(UILongPressGestureRecognizer*)loonTap{
    if ([self.photoViewDelegate respondsToSelector:@selector(photoViewLongTap:)]) {
        [self.photoViewDelegate photoViewLongTap:self.tag];
    }
}

//双击扩大图片缩小图片
- (void)doubleTap:(UITapGestureRecognizer *)doubleTap{
    CGPoint location = [doubleTap locationInView:_itemImageView];
    if(ScreenW < ScreenH){
        if (_itemImageView.bounds.size.height < _itemImageView.bounds.size.width) {
            if (_scrollView.zoomScale == _scrollView.maximumZoomScale || fabs(_scrollView.zoomScale - _fillScale) < 0.00001) {
                [_scrollView setZoomScale:1.0 animated:YES];
            } else {
                CGFloat locationX = location.x;
                CGRect zoomRect = CGRectMake(locationX, 0, ScreenW / _fillScale, _itemImageView.bounds.size.height);
                [_scrollView zoomToRect:zoomRect animated:YES];
            }
        } else {
            if (_scrollView.zoomScale == _scrollView.maximumZoomScale) {
                if (_scrollView.maximumZoomScale == 1.0) {
                    CGRect zoomRect = CGRectMake(0, location.y - ScreenH / 2, _itemImageView.bounds.size.width, ScreenH);
                    [_scrollView zoomToRect:zoomRect animated:YES];
                } else {
                    [_scrollView setZoomScale:1.0 animated:YES];
                }
            } else {
                CGFloat locationX = location.x;
                CGFloat locationY = location.y;
                CGRect zoomRect = CGRectMake(locationX, locationY, 1, 1);
                [_scrollView zoomToRect:zoomRect animated:YES];
            }
        }
    } else {
        if (_itemImageView.bounds.size.width / _itemImageView.bounds.size.height > ScreenW / ScreenH) {
            if (_scrollView.zoomScale == _scrollView.maximumZoomScale ||fabs(_scrollView.zoomScale - _fillScale) < 0.00001) {
                [_scrollView setZoomScale:1.0 animated:YES];
            } else {
                CGFloat locationX = location.x;
                CGRect zoomRect = CGRectMake(locationX, 0, ScreenW / _fillScale, _itemImageView.bounds.size.height);
                [_scrollView zoomToRect:zoomRect animated:YES];
            }
        } else if(_itemImageView.bounds.size.height < _itemImageView.bounds.size.width){
            CGRect zoomRect = CGRectMake(0, location.y - ScreenH / 2, _itemImageView.bounds.size.width, ScreenH);
            [_scrollView zoomToRect:zoomRect animated:YES];
        } else {
            if (_scrollView.zoomScale == _scrollView.maximumZoomScale) {
                if (_scrollView.maximumZoomScale == 1.0) {
                    CGRect zoomRect = CGRectMake(0, location.y - ScreenH / 2, _itemImageView.bounds.size.width, ScreenH);
                    [_scrollView zoomToRect:zoomRect animated:YES];
                } else {
                    [_scrollView setZoomScale:1.0 animated:YES];
                }
            } else {
                CGFloat locationX = location.x;
                CGFloat locationY = location.y;
                CGRect zoomRect = CGRectMake(locationX, locationY, 1, 1);
                [_scrollView zoomToRect:zoomRect animated:YES];
            }
        }
    }
}

- (void)centerContent{
    CGRect frame = _itemImageView.frame;
    
    CGFloat top = 0, left = 0;
    if (_scrollView.contentSize.width < _scrollView.bounds.size.width) {
        left = (_scrollView.bounds.size.width - _scrollView.contentSize.width) * 0.5f;
    }
    if (_scrollView.contentSize.height < _scrollView.bounds.size.height) {
        top = (_scrollView.bounds.size.height - _scrollView.contentSize.height) * 0.5f;
    }
    
    top -= frame.origin.y;
    left -= frame.origin.x;
    
    _scrollView.contentInset = UIEdgeInsetsMake(top, left, top, left);
    
}

- (void)resetSize
{
    
    [self checkSize];
    
    if (_scrollView.contentInset.top == 0) {
        _scrollView.contentOffset = CGPointZero;
    }
}
- (void)checkSize
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)){
        //横向展示图片
//        self.isPortrait = NO;
    }
    else if(UIDeviceOrientationIsPortrait(deviceOrientation))
    {
        //纵向展示图片
//        self.isPortrait = YES;
    }
    
    if (self.isPortrait) {
        [self checkSizePortrait];
    }else{
        [self checkSizeLandscape];
    }
    _scrollView.contentSize = _itemImageView.bounds.size;
    
    [self centerContent];
    
}


- (void)checkSizePortrait{
    if (_itemImageView.image) {
        
        _scrollView.zoomScale = 1.0;
        
        CGFloat imageViewW = self.bounds.size.width;
        CGFloat imageViewH = imageViewW * _itemImageView.image.size.height / _itemImageView.image.size.width;
        CGFloat imageViewX = 0;
        CGFloat imageViewY = 0;
        
        _itemImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        
        _imageRealSize = CGSizeMake(_itemImageView.image.size.width * _itemImageView.image.scale / ScreenScale, _itemImageView.image.size.height * _itemImageView.image.scale / ScreenScale);
        //产品UI需求参照微信，facebook iOS版规则，不管多大的图片最小都适配满屏，最大3倍,以上逻辑废弃
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1.0;
        
    } else {
        
        _itemImageView.frame = self.bounds;
        
    }
}


- (void)checkSizeLandscape{
    
    NSLog(@"横向");
    if (_itemImageView.image) {
        
        _scrollView.zoomScale = 1.0;
        
        CGFloat imageViewW = self.bounds.size.width;
        //            CGFloat imageViewH = imageViewW * _itemImageView.image.size.width / _itemImageView.image.size.height;
        CGFloat imageViewH = self.bounds.size.height;
        CGFloat imageViewX = 0;
        CGFloat imageViewY = 0;
        
        _itemImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        
        _imageRealSize = CGSizeMake(_itemImageView.image.size.width * _itemImageView.image.scale / ScreenScale, _itemImageView.image.size.height * _itemImageView.image.scale / ScreenScale);
        
        
        //产品UI需求参照微信，facebook iOS版规则，不管多大的图片最小都适配满屏，最大3倍,以上逻辑废弃
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.minimumZoomScale = 1.0;
        
    } else {
    
    _itemImageView.frame = self.bounds;
    }
    
}




#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.itemImageView;
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContent];
}


#pragma ladyLoad 懒加载 UI
//放图片的UIScrollView
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

//图片 UIImageView view
- (UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_itemImageView setContentMode:UIViewContentModeScaleAspectFit];
        _itemImageView.clipsToBounds = YES;
    }
    return _itemImageView;
}

// 转圈圈
- (UIActivityIndicatorView*)activity{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:
                     UIActivityIndicatorViewStyleWhite];
        _activity.backgroundColor = [UIColor redColor];

    }
    return  _activity;
}



@end
