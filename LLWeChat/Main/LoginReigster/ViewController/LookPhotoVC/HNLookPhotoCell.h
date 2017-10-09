//
//  HNLookPhotoCell.h
//  HNMarketProject
//
//  Created by chenwen on 2017/9/19.
//  Copyright © 2017年 HN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPhotoView.h"

static NSString *HNLookPhotoCellID = @"HNLookPhotoCellID";


@interface HNLookPhotoCell : UICollectionViewCell

@property (nonatomic, strong) HNPhotoView *scrollView;


@end
