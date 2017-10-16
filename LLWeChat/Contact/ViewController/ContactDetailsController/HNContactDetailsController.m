//
//  HNContactDetailsController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/************** 联系人 详细资料控制器 **************/

#import "HNContactDetailsController.h"
#import "HNPersonalDetailsCell.h"
#import "HNTableViewCell.h"

@interface HNContactDetailsController ()<
UITableViewDelegate,
UITableViewDataSource
>

/*** view 属性 ***/
@property (nonatomic, strong) UITableView                           *tableView;

/*** 数据类型 属性 ***/
@property (nonatomic, strong) NSMutableArray                        *dataArray;

@end

@implementation HNContactDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


#pragma mark ----------- TableView delegate -----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            HNPersonalDetailsCell *cell = [HNPersonalDetailsCell cellWithTableView:tableView reuseIdentifier:@"HNPersonalDetailsCellID"];
            return cell;
        }
            break;
        case 1:{
            HNTableViewCell     *cell = [tableView createHNTableViewCellWithStyle:HNTableViewCellStyleValueLeft reuseIdentifier:@"HNTableViewCellID"];
            cell.accessoryType_HN = HNTableViewCellAccessoryDisclosureIndicator;
            return cell;

        }break;
            
        default:
            break;
    }
    return nil;
}


#pragma mark ----------------- 懒加载 --------------------
/*** view 属性 ***/
// tableView
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight ) style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.rowHeight = 56;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

/*** 数据类型 属性 ***/
- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
