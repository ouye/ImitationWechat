//
//  HNTableViewGrandCell.h
//  LLWeChat
//
//  Created by chenwen on 2017/10/12.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*************  通用型 全功能形cell ****************/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HNTableViewGrandCellStyle) {
    // 修改的是父类的控件
    HNTableViewGrandCellStyleDefault = UITableViewCellStyleDefault,         // 左图 中字
    HNTableViewGrandCellStyleValue1 = UITableViewCellStyleValue1,           // 左图 中字  右字
    HNTableViewGrandCellStyleValue2 = UITableViewCellStyleValue2,           // 左图 中字1 中字2
    HNTableViewGrandCellStyleSubtitle = UITableViewCellStyleSubtitle,       // 左图 上字  下字
    
    HNTableViewGrandCellStyleValueCenter = 1000,
    HNTableViewGrandCellStyleValueLeft,
    HNTableViewGrandCellStyleContactList,
    HNTableViewGrandCellStyleContactSearchList,
    
    // 新增的控件
    HNLeftLabelTightTextFieldStyle                                          // 做label 右 UITextField
    
};

typedef NS_ENUM(NSInteger,HNTableViewGrandCellAccessoryType) {
    HNTableViewGrandCellAccessoryNone = UITableViewCellAccessoryNone,
    HNTableViewGrandCellAccessoryDisclosureIndicator = UITableViewCellAccessoryDisclosureIndicator,
    HNTableViewGrandCellAccessoryDetailDisclosureButton = UITableViewCellAccessoryDetailDisclosureButton,
    HNTableViewGrandCellAccessoryCheckmark = UITableViewCellAccessoryCheckmark,
    HNTableViewGrandCellAccessoryDetailButton = UITableViewCellAccessoryDetailButton,
    
    HNTableViewGrandCellAccessorySwitch,
    HNTableViewGrandCellAccessoryText,
};


@interface HNTableViewGrandCell : UITableViewCell


@property (nonatomic, strong) UILabel                            *leftLabel;  // leftLabel
@property (nonatomic, strong) UITextField                        *textField;  // textField

@end


@interface UITableView (HNTableViewGrandCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (HNTableViewGrandCell*)createHNTableViewGrandCellWithStyle:(HNTableViewGrandCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
