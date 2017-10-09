//
//  HNLookPhotoVC.m
//  HNMarketProject
//
//  Created by chenwen on 2017/9/19.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNLookPhotoVC.h"
#import "HNLookPhotoCell.h"

@interface HNLookPhotoVC ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
HNPhotoViewDelegate
>

@property(nonatomic, strong) UICollectionView               *picCollection;
@property(nonatomic, strong) UICollectionViewFlowLayout     *flowLayout;

@end

@implementation HNLookPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView]; //加载view
}

//加载view
- (void)createView{
    [self.view addSubview:self.picCollection];
}


//  设置更新数据图片
- (void)setPicturesArr:(NSMutableArray *)picturesArr{
    _picturesArr = picturesArr;
    [_picCollection reloadData];
}

#pragma mark - collectionDelegate/dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView   numberOfItemsInSection:(NSInteger)section{
    return self.picturesArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HNLookPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HNLookPhotoCellID forIndexPath:indexPath];
    cell.scrollView.itemImageUrl = self.picturesArr[indexPath.item];
    cell.scrollView.photoViewDelegate = self;
    return cell;
}



#pragma  ----- photoBrowserAnimatorDismissDelegate 子定义转场动画协议 -----
/**
 *  获取当前浏览的图片的下标
 */
- (NSInteger)indexForDismissView{
    HNLookPhotoCell *cell = [_picCollection visibleCells].firstObject;
    return [_picCollection indexPathForCell:cell].row;
}

/**
 *  获取当前浏览的图片
 */
- (UIImageView *)imageViewForDismissView{
    UIImageView *imageView = [[UIImageView alloc] init];
    HNLookPhotoCell *cell = [_picCollection visibleCells].firstObject;
    imageView.image = cell.scrollView.itemImageView.image;
    imageView.frame = cell.scrollView.itemImageView.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    return imageView;
}


#pragma  ----- HNPhotoViewDelegate 图片协议 -----
/**  单击图片代理 */
- (void)photoViewSingleTap:(NSInteger)index{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ----------------------- 懒加载 --------------------
// UICollectionView
-(UICollectionView *)picCollection{
    if (!_picCollection) {
        self.flowLayout= [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.minimumInteritemSpacing = 0;
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
        _picCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout: self.flowLayout];
        _picCollection.delegate = self;
        _picCollection.dataSource = self;
        _picCollection.pagingEnabled = YES;
        _picCollection.showsHorizontalScrollIndicator = NO;
        _picCollection.showsVerticalScrollIndicator = NO;
        _picCollection.contentSize = CGSizeMake(self.picturesArr.count * ScreenWidth, 0);
        _picCollection.contentOffset = CGPointMake(ScreenWidth * self.pictureIndex, 0);
        [_picCollection registerClass:[HNLookPhotoCell class] forCellWithReuseIdentifier:HNLookPhotoCellID];
    }
    return _picCollection;
}

@end
