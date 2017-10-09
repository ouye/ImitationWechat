//
//  HNExampleViewControoler.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/21.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNExampleViewControoler.h"
#import "HNLookPhotoVC.h"

#import "HNPhotoBrowserAnimator.h"
#import "HNPhotoInteractiveTransition.h"


static  NSString  *HNShowCellID = @"HNShowCellID";

@interface HNShowCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) NSString      *urlStr;

/** 获取图片起始位置 */
- (CGRect)startRect:(NSInteger)index;

@end

@implementation HNShowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

/** 获取图片起始位置 */
- (CGRect)startRect:(NSInteger)index{
    return [self convertRect:self.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
}

- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    [_imageView sd_setImageWithUrlStr:urlStr];
}

#pragma --- lazy load 懒加载UI ----
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.frame = CGRectMake(0, 0, 0.6*ScreenWidth, 300);
    }
    return _imageView;
}

@end

@interface HNExampleViewControoler ()<UICollectionViewDataSource,UICollectionViewDelegate,photoBrowserAnimatorPresentDelegate>

@property (nonatomic, strong) UICollectionView              *picCollectionView ;
@property (nonatomic, strong) UICollectionViewFlowLayout    *flowLayout;
@property (nonatomic, strong) NSMutableArray                *dataArray; //数据源

@property (nonatomic, strong) HNPhotoBrowserAnimator        *animator;


@end

@implementation HNExampleViewControoler

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.picCollectionView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HNShowCellID forIndexPath:indexPath];
    cell.urlStr =  self.dataArray[indexPath.item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HNLookPhotoVC  *LookPhotoVC = [[HNLookPhotoVC alloc]init];
    LookPhotoVC.picturesArr = self.dataArray;
    LookPhotoVC.pictureIndex = indexPath.item;
    LookPhotoVC.modalPresentationStyle = UIModalPresentationCustom;
    LookPhotoVC.transitioningDelegate = self.animator;
    
    self.animator.animationPresentDelegate = self;
    self.animator.index = indexPath.item;
    self.animator.animationDismissDelegate = LookPhotoVC;
    
    // 添加 手势 
    [[HNPhotoInteractiveTransition sharedInstance] addPanGestureForViewController:LookPhotoVC];

    [self presentViewController:LookPhotoVC animated:YES completion:nil];
}


#pragma mark - photoBrowserAnimatorDelegate
/**
 *  获取图片浏览前的位置
 */
- (CGRect)startRect:(NSInteger)index{
    HNShowCell  *cell = (HNShowCell*)[_picCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    NSArray  *visibleArray = [_picCollectionView visibleCells];
    
    // 在屏幕显示中
    if ([visibleArray containsObject:cell]) {
        return [cell startRect:index];
    }
    
    // 在屏幕外
    return CGRectMake(ScreenWidth*0.5, ScreenHeight*0.5, 0, 0);
}

/**
 *  图片在图片查看控制器中位置
 */
- (CGRect)endRect:(NSInteger)index{
    HNShowCell  *cell = (HNShowCell*)[_picCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    UIImage *image = cell.imageView.image;
    //计算imageView的frame
    CGFloat x = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width / image.size.width * image.size.height;
    CGFloat y = 0;
    if(height < [UIScreen mainScreen].bounds.size.height){
        y = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
    }
    return CGRectMake(x, y, width, height);
}


/**
 *  获取当前要浏览的图片
 */
- (UIImageView *)locImageView:(NSInteger)index{
    HNShowCell  *cell = (HNShowCell*)[_picCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = cell.imageView.image;
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    return imageView;
}


#pragma ---- lazy load 懒加载UI ----
-(UICollectionView *)picCollectionView{
    if (!_picCollectionView) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.minimumLineSpacing = 20;
        self.flowLayout.minimumInteritemSpacing = 20;
        CGFloat cellHeight = 300;
        self.flowLayout.itemSize = CGSizeMake(0.6*ScreenWidth, cellHeight);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _picCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, ScreenWidth,360) collectionViewLayout:self.flowLayout];
        _picCollectionView.delegate = self;
        _picCollectionView.dataSource =self;
        _picCollectionView.backgroundColor = [UIColor whiteColor];
        [_picCollectionView registerClass:[HNShowCell class] forCellWithReuseIdentifier:HNShowCellID];
    }
    return _picCollectionView;
}

//数据源
- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:
                      @"https://img.gcall.com/dca3/M00/11/FF/wKhoMFmwpJuECu7uAAAAAAAAAAA609_260x260.jpg?size=434x433",
                      @"https://img.gcall.com/dca4/M00/12/59/wKhoMVmoxDGENarVAAAAAAAAAAA193_260x260.jpg?size=460x461",
                      @"https://img.gcall.com/dca4/M00/12/A1/wKhoLVmoxCeEVJPTAAAAAAAAAAA001_260x260.jpg?size=447x446",
                      @"https://img.gcall.com/dca3/M00/11/CF/wKhoLFmowpeEAhbjAAAAAAAAAAA539_260x260.jpg?size=460x461",
                      @"https://img.gcall.com/dca5/M00/22/14/wKhoNlmnzFeEbtQGAAAAAAAAAAA939_260x260.jpg?size=460x651",
                      @"https://img.gcall.com/dca1/M00/12/EE/wKhoKlmnyh6EHDk5AAAAAAAAAAA759_260x260.jpg?size=700x1243",
                      @"https://img.gcall.com/dca1/M00/03/53/wKhoLlmnyh6Ee_i6AAAAAAAAAAA634_260x260.jpg?size=451x800",nil];
    }
    return _dataArray;
}


#pragma amrk - 懒加载
- (HNPhotoBrowserAnimator *)animator{
    if(!_animator){
        _animator = [[HNPhotoBrowserAnimator alloc] init];
    }
    return _animator;
}

@end
