
//
//  HNSize.h
//  HNWeChat
//
//  Created by 谌文 on 17/9/9.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#ifndef HNSize_h
#define HNSize_h

//屏幕尺寸大小
#define ScreenFrame         ([UIScreen mainScreen].bounds)
#define ScreenWidth         ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight        ([UIScreen mainScreen].bounds.size.height)
#define ScreenScale         ([UIScreen mainScreen].scale)

// tableView sectionHeader头高
#define TABLE_SECTION_HEIGHT_ZERO 0.000001f

// 以iphone 6为标准  缩放
#define ScaleWidth(W)    [[UIScreen mainScreen] bounds].size.width/375*(W)
#define ScaleHeight(H)  [[UIScreen mainScreen] bounds].size.height/667*(H)


#define HNFont(x)           [UIFont systemFontOfSize:x]
#define HNFontBold(x)       [UIFont boldSystemFontOfSize:x]
#define HNScaleFont(x)        ScreenHeight/667(x)                   //根据屏幕高来确定字体高


#pragma mark   UIlabel  字体大小 对应 sizeToFit 后的 label的高度
/*********  UIlabel  字体大小 对应 sizeToFit 后的 label的高度  ********/
#define HNLabelHight(label)     [label getHeightBysizeToFit]
#define HNLabelWith(label)      [label getSizeBysizeToFit].width
#define HNLabelSize(label)      [label getSizeBysizeToFit]


#endif /* HNSize_h */
