//
//  HNLookPhotoVC.h
//  HNMarketProject
//
//  Created by chenwen on 2017/9/19.
//  Copyright © 2017年 HN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPhotoBrowserAnimator.h"

@interface HNLookPhotoVC : UIViewController<photoBrowserAnimatorDismissDelegate>

#pragma  ---- 必传参数 ----
/** 图片数组 */
@property (nonatomic, strong) NSMutableArray    *picturesArr;           // 图片数据数组

/** 点击的第几张图片  */
@property (nonatomic, assign) NSInteger          pictureIndex;          // 点击的第几张图片



@end
