//
//  HNTableViewCellData.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNTableViewCellData.h"

@implementation HNTableViewCellData

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName {
    return [self initWithTitle:title subTitle:nil iconName:iconName];
}


- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle iconName:(NSString *)iconName {
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = [UIImage imageNamed:iconName];
        self.subTitle = subTitle;
    }
    
    return self;
}

@end
