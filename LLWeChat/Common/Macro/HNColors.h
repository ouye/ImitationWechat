//
//  HNColors.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#ifndef HNColors_h
#define HNColors_h


#import "UIColor+Extensions.h"

/**
 *  以下颜色统统采用最直接的系统定义方法，这样可以利用插件直接查看颜色
 *  如果采用宏定义或者包装方法，就无法直观查看颜色，那样不太方便
 *
 */

//一般文本色
#define HNTextColor_Normal [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]

//黑色度略微下降的黑色
#define HNTextColor_lightBlack [UIColor colorWithWhite:0.2 alpha:1]

#define HNTextColor_grayBlack [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]


//略微发灰的文本
#define HNTextColor_lightGray_7 [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1]

#define HNTextColor_lightGray_6 [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1]

#define HNTextColor_lightGray_5 [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1]

//系统提供的灰色
#define HNTextColor_lightGray_system [UIColor lightGrayColor]

//淡蓝色文本
#define HNTextColor_slightBlue [UIColor colorWithRed:82/255.0 green:126/255.0 blue:173/255.0 alpha:1]

#define HNBackgroundColor_slightBlue [UIColor colorWithRed:30/255.0 green:130/255.0 blue:233/255.0 alpha:0.3]


#define HNBackgroundColor_slightGray [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]

#define HNBackgourndColor_inputGray [UIColor colorWithRed:242/255.0 green:244/255.0 blue:247/255.0 alpha:1]

#define HNBackgroundColor_nearWhite [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1]

#define HNBackgroundColor_lightGray [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]

#define HNBackgroundColor_gray [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]

#define HNBackgroundColor_darkGray [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1]

#define HNBackgroundColor_darkGray2 [UIColor colorWithRed:187/255.0 green:186/255.0 blue:193/255.0 alpha:1]

#define HNBackgroundColor_slightGreen [UIColor colorWithRed:229/255.f green:238/255.f blue:235/255.f alpha:1.f]

#define HNTableSeperatorColor_gray [UIColor colorWithRed:200/255.f green:199/255.f blue:204/255.f alpha:1.f].CGColor // 列表分割线颜色

//半透明的背景，用于遮罩下面背景
#define HNMaskBackgroundColor [UIColor colorWithWhite:0 alpha:0.6]


#define HNTextLinkColor [UIColor colorWithRed:0/255.0 green:104/255.0 blue:248/255.0 alpha:1]

#define HNAppleTinkColor [UIColor colorWithRed:0/255.0 green:104/255.0 blue:248/255.0 alpha:1]

#define HNTextColor_green [UIColor colorWithRed:29/255.0 green:185/255.0 blue:14/255.0 alpha:1]

#define HNTextColor_darkGreen [UIColor colorWithRed:17/255.0 green:137/255.0 blue:30/255.0 alpha:1]

#pragma mark - 红色系
//9C3638

#define HNBackgroundColor_SlightDardRed [UIColor colorWithRed:231/255.0 green:80/255.0 blue:73/255.0 alpha:1]

#define HNBackgroundColor_DarkRed [UIColor colorWithRed:156/255.0 green:54/255.0 blue:56/255.0 alpha:1]

#define HNTextColor_drarRed [UIColor colorWithRed:183/255.0 green:24/255.0 blue:24/255.0 alpha:1]



#pragma mark - UIKit组件默认颜色 -

#define SAFARI_BAR_COLOR [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS7 Safari bar color

//UITableViewGroup 样式时，背景颜色
#define TABLE_VIEW_GROUP_BACKGROUNDCOLOR [UIColor colorWithRed:239.f / 255.f green:239.f / 255.f blue:244.f / 255.f alpha:1.0];


#endif /* HNColors_h */
