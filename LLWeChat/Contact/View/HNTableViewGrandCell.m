//
//  HNTableViewGrandCell.m
//  LLWeChat
//
//  Created by chenwen on 2017/10/12.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

/*************  通用型 全功能形cell ****************/

#import "HNTableViewGrandCell.h"

@interface HNTableViewGrandCell  ()

@property (nonatomic, assign) HNTableViewGrandCellStyle          style;

@end

@implementation HNTableViewGrandCell


+ (instancetype)cellWithStyle:(HNTableViewGrandCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    HNTableViewGrandCell *cell;
    switch (style) {
        case HNTableViewGrandCellStyleDefault:
        case HNTableViewGrandCellStyleValue1:
        case HNTableViewGrandCellStyleValue2:
        case HNTableViewGrandCellStyleSubtitle:
            cell = [[HNTableViewGrandCell alloc] initWithStyle:(UITableViewCellStyle)style reuseIdentifier:reuseIdentifier];
            break;
        case HNTableViewGrandCellStyleValueCenter:
        case HNTableViewGrandCellStyleValueLeft:
        case HNTableViewGrandCellStyleContactList:
            cell = [[HNTableViewGrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            break;
        case HNTableViewGrandCellStyleContactSearchList:
            cell = [[HNTableViewGrandCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
            break;
        }
    cell.style = style;
    return cell;
}










@end


#pragma mark -

@implementation UITableView (HNTableViewGrandCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (HNTableViewGrandCell*)createHNTableViewGrandCellWithStyle:(HNTableViewGrandCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    HNTableViewGrandCell *cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [HNTableViewGrandCell cellWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

@end
