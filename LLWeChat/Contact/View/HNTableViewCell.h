//
//  HNTableViewCell.h
//  LLWeChat
//
//  Created by 谌文 on 17/10/5.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/********* 通用型cell *********/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HNTableViewCellStyle) {
    HNTableViewCellStyleDefault = UITableViewCellStyleDefault,      // 左图 中字
    HNTableViewCellStyleValue1 = UITableViewCellStyleValue1,        // 左图 中字  右字
    HNTableViewCellStyleValue2 = UITableViewCellStyleValue2,        // 左图 中字1 中字2
    HNTableViewCellStyleSubtitle = UITableViewCellStyleSubtitle,    // 左图 上字  下字
    
    HNTableViewCellStyleValueCenter = 1000,
    HNTableViewCellStyleValueLeft,
    HNTableViewCellStyleContactList,
    HNTableViewCellStyleContactSearchList
};


typedef NS_ENUM(NSInteger, HNTableViewCellAccessoryType) {
    HNTableViewCellAccessoryNone = UITableViewCellAccessoryNone,
    HNTableViewCellAccessoryDisclosureIndicator = UITableViewCellAccessoryDisclosureIndicator,
    HNTableViewCellAccessoryDetailDisclosureButton = UITableViewCellAccessoryDetailDisclosureButton,
    HNTableViewCellAccessoryCheckmark = UITableViewCellAccessoryCheckmark,
    HNTableViewCellAccessoryDetailButton = UITableViewCellAccessoryDetailButton,
    
    HNTableViewCellAccessorySwitch,
    HNTableViewCellAccessoryText,
};


@interface HNTableViewCell : UITableViewCell

/**设置 cell accessory 类型 (加入自定义类型)*/
@property (nonatomic, assign) HNTableViewCellAccessoryType          accessoryType_HN;

/**设置 创建cell */
+ (instancetype)cellWithStyle:(HNTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

/**获取  accessory 类型有Switch时 获取开关状态 */
- (BOOL)isSwitchOn;

/**设置  accessory 类型有Switch时 设置开关状态 */
- (void)setSwitchOn:(BOOL)on animated:(BOOL)animated;

/** accessory 类型 有label时 获取label text */
- (NSString *)rightTextValue;

/** accessory 类型 有label时 设置label text */
- (void)setRightTextValue:(NSString *)value;


@end


@interface UITableView (HNTableViewCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (HNTableViewCell*)createHNTableViewCellWithStyle:(HNTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

