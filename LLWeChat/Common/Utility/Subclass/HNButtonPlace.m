//
//  HNButtonPlace.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//
/************ 文字可上下左右的 button *************/

#import "HNButtonPlace.h"

@implementation HNButtonPlace


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width - 28;
    CGFloat h = contentRect.size.height;
    return CGRectMake(28, 0, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat w = 20;
    return CGRectMake(6, 0, w, h);
}




@end
