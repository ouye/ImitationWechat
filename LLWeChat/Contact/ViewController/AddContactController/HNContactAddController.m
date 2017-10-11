//
//  HNContactAddController.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*********** 添加朋友控制器 ************/

#import "HNContactAddController.h"
#import "HNTableViewCellData.h"
#import "HNTableViewCell.h"
#import "HNContactSearchView.h"

@interface HNContactAddController ()<UITableViewDelegate, UITableViewDataSource>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, strong) HNContactSearchView               *tableHeaderView;

/*** 数据类型 属性 ***/
@property (nonatomic, strong) NSArray<HNTableViewCellData *>    *dataSource;

@end

@implementation HNContactAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController setNavigationBarHidden:self.navigationController.navigationBarHidden animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelectorOnMainThread:@selector(showNavigationBarAnimated) withObject:nil waitUntilDone:NO];
}

- (void)showNavigationBarAnimated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------------- CreateViewAndAddFrame --------------------
//加载view
- (void)createView{
    [self.view addSubview:self.tableView];
}

#pragma mark ----------- TableView delegate -----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *HNTableViewCellID = @"tableViewCellStyleContactListID";
    HNTableViewCell *cell = [tableView createHNTableViewCellWithStyle:HNTableViewCellStyleContactSearchList reuseIdentifier:HNTableViewCellID];
    cell.accessoryType_HN = HNTableViewCellAccessoryDisclosureIndicator;
    HNTableViewCellData *itemData = self.dataSource[indexPath.row];
    cell.textLabel.text = itemData.title;
    cell.detailTextLabel.text = itemData.subTitle;
    cell.imageView.image = itemData.icon;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark ----------------------- 懒加载 --------------------
/*** view 属性 ***/
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.rowHeight = 60;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 13, 0, 0);
//        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

// tableHeaderView
- (HNContactSearchView*)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[HNContactSearchView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleHeight(122))];
    }
    return _tableHeaderView;
}

/*** 数据类型 属性 ***/
- (NSArray*)dataSource{
    if (!_dataSource) {
        _dataSource = @[[[HNTableViewCellData alloc] initWithTitle:@"雷达加朋友" subTitle:@"添加身边的朋友" iconName:@"add_friend_icon_reda"],
                        [[HNTableViewCellData alloc] initWithTitle:@"面对面建群" subTitle:@"与身边的朋友进入同一个群聊" iconName:@"add_friend_icon_addgroup"],
                        [[HNTableViewCellData alloc] initWithTitle:@"扫一扫" subTitle:@"扫描二维码名片" iconName:@"add_friend_icon_scanqr"],
                        [[HNTableViewCellData alloc] initWithTitle:@"手机联系人" subTitle:@"添加通讯录中的朋友" iconName:@"add_friend_icon_contacts"],
                        [[HNTableViewCellData alloc] initWithTitle:@"公众号" subTitle:@"获取更多资讯和服务" iconName:@"add_friend_icon_offical"]
                        ];
    }
    return _dataSource;
}

@end
