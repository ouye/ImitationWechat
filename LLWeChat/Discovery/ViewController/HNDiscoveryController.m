//
//  HNDiscoveryController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 发现控制器 **************/

#import "HNDiscoveryController.h"
#import "HNTableViewCellData.h"
#import "HNTableViewCell.h"

@interface HNDiscoveryController ()<UITableViewDelegate, UITableViewDataSource>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                               *tableView;

/*** 数据类型 属性 ***/
@property (nonatomic) NSArray<NSArray<HNTableViewCellData *> *>         *dataSource;

@end

@implementation HNDiscoveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    [self createCellData];
    [self createView];
}

#pragma mark --------- CreateViewAndAddFrame ------------


//加载view
- (void)createView{
    
    [self.view addSubview:self.tableView];
}


// 设置cell数据
- (void)createCellData{
    NSArray<HNTableViewCellData *> *section1 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"朋友圈" iconName:@"ff_IconShowAlbum"]
                                                 ];
    
    NSArray<HNTableViewCellData *> *section2 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"扫一扫" iconName:@"ff_IconQRCode"],
                                                 [[HNTableViewCellData alloc] initWithTitle:@"摇一摇" iconName:@"ff_IconShake"]
                                                 ];
    
    NSArray<HNTableViewCellData *> *section3 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"附近的人" iconName:@"ff_IconLocationService"],
                                                 [[HNTableViewCellData alloc] initWithTitle:@"漂流瓶" iconName:@"ff_IconBottle"]
                                                 ];
    
    NSArray<HNTableViewCellData *> *section4 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"购物" iconName:@"MoreMyBankCard"],
                                                 [[HNTableViewCellData alloc] initWithTitle:@"游戏" iconName:@"MoreGame"]
                                                 ];
    
    self.dataSource = @[section1, section2, section3, section4];
}


#pragma mark ------- TableView Delegate/DataSource  -------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 15;
    else
        return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TABLE_SECTION_HEIGHT_ZERO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNTableViewCell *cell = [tableView createHNTableViewCellWithStyle:HNTableViewCellStyleDefault reuseIdentifier:@"DiscoveryCellID"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    HNTableViewCellData *itemData = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = itemData.title;
    cell.imageView.image = itemData.icon;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark ----------------------- 懒加载 --------------------
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.rowHeight = 44;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    }
    return _tableView;
}


@end
