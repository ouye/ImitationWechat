//
//  HNConversationListController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 消息列表控制器 **************/

#import "HNConversationListController.h"
#import "HNSearchViewController.h"                  // 搜索 控制器
#import "HNChatSearchController.h"

#import "HNSearchBar.h"
#import "HNConversationListCell.h"
#import "HNChatManager.h"
#import "HNConversationModel.h"

@interface HNConversationListController ()<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate,
HNSearchControllerDelegate,
HNChatManagerConversationListDelegate
>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, strong) UIView                            *tableHeaderView;
@property (nonatomic, strong) HNSearchBar                       *searchBar;


/*** 数据类型 属性 ***/
@property (nonatomic, strong) NSMutableArray<HNConversationModel *>     *allConversationModels;


@end

@implementation HNConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微信";
    
  
    // 获取环信 socket 链接状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionStateChanged:) name:HNConnectionStateDidChangedNotification object:nil];

    [self createView];
    
    //fetch data
    [self fetchData];
}



#pragma mark ---------------- CreateViewAndAddFrame ----------------

//加载view
- (void)createView{
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *plusItem = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                 action:@selector(plusButtonHandler:)];
    self.navigationItem.rightBarButtonItem = plusItem;
}


#pragma mark - 获取会话数据

- (void)fetchData {
    [HNChatManager sharedManager].conversationListDelegate = self;
    [[HNChatManager sharedManager] getAllConversationFromDB];
}

- (void)conversationListDidChanged:(NSArray<HNConversationModel *> *)conversationList {
    self.allConversationModels = [conversationList mutableCopy];
    [self.tableView reloadData];
//    [self setUnreadMessageCount];
}

- (NSMutableArray<HNConversationModel *> *)currentConversationList {
    return [self.allConversationModels mutableCopy];
}



#pragma mark ------- TableView Delegate/DataSource  -------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allConversationModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNConversationListCell *cell = [HNConversationListCell createHNConversationListCell:tableView reuseIdentifier:HNConversationListCellID];
    cell.conversationModel = self.allConversationModels[indexPath.row];
    return cell;
}


#pragma mark - 搜索 - delegate -----
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    HNSearchViewController *searchVC = [HNSearchViewController sharedInstance];
    HNBaseNavigationController *navigationVC = [[HNBaseNavigationController alloc] initWithRootViewController:searchVC];
    navigationVC.view.backgroundColor = [UIColor clearColor];
    searchVC.delegate = self;

    HNChatSearchController *resultController = [[HNChatSearchController alloc]init];
    searchVC.searchResultController = resultController;
    resultController.searchViewController = searchVC;
    [searchVC showInViewController:self fromSearchBar:self.searchBar];
    return NO;
}

#pragma mark - 搜索 - 即将显示 消失 delegate -----

- (void)willPresentSearchController:(HNSearchViewController *)searchController {
    
}

- (void)didPresentSearchController:(HNSearchViewController *)searchController {
    self.tableView.tableHeaderView = nil;
    CGRect frame = _tableHeaderView.frame;
    frame.origin.y = -frame.size.height;
    _tableHeaderView.frame = frame;
}

- (void)willDismissSearchController:(HNSearchViewController *)searchController {
    
    [UIView animateWithDuration:HIDE_ANIMATION_DURATION animations:^{
        _searchBar.hidden = YES;
        self.tableView.tableHeaderView = _tableHeaderView;
    } completion:^(BOOL finished) {
        _searchBar.hidden = NO;
    }];
}

- (void)didDismissSearchController:(HNSearchViewController *)searchController {
    //    _connectionAlertView.alpha = 0;
    //    for (UITableViewCell *cell in self.tableView.visibleCells) {
    //        cell.alpha = 0;
    //    }
    //    [UIView animateWithDuration:0.25 animations:^{
    //        _connectionAlertView.alpha = 1;
    //        for (UITableViewCell *cell in self.tableView.visibleCells) {
    //            cell.alpha = 1;
    //        }
    //    }];
}


#pragma ---- private menthod 私有方法 -----

//  环信 socket链接状态
- (void)connectionStateChanged:(NSNotification*)notification {
    BOOL isConnected = [notification.userInfo[@"connectionState"] integerValue] == HNConnectionStateConnected;
    if (!isConnected) {
        self.navigationItem.title = @"微信(未连接)";
    }else {
        self.navigationItem.title = @"微信";
    }
}


#pragma mark ----------------------- 懒加载 --------------------
/*** view 属性 ***/
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.rowHeight = 68;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

// searchBar
- (HNSearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar = [HNSearchBar defaultSearchBarWithFrame:CGRectMake(0, 0, ScreenWidth, HNSearchBardefaultHeight + 16)];
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


@end
