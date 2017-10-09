//
//  AnimatedTransitioning.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/19.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransitionConst.h"

@interface AnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) XXTransitionType    transitionType;

@end
