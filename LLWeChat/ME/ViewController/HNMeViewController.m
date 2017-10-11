//
//  HNMeViewController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 我 控制器 **************/

#import "HNMeViewController.h"
#import "HNTableViewCell.h"
#import "HNTableViewCellData.h"
#import "HNTableViewMeCell.h"
#import "HNUserProfile.h"

@interface HNMeViewController ()<UITableViewDelegate, UITableViewDataSource>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                               *tableView;

/*** 数据类型 属性 ***/
@property (nonatomic, strong) NSArray<NSArray<HNTableViewCellData *> *>     *dataSource;

@end

@implementation HNMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self createCellData];
    [self createView];
}
#pragma mark --------- CreateViewAndAddFrame ------------




//加载view
- (void)createView{
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"我　" style:UIBarButtonItemStylePlain target:nil
                                             action:nil];
    
    [self.view addSubview:self.tableView];
}


// 设置cell数据
- (void)createCellData{
    NSArray<HNTableViewCellData *> *section1 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"相册" iconName:@"MoreMyAlbum"],
                                                 [[HNTableViewCellData alloc] initWithTitle:@"收藏" iconName:@"MoreMyFavorites"],
                                                 [[HNTableViewCellData alloc] initWithTitle:@"钱包" iconName:@"MoreMyBankCard"],
                                                 [[HNTableViewCellData alloc] initWithTitle:@"卡包" iconName:@"MyCardPackageIcon"],
                                                 ];
    
    NSArray<HNTableViewCellData *> *section2 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"表情" iconName:@"MoreExpressionShops"],
                                                 ];
    
    NSArray<HNTableViewCellData *> *section3 = @[
                                                 [[HNTableViewCellData alloc] initWithTitle:@"设置" iconName:@"MoreSetting"],
                                                 ];
    
    self.dataSource = @[section1, section2, section3];
}


    
#pragma mark ------- TableView Delegate/DataSource  -------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else
        return self.dataSource[section-1].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HNTableViewMeCell *cell = [HNTableViewMeCell createNTableViewMeCellWith:tableView reuseIdentifier:@"HNTableViewMeCellID"];
          return cell;
        cell.avatarImage.image = [UIImage imageNamed:[HNUserProfile sharedInstance].avatarURL];
        cell.nickNameLabel.text = [HNUserProfile sharedInstance].nickName;
        cell.WeChatIDLabel.text = [NSString stringWithFormat:@"微信号: %@", [HNUserProfile sharedInstance].userName];

        return cell;
    }else {
        HNTableViewCell  *cell = [tableView createHNTableViewCellWithStyle:HNTableViewCellStyleDefault reuseIdentifier:@"HNTableViewCellID"];
        HNTableViewCellData *itemData = self.dataSource[indexPath.section-1][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = itemData.title;
        cell.imageView.image = itemData.icon;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 88;
    else
        return 44;
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


#pragma mark ----------------------- 懒加载 --------------------
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    }
    return _tableView;
}

@end
