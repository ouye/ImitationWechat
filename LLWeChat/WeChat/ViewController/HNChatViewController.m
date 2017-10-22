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
#import "HNMessageCellManager.h"

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
    HNMessageModel *messageModel = self.dataSource[indexPath.row];
    NSString *reuseId = [[HNMessageCellManager sharedManager] reuseIdentifierForMessegeModel:messageModel];
    UITableViewCell *_cell;
    
    switch (messageModel.messageBodyType) {
        case kLLMessageBodyTypeText:
        case kLLMessageBodyTypeVideo:
        case kLLMessageBodyTypeVoice:
        case kLLMessageBodyTypeImage:
        case kLLMessageBodyTypeLocation: {
            LLMessageBaseCell *cell = [[LLMessageCellManager sharedManager] messageCellForMessageModel:messageModel tableView:tableView];
            cell.delegate = self;
            _cell = cell;
            break;
        }
        case kLLMessageBodyTypeDateTime: {
            LLMessageDateCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
            if (!cell) {
                cell = [[LLMessageDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            }
            
            [messageModel setNeedsUpdateForReuse];
            cell.messageModel = messageModel;
            _cell = cell;
            break;
        }
        case kLLMessageBodyTypeGif: {
            LLMessageGifCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseId];
            if (!cell) {
                cell = [[LLMessageGifCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
                [cell prepareForUse:messageModel.isFromMe];
            }
            
            [messageModel setNeedsUpdateForReuse];
            cell.messageModel = messageModel;
            cell.delegate = self;
            _cell = cell;
            break;
        }
        case kLLMessageBodyTypeRecording: {
            LLMessageRecordingCell *cell = [LLMessageRecordingCell sharedRecordingCell];
            [messageModel setNeedsUpdateForReuse];
            cell.messageModel = messageModel;
            
            _cell = cell;
            break;
        }
        default:
            break;
    }
    
    if ([messageModel checkNeedsUpdate]) {
        ((LLMessageBaseCell *)_cell).messageModel = messageModel;
    }
    
    if ([_cell isKindOfClass:[LLMessageBaseCell class]]) {
        LLMessageBaseCell *baseCell = (LLMessageBaseCell *)_cell;
        [baseCell setCellEditingAnimated:NO];
        if (baseCell.isCellSelected != messageModel.isSelected) {
            baseCell.isCellSelected = messageModel.isSelected;
        }
        
        switch(messageModel.messageBodyType) {
            case kLLMessageBodyTypeLocation: {
                if ([messageModel.address isEqualToString:LOCATION_UNKNOWE_ADDRESS] && !messageModel.isFetchingAddress) {
                    [self asyncReGeocodeForMessageModel:messageModel];
                }
                break;
            }
            case kLLMessageBodyTypeVoice: {
                LLMessageVoiceCell *voiceCell = (LLMessageVoiceCell *)_cell;
                if (messageModel.isMediaPlaying != voiceCell.isVoicePlaying) {
                    if (messageModel.isMediaPlaying) {
                        [voiceCell startVoicePlaying];
                    }else {
                        [voiceCell stopVoicePlaying];
                    }
                }
                
                break;
            }
            default:
                break;
        }
    }
    
    [UIView setAnimationsEnabled:YES];
    return _cell;
    
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
