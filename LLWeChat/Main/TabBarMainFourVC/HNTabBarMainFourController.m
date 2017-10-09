//
//  HNTabBarMainFourController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/7.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNTabBarMainFourController.h"

/************** 消息列表控制器 **************/
#import "HNConversationListController.h"

/************** 联系人 控制器 **************/
#import "HNContactController.h"

/************** 发现控制器 **************/
#import "HNDiscoveryController.h"

/************** 我 控制器 **************/
#import "HNMeViewController.h"


@interface HNTabBarMainFourController ()

@end

@implementation HNTabBarMainFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC];
}


- (void)addChildVC{
    [self setupChildVC:[[HNConversationListController alloc]init] title:@"微信" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    [self setupChildVC:[[HNContactController alloc]init] title:@"通讯录" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    [self setupChildVC:[[HNDiscoveryController alloc]init] title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    [self setupChildVC:[[HNMeViewController alloc]init] title:@"我" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];
}

@end
