//
//  HNTableViewCell.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/5.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/********* 通用型cell *********/

#import "HNTableViewCell.h"

#define CONTACT_CELL_IMAGE_SIZE 36

@interface HNTableViewCell ()

@property (nonatomic, assign) HNTableViewCellStyle          style;

@end

@implementation HNTableViewCell

+ (instancetype)cellWithStyle:(HNTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    HNTableViewCell *cell;
    switch (style) {
        case HNTableViewCellStyleValue1:
        case HNTableViewCellStyleValue2:
        case HNTableViewCellStyleSubtitle:
        case HNTableViewCellStyleDefault:
            cell = [[HNTableViewCell alloc] initWithStyle:(UITableViewCellStyle)style reuseIdentifier:reuseIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:TABLE_VIEW_CELL_DEFAULT_FONT_SIZE];
            break;
        case HNTableViewCellStyleValueCenter:
        case HNTableViewCellStyleContactList:
        case HNTableViewCellStyleValueLeft:
            cell = [[HNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:TABLE_VIEW_CELL_DEFAULT_FONT_SIZE];
            break;
        case HNTableViewCellStyleContactSearchList:
            cell = [[HNTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
//            cell.detailTextLabel.textColor = HNTextColor_lightGray_system;
            break;
    }
    
    cell.style = style;
    return cell;
}



/**设置 cell accessory 类型 (加入自定义类型)*/
- (void)setAccessoryType_HN:(HNTableViewCellAccessoryType)accessoryType_HN{
    _accessoryType_HN = accessoryType_HN;
   switch (accessoryType_HN) {
    case HNTableViewCellAccessoryNone:
        self.accessoryType = UITableViewCellAccessoryNone;
        break;
    case HNTableViewCellAccessoryDisclosureIndicator:
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        break;
    case HNTableViewCellAccessoryDetailButton:
        self.accessoryType = UITableViewCellAccessoryDetailButton;
        break;
    case HNTableViewCellAccessoryDetailDisclosureButton:
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        break;
    case HNTableViewCellAccessoryCheckmark:
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        break;
        
    case HNTableViewCellAccessoryText: {
        self.accessoryType = UITableViewCellAccessoryNone;
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        CGFloat fontSize = self.textLabel.font.pointSize;
        label.font = [UIFont systemFontOfSize:fontSize - 1];
        label.textAlignment = NSTextAlignmentCenter;
        self.accessoryView = label;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        break;
    case HNTableViewCellAccessorySwitch:
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = [[UISwitch alloc] init];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        break;
        
    default:
        break;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame;
    
    switch (self.style) {
        case HNTableViewCellStyleValueCenter: {
            [self.textLabel sizeToFit];
            frame = self.contentView.bounds;
            self.textLabel.center = CGPointMake(frame.size.width/2, frame.size.height/2);
            break;
        }
        case HNTableViewCellStyleContactList: {
            frame = CGRectMake(10, 0, CONTACT_CELL_IMAGE_SIZE, CONTACT_CELL_IMAGE_SIZE);
            frame.origin.y = (CGRectGetHeight(self.contentView.frame) - CONTACT_CELL_IMAGE_SIZE) / 2;
            self.imageView.frame = frame;
            
            [self.textLabel sizeToFit];
            frame = self.textLabel.frame;
            frame.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
            frame.origin.y = (CGRectGetHeight(self.contentView.frame) - CGRectGetHeight(frame)) / 2;
            self.textLabel.frame = frame;
            
            break;
        }
        case HNTableViewCellStyleContactSearchList: {
            
            
            break;
        }
        case HNTableViewCellStyleValueLeft: {
            [self.textLabel sizeToFit];
            frame = self.textLabel.frame;
            frame.origin.x = TABLE_VIEW_CELL_LEFT_MARGIN;
            frame.origin.y = (CGRectGetHeight(self.contentView.frame) - CGRectGetHeight(frame)) / 2;
            self.textLabel.frame = frame;
            break;
        }
        default:
            break;
    }
}


/**获取  accessory 类型有Switch时 获取开关状态 */
- (BOOL)isSwitchOn {
    if (self.accessoryView && [self.accessoryView isKindOfClass:[UISwitch class]]) {
        UISwitch *switcher = (UISwitch *)self.accessoryView;
        return switcher.on;
    }else {
        return NO;
    }
}

/**设置  accessory 类型有Switch时 设置开关状态 */
- (void)setSwitchOn:(BOOL)on animated:(BOOL)animated {
    if (self.accessoryView && [self.accessoryView isKindOfClass:[UISwitch class]]) {
        UISwitch *switcher = (UISwitch *)self.accessoryView;
        [switcher setOn:on animated:animated];
    }
}

/** accessory 类型 有label时 获取label text */
- (NSString *)rightTextValue {
    if (self.accessoryView && [self.accessoryView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.accessoryView;
        return label.text;
    }
    return nil;
}

/** accessory 类型 有label时 设置label text */
- (void)setRightTextValue:(NSString *)value {
    if (self.accessoryView && [self.accessoryView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.accessoryView;
        label.text = value;
        [label sizeToFit];
    }
}

@end


#pragma mark -

@implementation UITableView (HNTableViewCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (HNTableViewCell*)createHNTableViewCellWithStyle:(HNTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    HNTableViewCell *cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [HNTableViewCell cellWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

@end
