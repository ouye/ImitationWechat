//
//  HNConversationListController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 消息列表控制器 **************/

#import "HNConversationListController.h"
#import "HNConversationModel.h"
#import "HNConversationListCell.h"

@interface HNConversationListController ()<UITableViewDelegate, UITableViewDataSource>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                               *tableView;

/*** 数据类型 属性 ***/
@property (nonatomic, strong) NSMutableArray<HNConversationModel *>     *allConversationModels;


@end

@implementation HNConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微信";
    
   

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




#pragma mark ----------------------- 懒加载 --------------------
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
    }
    return _tableView;
}



@end
