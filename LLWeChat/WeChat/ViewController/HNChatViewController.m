//
//  HNChatViewController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/22.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 聊天消息 控制器 **************/

#import "HNChatViewController.h"
#import "HNMessageModel.h"
//#import "HNMessageCellManager.h"

@interface HNChatViewController ()

/*** view 属性 ***/
@property (nonatomic, strong) UITableView               *tableView;

/*** 数据类型 属性 ***/
@property (nonatomic) NSMutableArray<HNMessageModel *>  *dataSource;

@end

@implementation HNChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView setAnimationsEnabled:NO];
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
    
}


#pragma mark --------- lazy Load UI 懒加载 UI -------------
/*** view 属性 ***/
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.rowHeight = 68;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);
        _tableView.contentInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollIndicatorInsets =  _tableView.contentInset;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
