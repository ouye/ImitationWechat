//
//  HNTableViewCellData.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HNTableViewCellData : NSObject

/** 标题 **/
@property (nonatomic, copy)   NSString          *title;

/** 副标题 **/
@property (nonatomic, copy)   NSString          *subTitle;

/** 图片 **/
@property (nonatomic, strong) UIImage           *icon;


- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle iconName:(NSString *)iconName;

@end
