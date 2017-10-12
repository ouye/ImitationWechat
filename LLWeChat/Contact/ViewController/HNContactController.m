//
//  HNContactController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/5.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 联系人 控制器 **************/

#import "HNContactController.h"
#import "HNContactAddController.h"              // 添加朋友控制器
#import "HNContactDetailsController.h"          // 联系人 详细资料控制器
#import "HNSearchBar.h"

#import "HNContactModel.h"
#import "HNTableViewCell.h"
#import "HNContactManager.h"

@interface HNContactController ()<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate
>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                           *tableView;
@property (nonatomic, strong) UIView                                *tableHeaderView;
@property (nonatomic, strong) HNSearchBar                           *searchBar;

/*** 数据类型 属性 ***/
@property (nonatomic, strong) NSMutableArray<NSMutableArray<HNContactModel *>*> *dataArray;
@property (nonatomic, strong) NSMutableArray<HNContactModel *>                  *contactSource;
@property (nonatomic, strong) NSMutableArray<NSString *>                        *sectionTitles;

@end

@implementation HNContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    [self createView];
    [self getDataFromServer];  //  获取联系人列表
    
    // 有好友添加请求通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactChangedNotification:) name:HNContactChangedNotification object:[HNContactManager sharedManager]];
}



#pragma mark ----------------------- CreateViewAndAddFrame --------------------

//加载view
- (void)createView{
    [self.view addSubview:self.tableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriend:)];
    self.navigationItem.rightBarButtonItem = item;
}

//设置约束
- (void)addFrame:(CGRect)frame{
}

#pragma mark - 好友 -

// 有好友添加请求通知
- (void)contactChangedNotification:(NSNotification *)notification {
    [self getDataFromServer];
}

// 跳转添加朋友 控制器
- (void)addFriend:(id)sender {
    HNContactAddController *vc = [[HNContactAddController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma ----  服务区中获取数据  -----
- (void)getDataFromServer{

    WEAK_SELF;
    [[HNContactManager sharedManager] asynGetContactsFromServer:^(NSArray<HNContactModel *> *contacts) {
        [weakSelf processData:contacts];
    }];
}

/**
 *   将联系人 进行按a－z和＃顺序 每个字母 一个数组 的顺序 排序 如 微信 联系人
 */
- (void)processData:(NSArray<HNContactModel *> *)contacts {
    self.contactSource = [contacts mutableCopy];
    [self.dataArray removeAllObjects];
    [self.sectionTitles removeAllObjects];
    
    // 建立索引的核心, 返回27，是a－z和＃
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    // 加入 a－z和＃的标识符
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    NSInteger highSection = [self.sectionTitles count];
    // 建立 每个分区里 联系人数组
    NSMutableArray<NSMutableArray<HNContactModel *> *> *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray<HNContactModel *> *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    // 按首字母分组
    for (HNContactModel *model in self.contactSource) {
        NSUInteger sectionIndex = [indexCollation sectionForObject:model collationStringSelector:@selector(userName)];
        [sortedArray[sectionIndex] addObject:model];
    }
    
    // 每个section内的数组排序
    for (NSUInteger index = 0; index < highSection; index++) {
        NSMutableArray<HNContactModel *> *personsForSection = sortedArray[index];
        NSArray *sortedPersonsForSection = [indexCollation sortedArrayFromArray:personsForSection collationStringSelector:@selector(userName)];
        sortedArray[index] = [sortedPersonsForSection mutableCopy];
    }
    
    // 去掉空的section
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitles = [NSMutableArray new];  // 重新 设置 a-z和＃
    
    [sortedArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitles addObject:[indexCollation sectionTitles][idx]];
        }
    }];
    // 清除 没有 联系人的 数组
    [sortedArray removeObjectsInArray:temp];
    
    [self.sectionTitles insertObject:UITableViewIndexSearch atIndex:0];
    [self.dataArray addObjectsFromArray:sortedArray];
    [self.tableView reloadData];
}



#pragma mark ----------- TableView delegate -----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else {
        return self.dataArray[section-1].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *HNTableViewCellID = @"tableViewCellStyleContactListID";
    HNTableViewCell *cell = [tableView createHNTableViewCellWithStyle:HNTableViewCellStyleContactList reuseIdentifier:HNTableViewCellID];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"新的朋友";
            cell.imageView.image = [UIImage imageNamed:@"plugins_FriendNotify"];
        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"群聊";
            cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
        }else if (indexPath.row == 2) {
            cell.textLabel.text = @"标签";
            cell.imageView.image = [UIImage imageNamed:@"Contact_icon_ContactTag"];
        }else if (indexPath.row == 3) {
            cell.textLabel.text = @"公众号";
            cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_offical"];
        }
    }else {
        HNContactModel *userModel = self.dataArray[indexPath.section - 1][indexPath.row];
        cell.textLabel.text = userModel.userName;
        cell.imageView.image = userModel.avatarImage;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HNContactDetailsController  *ContactDetailVC = [[HNContactDetailsController alloc]init];
    [self.navigationController pushViewController:ContactDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return TABLE_SECTION_HEIGHT_ZERO;
    else
        return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TABLE_SECTION_HEIGHT_ZERO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return nil;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = UIColorRGB(241, 240, 246);
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = kLLTextColor_lightGray_system;
    [label setText:[self.sectionTitles objectAtIndex:(section)]];
    [contentView addSubview:label];
    return contentView;
}


#pragma mark - Section Titles - 分区头 标题

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (index == 0) {
        return  -1;
    }
    return index;
}


#pragma mark ----------------------- 懒加载 --------------------
/*** view 属性 ***/
// tableView
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.rowHeight = 56;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.tableHeaderView = self.tableHeaderView;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    }
    return _tableView;
}

// searchBar
- (HNSearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar = [HNSearchBar defaultSearchBarWithFrame:CGRectMake(0, 0, ScreenWidth - 10, HNSearchBardefaultHeight + 16)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
    }
    return _searchBar;
}

// tableHeaderView
- (UIView*)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.searchBar.height)];
        [_tableHeaderView addSubview:self.searchBar];
    }
    return _tableHeaderView;
}

/*** 数据类型 属性 ***/
// 联系人数组
- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

//  A-Z和# 标注数组
- (NSMutableArray*)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles = [[NSMutableArray alloc]init];
    }
    return _sectionTitles;
}

@end
