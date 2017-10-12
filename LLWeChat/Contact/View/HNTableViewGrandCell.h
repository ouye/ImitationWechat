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
    HNTableViewGrandCellStyleDefault = UITableViewCellStyleDefault,
    HNTableViewGrandCellStyleValue1 = UITableViewCellStyleValue1,
    HNTableViewGrandCellStyleValue2 = UITableViewCellStyleValue2,
    HNTableViewGrandCellStyleSubtitle = UITableViewCellStyleSubtitle,
    
    HNTableViewGrandCellStyleValueCenter = 1000,
    HNTableViewGrandCellStyleValueLeft,
    HNTableViewGrandCellStyleContactList,
    HNTableViewGrandCellStyleContactSearchList,
    
    HNLeftLabelTightTextFieldStyle
    
};


@interface HNTableViewGrandCell : UITableViewCell


@property (nonatomic, strong) UILabel                            *leftLabel;  // leftLabel
@property (nonatomic, strong) UITextField                        *textField;  // textField

@end


@interface UITableView (HNTableViewGrandCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (HNTableViewGrandCell*)createHNTableViewGrandCellWithStyle:(HNTableViewGrandCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
