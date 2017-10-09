//
//  IMLookPhotosVC.m
//  GCall
//
//  Created by wen on 16/10/20.
//  Copyright © 2016年 gcall. All rights reserved.
//

#import "IMLookPhotosVC.h"
#import "IMMsgMediaHelper.h"
#import "IMLookPotosCell.h"
#import "DCPhotoView.h"

#define ITEM_SIZE (KScreenWidth - 20 - 128*2)


@interface IMLookPhotosVC()<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
DCPhotoViewDelegate>

@property (nonatomic , strong) UICollectionView *collectionView; //UICollectionView

@property (nonatomic , strong) UIButton *photoMenuBtn;  /** 右下角的菜单按钮 */

@property (nonatomic , assign) NSInteger pictureIndex;

@property (nonatomic , strong) UICollectionViewFlowLayout *layout; // layout

@property(nonatomic, assign)BOOL isPortrait;  //横竖屏布尔值

@end


@implementation IMLookPhotosVC


#pragma mark LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.photoMenuBtn];
    self.isPortrait = YES;
    
    //计算当前点击图片的index
    NSInteger pictureIndex =[IMMsgMediaHelper indexOfTouchPhoto:self.message With:self.picturesArr];
    self.pictureIndex = pictureIndex;
    self.collectionView.contentOffset = CGPointMake(KScreenWidth * pictureIndex, 0);
    
    //检测屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}


//检测屏幕旋转  旋转屏幕
- (void)changeFrame
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)){
        self.layout.itemSize = CGSizeMake(KScreenWidth, KScreenHeight);
        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        self.collectionView.collectionViewLayout = self.layout;
        self.collectionView.contentOffset = CGPointMake(KScreenWidth*self.pictureIndex, 0);
        self.isPortrait = NO;
        [self.collectionView reloadData];
    }
    else if(UIDeviceOrientationIsPortrait(deviceOrientation)){
        self.layout.itemSize = CGSizeMake(KScreenWidth, KScreenHeight);
        self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        self.collectionView.collectionViewLayout = self.layout;
        self.collectionView.contentOffset = CGPointMake(KScreenWidth*self.pictureIndex, 0);
        self.isPortrait = YES;
        [self.collectionView reloadData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden =  YES;
    [self showtabbar:NO];
    [self showTopView:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.frame.size;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picturesArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IMLookPotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IMLookPotosCellID forIndexPath:indexPath];
    cell.scrollView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    appdcimsliceMyChatMsgNew *message = self.picturesArr[indexPath.item];
    cell.message = message;
    cell.scrollView.photoViewDelegate = self;
    cell.scrollView.isPortrait = self.isPortrait;
    cell.index = indexPath.row;
    
    cell.CellIndexCallBack = ^(NSInteger index){
        
        [self dismissViewControllerAnimated:NO completion:^{
            
            appdcimsliceMyChatMsgNew *message = self.picturesArr[index];
            
            if (self.PhotoVcTransmitCB) {
                self.PhotoVcTransmitCB(message);
            }
            
            
        }];
        
        
        
    };
    
    
    return cell;
}




//单击图片返回聊天界面
-(void)photoViewSingleTap:(NSInteger)index{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//貌似不会执行
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/KScreenWidth;
    NSLog(@"%@",self.picturesArr[index]);
    self.pictureIndex = index;
}

#pragma mark privite Method
#pragma mark Event Method
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//页面关闭时，强制竖屏显示
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


-(void)photoMenuBtnAction{
    
    
}


#pragma mark lazyLoad UI

-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //  每个item在水平方向的最小间距
        _layout.minimumLineSpacing = 0;
    }
    return _layout;
}

//UICollectionView
-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[IMLookPotosCell class] forCellWithReuseIdentifier:IMLookPotosCellID];
        _collectionView.backgroundColor = [UIColor blackColor];
    }
    return _collectionView;
}

/** 右下角的菜单按钮 */
-(UIButton *)photoMenuBtn{
    if (_photoMenuBtn == nil) {
        _photoMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-50, KScreenHeight - 38, 40, 28)];
        [_photoMenuBtn setImage:[UIImage imageNamed:@"Im_05_weijian"] forState:UIControlStateNormal];
        [_photoMenuBtn addTarget:self action:@selector(photoMenuBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoMenuBtn;
}



@end
